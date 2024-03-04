import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_backend/env_variables.dart';
import 'package:shelf_router/shelf_router.dart';

final router = Router()..get('/user/<id>', _userHandler);

Future<Response> _userHandler(Request request) async {
  print('url');
  final url = Uri.parse('https://api.github.com/users/bizz84');
  final headers = {
    'Accept': 'application/vnd.github+json',
    'Authorization': 'Bearer $gitHubKey',
    'X-GitHub-Api-Version': '2022-11-28',
  };

  final res = await http.get(url, headers: headers);
  final body = json.decode(res.body);
  print(body);
  final login = body['login'];
  final avatar = body['avatar_url'];
  final Map<String, dynamic> responseData = {
    'user': login,
    'avatar': avatar,
  };
  final String jsonResponse = jsonEncode(responseData);

  return Response.ok(
    jsonResponse,
    headers: {'Content-Type': 'application/json'},
  );
}
