import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

import 'test_api_key.dart';

void main() {
  final port = '8081';
  final host = 'http://0.0.0.0:$port';
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      [
        'run',
        'bin/server.dart',
      ],
      environment: {
        'PORT': port,
        'OPENAI_API_KEY': testApiKey,
      },
    );
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('/tip works', () async {
    final response = await get(Uri.parse('$host/tip'));
    print(response.body);
    expect(response.statusCode, 200);
    expect(response.body.length, greaterThan(20));
  });

  test('404: Not Found', () async {
    final response = await get(
      Uri.parse('$host/foobar'),
    );
    expect(response.statusCode, 404);
  });

  test('405: Method Not Allowed', () async {
    final response = await post(Uri.parse('$host/tip'));
    expect(response.statusCode, 405);
  });
}
