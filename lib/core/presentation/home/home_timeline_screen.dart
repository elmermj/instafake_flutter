import 'package:flutter/material.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/core/providers/home_provider.dart';
import 'package:instafake_flutter/widgets/empty_timeline_notice.dart';

class HomeTimelineScreen extends StatelessWidget {
  final HomeProvider provider;
  final UserModel? userData;
  const HomeTimelineScreen({
    super.key,
    required this.userData, required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: provider.posts.isEmpty ? const Center(
        child: EmptyTimelineNotice(),
      ):
      ListView.builder(
        itemCount: provider.posts.length + (provider.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == provider.posts.length && provider.posts.isNotEmpty) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(
                child: Text('No more posts'),
              );
            }
          }
          final post = provider.posts[index];
          return ListTile(
            title: Text(post.caption),
            subtitle: Text('By ${post.username}'),
          );
        },
      ),
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            !provider.isLoading &&
            provider.hasMore) {
          provider.getTimeline(userData!.username);
        }
        return false;
      },
    );
  }
}