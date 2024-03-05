import 'dart:io';

import 'package:http/http.dart' as http;

class WebClient {
  String get _host => (Platform.isAndroid) ? '10.0.2.2:8080' : '127.0.0.1:8080';

  Future<String> fetchTip() async {
    print('hello');
    final response = await http.get(Uri.parse('http://$_host/tip'));
    if (response.statusCode != 200) {
      throw ClientException('Error getting tip');
    }
    return response.body;
  }
}

class ClientException implements Exception {
  ClientException(this.message);
  final String message;
}
