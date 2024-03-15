import 'dart:io';

import 'package:http/http.dart' as http;

// Hard-coding here to simplify the tutorial.
// import 'package:flutter/services.dart';
// https://docs.flutter.dev/deployment/flavors
const appFlavor = 'live';

enum Flavor { dev, live }

Flavor getFlavor() => switch (appFlavor) {
      'live' => Flavor.live,
      'dev' => Flavor.dev,
      _ => Flavor.dev,
    };

class WebClient {
  String get _host {
    return switch (getFlavor()) {
      Flavor.dev =>
        (Platform.isAndroid) ? 'http://10.0.2.2:8080' : 'http://127.0.0.1:8080',
      Flavor.live => 'https://shelf-backend-2191.globeapp.dev',
    };
  }

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
