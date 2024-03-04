import 'dart:io';

import 'package:http/http.dart';
import 'package:shelf_backend/env_variables.dart';
import 'package:test/test.dart';

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('Root', () async {
    final authHeader = 'Bearer $clientApiKey';
    final response = await get(
      Uri.parse('$host/user/bizz84'),
      headers: {'authorization': authHeader},
    );
    expect(response.statusCode, 200);
    expect(response.body.startsWith('{"user":"bizz84'), true);
  });

  test('401: Unauthorized', () async {
    final response = await get(Uri.parse('$host/user/bizz84'));
    expect(response.statusCode, 401);
  });

  test('404: Not Found', () async {
    final authHeader = 'Bearer $clientApiKey';
    final response = await get(
      Uri.parse('$host/foobar'),
      headers: {'authorization': authHeader},
    );
    expect(response.statusCode, 404);
  });

  test('405: Method Not Allowed', () async {
    final response = await post(Uri.parse('$host/user/suragch'));
    expect(response.statusCode, 405);
  });
}
