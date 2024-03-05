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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 64),
            ElevatedButton(
              onPressed: manager.requestTip,
              child: const Text('Give me a Flutter tip'),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ValueListenableBuilder<LoadingState>(
                valueListenable: manager.loadingNotifier,
                builder: (context, loadingState, child) {
                  return switch (loadingState) {
                    Initial() => const SizedBox(),
                    Loading() => const LinearProgressIndicator(),
                    LoadingError() => Text(
                        loadingState.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    Result() => Text(loadingState.tip),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
