import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

enum Flavor { dev, live }

Flavor getFlavor() => switch (appFlavor) {
      'live' => Flavor.live,
      'dev' => Flavor.dev,
      _ => Flavor.dev,
    };

class WebClient {
  String get _host {
    return switch (getFlavor()) {
      Flavor.dev => (Platform.isAndroid) ? '10.0.2.2:8080' : '127.0.0.1:8080',
      // TODO: Update with deployed app URL
      Flavor.live => throw UnsupportedError('Server app not deployed yet'),
    };
  }

  Future<String> fetchTip() async {
    final response = await http.get(Uri.parse('http://$_host/tip'));
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
