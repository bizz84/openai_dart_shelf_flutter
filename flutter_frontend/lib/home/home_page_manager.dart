import 'package:flutter/foundation.dart';
import 'package:flutter_frontend/web_client/web_client.dart';

class GitHubUser {
  GitHubUser({
    required this.username,
    required this.avatarUrl,
  });
  final String username;
  final String avatarUrl;
}

class HomePageManager {
  final loadingNotifier = ValueNotifier<LoadingState>(Initial());
  final webClient = WebClient();

  Future<void> init() async {
    loadingNotifier.value = Loading();
    try {
      final user = await webClient.fetchUser('suragch');
      loadingNotifier.value = Result(user);
    } catch (e) {
      loadingNotifier.value = LoadingError(e.toString());
    }
  }
}

sealed class LoadingState {}

class Initial extends LoadingState {}

class Loading extends LoadingState {}

class Result extends LoadingState {
  Result(this.user);
  final GitHubUser user;
}

class LoadingError extends LoadingState {
  LoadingError(this.message);
  final String message;
}
