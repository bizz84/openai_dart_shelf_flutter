import 'package:flutter/material.dart';

import 'home_page_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final manager = HomePageManager();

  @override
  void initState() {
    super.initState();
    manager.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 250,
          child: ValueListenableBuilder<LoadingState>(
              valueListenable: manager.loadingNotifier,
              builder: (context, loadingState, child) {
                return switch (loadingState) {
                  Initial() => const SizedBox(),
                  Loading() => const LinearProgressIndicator(),
                  LoadingError() => Text(loadingState.message),
                  Result() => Avatar(user: loadingState.user),
                };
              }),
        ),
      ),
    );
  }
}

class LoadingUser extends StatelessWidget {
  const LoadingUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Icon(Icons.person, size: 200),
        Align(
          alignment: Alignment.bottomCenter,
          child: LinearProgressIndicator(),
        ),
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.user,
  });

  final GitHubUser user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(user.avatarUrl),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            user.username,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
