import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:instafake_flutter/core/data/models/post_model.dart';
import 'package:instafake_flutter/core/domain/dto/create_post_request.dart';
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

  Future<List<PostModel>> getExplore(int page, int pageSize) async {
    final response = await _httpClient.get(Uri.parse('$_baseUrl/explore?page=$page&pageSize=$pageSize'), headers: {
      'Authorization': _token,
    });
    if (response.statusCode == 200) {
      return PostModel.fromJsonList(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get explore');
    }
  }

  Future<List<PostModel>> getTimeline(String username, int page, int pageSize) async {
    final response = await _httpClient.get(Uri.parse('$_baseUrl/$username/timeline?page=$page&pageSize=$pageSize'), headers: {
      'Authorization': _token,
    });
    if (response.statusCode == 200) {
      return PostModel.fromJsonList(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get timeline');
    }
  }
}