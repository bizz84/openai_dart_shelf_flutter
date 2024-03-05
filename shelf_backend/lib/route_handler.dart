import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

final router = Router()..get('/tip', _tipHandler);

Future<Response> _tipHandler(Request request) async {
  final url = Uri.parse('https://api.openai.com/v1/chat/completions');
  final apiKey = const String.fromEnvironment('OPENAI_API_KEY');
  print('apiKey: $apiKey');
  final env = Platform.environment['OPENAI_API_KEY'];
  print('env: $env');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };
  final data = {
    'model': 'gpt-3.5-turbo',
    'messages': [
      {
        'role': 'user',
        'content': 'Give me a random tip about using Flutter and Dart. '
            'Keep it to one sentence.',
      }
    ],
    'temperature': 1.0,
  };

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    final messageContent = responseBody['choices'][0]['message']['content'];
    return Response.ok(messageContent);
  } else {
    return Response.internalServerError(
      body:
          'OpenAI request failed with status: ${response.statusCode}: ${response.body}, API: ${apiKey.length}',
    );
  }
}
