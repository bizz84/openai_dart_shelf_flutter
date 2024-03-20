import 'package:flutter/foundation.dart';
import '../web_client/web_client.dart';

class FlutterTipsLoader {
  final webClient = WebClient();
  final loadingNotifier = ValueNotifier<RequestState>(Loading());

  Future<void> requestTip() async {
    loadingNotifier.value = Loading();
    try {
      final stopwatch = Stopwatch()..start();
      final tip = await webClient.fetchTip();
      stopwatch.stop();
      loadingNotifier.value = Success(tip, stopwatch.elapsed);
    } on ClientException catch (e) {
      loadingNotifier.value = Failure(e.message);
    }
  }
}

sealed class RequestState {}

class Loading extends RequestState {}

class Success extends RequestState {
  Success(this.tip, this.responseTime);
  final String tip;
  final Duration responseTime;
}

class Failure extends RequestState {
  Failure(this.message);
  final String message;
}
