import 'package:flutter/foundation.dart';
import 'package:flutter_frontend/web_client/web_client.dart';

class FlutterTipsLoader {
  final webClient = WebClient();
  final loadingNotifier = ValueNotifier<RequestState>(Initial());

  Future<void> requestTip() async {
    loadingNotifier.value = Loading();
    try {
      final started = DateTime.now();
      final tip = await webClient.fetchTip();
      final elapsed = DateTime.now().difference(started);
      loadingNotifier.value = Result(tip, elapsed);
    } on ClientException catch (e) {
      loadingNotifier.value = LoadingError(e.message);
    }
  }
}

sealed class RequestState {}

class Initial extends RequestState {}

class Loading extends RequestState {}

class Result extends RequestState {
  Result(this.tip, this.responseTime);
  final String tip;
  final Duration responseTime;
}

class LoadingError extends RequestState {
  LoadingError(this.message);
  final String message;
}
