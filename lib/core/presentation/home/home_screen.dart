import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/core/presentation/camera/camera_gallery_screen.dart';
import 'package:instafake_flutter/core/presentation/camera/camera_screen.dart';
import 'package:instafake_flutter/core/presentation/home/home_explore_screen.dart';
import 'package:instafake_flutter/core/presentation/home/home_profile_screen.dart';
import 'package:instafake_flutter/core/presentation/home/home_search_screen.dart';
import 'package:instafake_flutter/core/presentation/home/home_timeline_screen.dart';
import 'package:instafake_flutter/core/providers/camera_provider.dart';
import 'package:instafake_flutter/core/providers/home_provider.dart';
import 'package:instafake_flutter/services/user_data_service.dart';
import 'package:instafake_flutter/utils/log.dart';
import 'package:instafake_flutter/widgets/custom_text_field.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userService = Get.find<UserDataService>();

  @override
  void initState() {
    super.initState();
    Provider.of<CameraProvider>(context, listen: false).initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? userData = userService.userModel;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Log.green("METADATA NAME ::: ${userData?.realname}");
    return Consumer<HomeProvider>(
      builder: (context, value, child) => Scaffold(
        drawerEdgeDragWidth: Get.width * 0.2,
        drawer: value.index == 0
          ? Drawer(
              width: Get.width,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)
              ),
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(24)
                ),
                child: const CameraScreen()
              )
            )
          : null,
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  LucideIcons.camera,
                  size: 24,
                ),
              );
            }
          ),
          centerTitle: true,
          title: value.index == 1 || value.index == 4
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorScheme.surface,
                ),
                child: CustomTextField(
                  controller: value.searchController,
                  color: colorScheme.onSurface,
                  filled: true,
                  hintText: 'Search something',
                  onSubmitted: (query) {
                    value.searchUsers(query);
                    if (value.index == 1) value.changeIndex(4);
                  },
                ),
              )
            : const Text(
                "Instafake",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
        ),
        body: _buildBody(value.index, userData, value),
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight / 1.5,
          child: Consumer<HomeProvider>(
            builder: (buildContext, value, child) {
              return Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        )
                      ),
                      onPressed: () => value.changeIndex(0),
                      child: Text(
                        'Timeline',
                        style: TextStyle(
                          color: value.index == 0 ? colorScheme.primaryContainer : colorScheme.onSurface,
                          fontWeight: value.index == 0 ? FontWeight.bold : FontWeight.normal,
                          fontSize: value.index == 0 ? 12 : 8
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        )
                      ),
                      onPressed: () => value.changeIndex(1),
                      child: Text(
                        'Explore',
                        style: TextStyle(
                          color: value.index == 1 ? colorScheme.primaryContainer : colorScheme.onSurface,
                          fontWeight: value.index == 1 ? FontWeight.bold : FontWeight.normal,
                          fontSize: value.index == 1 ? 12 : 8
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        )
                      ),
                      onPressed: () async {
                        await PhotoManager.requestPermissionExtend().then(
                          (PermissionState state) {
                            if (state == PermissionState.authorized) {
                              Get.to(() => const CameraGalleryScreen());
                            }
                          }
                        );
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(
                          color: value.index == 2 ? colorScheme.primaryContainer : colorScheme.onSurface,
                          fontWeight: value.index == 2 ? FontWeight.bold : FontWeight.normal,
                          fontSize: value.index == 2 ? 12 : 8
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        )
                      ),
                      onPressed: () => value.changeIndex(3),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: value.index == 3 ? colorScheme.primaryContainer : colorScheme.onSurface,
                          fontWeight: value.index == 3 ? FontWeight.bold : FontWeight.normal,
                          fontSize: value.index == 3 ? 12 : 8
                        )
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Widget _buildBody(int index, UserModel? userData, HomeProvider value) {
    switch (index) {
      case 0:
        return HomeTimelineScreen(userData: userData, provider: value);
      case 1:
        return HomeExploreScreen(provider: value);
      case 3:
        return const HomeProfileScreen();
      case 4:
        return const HomeSearchScreen();
      default:
        return const SizedBox(); // or any default widget
    }
  }
}
