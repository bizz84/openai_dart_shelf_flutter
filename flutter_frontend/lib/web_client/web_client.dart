import 'dart:io';

import 'package:http/http.dart' as http;

class WebClient {
  String get _host =>
      Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://127.0.0.1:8080';

  Future<String> fetchTip() async {
    final response = await http.get(Uri.parse('$_host/tip'));
    if (response.statusCode != 200) {
      throw ClientException('Error getting tip: ${response.body}');
    }
    return response.body;
  }
}

class ClientException implements Exception {
  ClientException(this.message);
  final String message;
}
