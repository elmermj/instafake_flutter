import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/core/providers/timeline_provider.dart';
import 'package:instafake_flutter/services/user_data_service.dart';
import 'package:instafake_flutter/utils/log.dart';
import 'package:provider/provider.dart';

class HomeTimelineScreen extends StatelessWidget {
  HomeTimelineScreen({super.key});

  final userService = Get.find<UserDataService>();

  @override
  Widget build(BuildContext context) {
    UserModel? userData = userService.userModel;
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
      body: Consumer<PostProvider>(
        builder: (context, postProvider, _) {
          return NotificationListener<ScrollNotification>(
            child: ListView.builder(
              itemCount: postProvider.posts.length + (postProvider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == postProvider.posts.length) {
                  if (postProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                      child: Text('No more posts'),
                    );
                  }
                }
                final post = postProvider.posts[index];
                return ListTile(
                  title: Text(post.caption),
                  subtitle: Text('By ${post.username}'),
                );
              },
            ),
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                !postProvider.isLoading) {
                postProvider.getTimeline(userData!.username);
              }
              return false;
            },
          );
        },
      ),
    );
  }
}