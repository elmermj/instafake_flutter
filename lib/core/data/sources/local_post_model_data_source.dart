import 'package:hive/hive.dart';
import 'package:instafake_flutter/core/data/models/post_model.dart';
import 'package:instafake_flutter/core/data/models/post_thumbnail_model.dart';
import 'package:instafake_flutter/dependency_injection.dart';
import 'package:instafake_flutter/utils/constants.dart';

class LocalPostModelDataSource {
  final Box<PostModel> postMetadataBox;
  final Box<PostThumbnailModel> postThumbnailMetadataBox;

  LocalPostModelDataSource(this.postMetadataBox, this.postThumbnailMetadataBox);

  Future<void> savePostMetadata(PostModel response, int postId) async {
    if(!postMetadataBox.containsKey("${POST_KEY}_$postId")) await postMetadataBox.put("${POST_KEY}_$postId", response);
    DependencyInjection.autoCleanCachedData<PostModel>(postMetadataBox, 50);
  }

  Future<void> savePostThumbnailMetadata(PostThumbnailModel response, int postId) async {
    if(!postThumbnailMetadataBox.containsKey("${POST_KEY}_$postId")) await postThumbnailMetadataBox.put("${POST_KEY}_$postId", response);
    DependencyInjection.autoCleanCachedData<PostModel>(postMetadataBox, 50);
  }

}