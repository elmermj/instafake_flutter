import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/core/presentation/home/home_post_detail_screen.dart';
import 'package:instafake_flutter/core/providers/home_provider.dart';
import 'package:instafake_flutter/services/user_data_service.dart';
import 'package:instafake_flutter/utils/constants.dart';
import 'package:instafake_flutter/widgets/empty_timeline_notice.dart';
import 'package:instafake_flutter/widgets/post_image_widget.dart';
import 'package:instafake_flutter/widgets/profile_handler_widget.dart';
import 'package:instafake_flutter/widgets/story_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeTimelineScreen extends StatefulWidget {
  final HomeProvider provider;
  final UserModel? userData;
  const HomeTimelineScreen({
    super.key,
    required this.userData,
    required this.provider,
  });

  @override
  State<HomeTimelineScreen> createState() => _HomeTimelineScreenState();
}

class _HomeTimelineScreenState extends State<HomeTimelineScreen> {
  final userData = Get.find<UserDataService>().userDataBox.get(METADATA_KEY);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false)
          .getTimeline(userData!.username);

      Provider.of<HomeProvider>(context, listen: false)
          .getStories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);

    return homeProvider.posts.isEmpty


  ? RefreshIndicator(
      onRefresh: () async =>
          await homeProvider.getTimeline(userData!.username),
      child: const Center(
        child: EmptyTimelineNotice(),
      ),
    )



  : RefreshIndicator(
      onRefresh: () async => await homeProvider.getTimeline(userData!.username),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: width,
              height: height / 5,
              margin: const EdgeInsets.all(8),
              child: homeProvider.stories.isEmpty
            ? const Center(
                child: Text(
                  "No stories yet",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: homeProvider.stories.length,
                itemBuilder: (context, index) {
                  final story = homeProvider.stories[index];
                  return StoryWidget(width: width, story: story);
                },
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: homeProvider.posts.length + (homeProvider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == homeProvider.posts.length && homeProvider.posts.isNotEmpty) {
                  if (homeProvider.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator());
                  } else {
                    return const Center(
                      child: Text('No more posts'),
                    );
                  }
                }
                final post = homeProvider.posts[index];
                bool isLiked = post.isLiked!;

                return Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileHandlerWidget(
                        picUrl: post.creatorProfPicUrl,
                        username: post.creatorUsername,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [PostImageWidget(url: SERVER_URL + post.fileUrl, width: width, height: height),],
                      ),
                      SizedBox(
                        width: width,
                        height: 45,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async => await homeProvider.addLike(post.id.toString(),userData!.id.toString(), index),
                              icon: Icon(isLiked? Icons.favorite: Icons.favorite_border_outlined,)
                            ),
                            IconButton(
                              onPressed: () {
                                homeProvider.currentPost = post;
                                Get.to(() => HomePostDetailScreen(post: post,));
                              },
                              icon: const Icon(LucideIcons.messageCircle))
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        padding:const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(post.likeUserIds!.isEmpty? 'No one has liked this post': post.likeUserIds!.length.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            post.isCaptionExpanded!
                          ? Text(
                              post.caption,
                              style: const TextStyle(
                                  fontSize: 16),
                            )
                          : Text(
                              post.caption,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16),
                            ),
                            if (post.caption.split('\n').length > 3)
                            TextButton(
                              onPressed: () {
                                homeProvider.toggleCaptionExpansion(index);
                              },
                              child: Text(
                                post.isCaptionExpanded!
                                    ? "Show less"
                                    : "Show more",
                              ),
                            ),
                          ],
                        ),
                      ),
                      post.comments!.length > 2
                    ? TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: () {
                          homeProvider.toggleCommentExpansion(index);
                        },
                        child: Text(post.isCommentExpanded!? "Show less": "Show ${(post.comments!.length - 2)} more comments",),
                      )
                    : const SizedBox.shrink(),

                      if(post.comments!.isNotEmpty && post.comments != null)
                      post.isCommentExpanded!
                    ? SizedBox(
                        width: width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: post.comments!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, commentIndex) {
                            final comment = post.comments![commentIndex];
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ProfileHandlerWidget(
                                  username: comment.author,
                                  picUrl: comment.commenterProfPic,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  comment.comment,
                                  textAlign: TextAlign.right,
                                )
                              ],
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        width: width,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: post.comments!.length < 2 ? 1 : 2,
                          itemBuilder: (context, commentIndex) {
                            final comment = post.comments![commentIndex];
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ProfileHandlerWidget(
                                  username: comment.author,
                                  picUrl: comment.commenterProfPic,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  comment.comment,
                                  textAlign: TextAlign.right,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: width,
                        child: Text(
                          timeago.format(post.createdAt),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
