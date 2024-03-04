import 'dart:convert';

import 'package:flutter_frontend/home/home_page_manager.dart';
import 'package:http/http.dart' as http;

class WebClient {
  Future<GitHubUser> fetchUser(String name) async {
    final response =
        await http.get(Uri.parse('https://api.github.com/users/$name'));
    if (response.statusCode != 200) {
      throw Exception('Error getting user');
    }
    final body = json.decode(response.body);
    print(body);
    final username = body['login'];
    final url = body['avatar_url'];
    if (username == null || url == null) {
      throw ArgumentError('User not found');
    }
    return GitHubUser(
      username: username,
      avatarUrl: url,
    );
  }
}
