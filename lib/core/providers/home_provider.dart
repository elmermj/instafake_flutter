import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instafake_flutter/core/data/models/post_model.dart';
import 'package:instafake_flutter/core/data/models/post_thumbnail_model.dart';
import 'package:instafake_flutter/core/domain/repos/post_model_repository.dart';

class HomeProvider extends ChangeNotifier {
  final PostModelRepository _postService;
  
  List<PostModel> _posts = [];
  List<PostThumbnailModel> _explorePosts = [];
  int _timelinePage = 0;
  final int _timelinePageSize = 20;
  int _explorePage = 0;
  final int _explorePageSize = 40;
  bool _isLoading = false;
  bool _hasMore = true;
  int _index = 0;

  HomeProvider({required PostModelRepository postModelRepository}) : _postService = postModelRepository;

  List<PostModel> get posts => _posts;
  List<PostThumbnailModel> get explorePosts => _explorePosts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  int get index => _index;

  Future<void> getTimeline(String username) async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final result = await _postService.getTimeline(username, _timelinePage, _timelinePageSize);

      result.fold(
        (exception) {
          _isLoading = false;
          notifyListeners();
          Get.snackbar('Error', "Timeline retrieval error: $exception");
        },
        (posts) {
          _timelinePage++;
          _hasMore = posts.length == _timelinePageSize;
          _posts.addAll(posts);
          _isLoading = false;
          notifyListeners();
        }
      );
    } on Exception catch (e) {
      _isLoading = false;
      notifyListeners();
      Get.snackbar('Exception', e.toString());
    }
  }

  Future<void> getExplore() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final result = await _postService.getExplore(_explorePage, _explorePageSize);

      result.fold(
        (exception){
          Get.snackbar('Error', "Timeline retrieval error : $exception");
        },
        (posts){
          _explorePage++;
          _isLoading = false;
          _hasMore = posts.length == _explorePageSize;
          _explorePosts.addAll(posts);
        }
      );
      _isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      _isLoading = false;
      notifyListeners();
      Get.snackbar('Exception', e.toString());
    }
  }

  void changeIndex(int input){
    _index = input;
    notifyListeners();
  }
}
