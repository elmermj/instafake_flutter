import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instafake_flutter/core/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomeExploreScreen extends StatelessWidget {
  final HomeProvider provider;
  HomeExploreScreen({super.key, required this.provider});

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (homeProvider.explorePosts.isEmpty) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        homeProvider.getExplore();
      });
    }
    return GridView.builder(
      itemCount: homeProvider.explorePosts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
      itemBuilder: (context, index) => SizedBox(
        width: Get.width / 3,
        height: Get.width / 3,
        child: Image.network(
          provider.explorePosts[index].fileUrl,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ) ,
      )    
    );
  }
}