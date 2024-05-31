import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:instafake_flutter/core/data/models/post_model.dart';
import 'package:instafake_flutter/core/data/sources/local_post_model_data_source.dart';
import 'package:instafake_flutter/core/data/sources/remote_post_model_data_source.dart';
import 'package:instafake_flutter/core/domain/dto/create_post_request.dart';

abstract class PostModelRepository {
  Future<Either<Exception, void>> createPost(CreatePostRequest creatPostRequest, File file);
  Future<Either<Exception, PostModel>> getPost(int postId);
  Future<Either<Exception, List<PostModel>>> getExplore(int page, int pageSize);
  Future<Either<Exception, List<PostModel>>> getTimeline(String username, int page, int pageSize);
  Future<void> deletePost(int postId);
}

class PostModelRepositoryImpl implements PostModelRepository {
  final RemotePostModelDataSource _remoteDataSource;
  final LocalPostModelDataSource _localDataSource;

  PostModelRepositoryImpl({required RemotePostModelDataSource remoteDataSource, required LocalPostModelDataSource localDataSource}) : _remoteDataSource = remoteDataSource, _localDataSource = localDataSource;
  
  @override
  Future<Either<Exception, void>> createPost(CreatePostRequest creatPostRequest, File file) async {
    try {
      await _remoteDataSource.createPost(creatPostRequest, file);
      return const Right(null);
    } on Exception catch (e) {
      return Left(Exception("Create post failed : ${e.toString()}"));
    }
  }
  
  @override
  Future<void> deletePost(int postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Exception, List<PostModel>>> getExplore(int page, int pageSize) async {
    try {
      List<PostModel> explore = await _remoteDataSource.getExplore(page, pageSize).then((value) {
        if (value.isNotEmpty) {
          for (var post in value) {
            _localDataSource.savePostMetadata(post, post.id);
          }
          return value;        
        }
        return [];
      });
      if (explore.isNotEmpty) {
        return Right(explore);
      } else {
        return Left(Exception("Timeline not available"));
      }
    } on Exception catch (e) {
      return Left(Exception("Timeline failed : ${e.toString()}"));
    }
  }
  
  @override
  Future<Either<Exception, PostModel>> getPost(int postId) {
    // TODO: implement getPost
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Exception, List<PostModel>>> getTimeline(String username, int page, int pageSize) async {
    try {
      List<PostModel> timeline = await _remoteDataSource.getTimeline(username, page, pageSize).then((value) {
        if (value.isNotEmpty) {
          for (var post in value) {
            _localDataSource.savePostMetadata(post, post.id);
          }
          return value;        
        }
        return [];
      });
      if (timeline.isNotEmpty) {
        return Right(timeline);
      } else {
        return Left(Exception("Timeline not available"));
      }
    } on Exception catch (e) {
      return Left(Exception("Timeline failed : ${e.toString()}"));
    }
  }

}