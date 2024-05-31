import 'package:hive/hive.dart';
import 'package:instafake_flutter/core/data/models/post_model.dart';
import 'package:instafake_flutter/dependency_injection.dart';
import 'package:instafake_flutter/utils/constants.dart';

class LocalPostModelDataSource {
  final Box<PostModel> postMetadataBox;

  LocalPostModelDataSource(this.postMetadataBox);

  Future<void> savePostMetadata(PostModel response, int postId) async {
    if(!postMetadataBox.containsKey("${POST_KEY}_$postId")) await postMetadataBox.put("${POST_KEY}_$postId", response);
    DependencyInjection.autoCleanCachedData<PostModel>(postMetadataBox, 50);
  }

}