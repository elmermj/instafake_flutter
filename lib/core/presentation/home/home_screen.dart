import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/core/presentation/home/home_explore_screen.dart';
import 'package:instafake_flutter/core/presentation/home/home_timeline_screen.dart';
import 'package:instafake_flutter/core/providers/home_provider.dart';
import 'package:instafake_flutter/services/user_data_service.dart';
import 'package:instafake_flutter/utils/log.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final userService = Get.find<UserDataService>();

  @override
  Widget build(BuildContext context) {
    UserModel? userData = userService.userModel;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Log.green("METADATA NAME ::: ${userData?.realname}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${userData?.realname} Timeline",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        )
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) {
          switch(value.index){
            case 0 : 
              return HomeTimelineScreen(userData: userData, provider: value);

            case 1 :
              return HomeExploreScreen(provider: value,);

            case 2 :
              return const Center(child: Text('Post Something'),);

            case 3 :
              return const Center(child: Text('Profile'),);

            default:
              break;
          }
          return const Stack(children: [],);
        },
      ),
      bottomNavigationBar: SizedBox(
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
                        color: value.index==0? colorScheme.primaryContainer : colorScheme.onSurface,
                        fontWeight: value.index==0?FontWeight.bold:FontWeight.normal,
                        fontSize: value.index==0?12:8
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
                        color: value.index==1? colorScheme.primaryContainer : colorScheme.onSurface,
                        fontWeight: value.index==1?FontWeight.bold:FontWeight.normal,
                        fontSize: value.index==1?12:8
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
                    onPressed: () => value.changeIndex(2),
                    child: Text(
                      'Post',
                      style: TextStyle(
                        color: value.index==2? colorScheme.primaryContainer : colorScheme.onSurface,
                        fontWeight: value.index==2?FontWeight.bold:FontWeight.normal,
                        fontSize: value.index==2?12:8
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
                        color: value.index==3? colorScheme.primaryContainer : colorScheme.onSurface,
                        fontWeight: value.index==3?FontWeight.bold:FontWeight.normal,
                        fontSize: value.index==3?12:8
                      )
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}