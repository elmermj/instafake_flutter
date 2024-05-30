import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:instafake_flutter/utils/constants.dart';

class RemoteUserModelDataSource {
  final http.Client client;

  RemoteUserModelDataSource(this.client);

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await client.post(
      Uri.parse('${SERVER_URL}api/users/login'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: DEFAULT_HEADER_NON_TOKEN,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<http.Response> register(
    String username,
    String email,
    String password,
    String realname
  ) {
    if (username.isEmpty || email.isEmpty || password.isEmpty || realname.isEmpty) {
      throw Exception('Please fill in all fields');
    } else {
      final response = client.post(
        Uri.parse('${SERVER_URL}api/users/register'),
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'realname': realname
        }),
        headers: DEFAULT_HEADER_NON_TOKEN
      );
      return response;
    }
  }
  
}