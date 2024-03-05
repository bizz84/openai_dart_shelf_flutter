import 'package:flutter/foundation.dart';
import 'package:flutter_frontend/web_client/web_client.dart';

class HomePageManager {
  final webClient = WebClient();
  final loadingNotifier = ValueNotifier<LoadingState>(Initial());

  Future<void> requestTip() async {
    loadingNotifier.value = Loading();
    try {
      final tip = await webClient.fetchTip();
      loadingNotifier.value = Result(tip);
    } on ClientException catch (e) {
      loadingNotifier.value = LoadingError(e.message);
    }
  }
}

sealed class LoadingState {}

class Initial extends LoadingState {}

class Loading extends LoadingState {}

class Result extends LoadingState {
  Result(this.tip);
  final String tip;
}

class LoadingError extends LoadingState {
  LoadingError(this.message);
  final String message;
}
