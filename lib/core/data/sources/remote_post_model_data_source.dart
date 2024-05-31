import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:instafake_flutter/core/data/models/post_model.dart';
import 'package:instafake_flutter/core/data/models/post_thumbnail_model.dart';
import 'package:instafake_flutter/core/domain/dto/create_post_request.dart';
import 'package:instafake_flutter/utils/constants.dart';
import 'package:instafake_flutter/utils/log.dart';

class RemotePostModelDataSource {
  final http.Client _httpClient;
  final String _baseUrl;
  final String _token;

  RemotePostModelDataSource(this._httpClient, this._baseUrl, this._token);

  Future<void> createPost(CreatePostRequest post, File file) async {
    var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/create'));
    request.fields['username'] = post.username;
    request.fields['caption'] = post.caption;
    request.files.add(http.MultipartFile('file', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
    request.headers['Authorization'] = _token;
    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        Log.green('Create post success');
      } else {
        Log.red('Create post failed');
      }
    } catch (e) {
      Log.red('Create post failed');
    }
  }

  Future<List<PostThumbnailModel>> getExplore(int page, int pageSize) async {
    String requestURL = '${_baseUrl}api/posts/explore?page=$page&size=$pageSize';
    final response = await _httpClient.post(Uri.parse(requestURL), headers: DEFAULT_HEADER(_token));
    Log.yellow("GET EXPLORE STATUS CODE  ::: ${response.statusCode}");
    Log.yellow("GET EXPLORE RESPONSE BODY  ::: ${response.body}");
    if (response.statusCode == 200) {
      return PostThumbnailModel.fromJsonList(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get explore');
    }
  }

  Future<List<PostModel>> getTimeline(String username, int page, int pageSize) async {
    String requestURL = '${_baseUrl}api/posts/$username/timeline?page=$page&size=$pageSize';
    Log.yellow('Get timeline Auth Token : $_token');
    final response = await _httpClient.post(Uri.parse(requestURL), headers: DEFAULT_HEADER(_token));
    Log.yellow('Get timeline response (DS) [${response.statusCode}]: ${response.body}');
    if (response.statusCode == 200) {
      return PostModel.fromJsonList(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get timeline');
    }
  }
}