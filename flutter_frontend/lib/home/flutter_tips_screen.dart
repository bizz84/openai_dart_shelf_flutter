import 'package:flutter/material.dart';

import 'flutter_tips_loader.dart';

class FlutterTipsScreen extends StatefulWidget {
  const FlutterTipsScreen({super.key});

  @override
  State<FlutterTipsScreen> createState() => _FlutterTipsScreenState();
}

class _FlutterTipsScreenState extends State<FlutterTipsScreen> {
  final _loader = FlutterTipsLoader();

  @override
  void initState() {
    // Load the first tip
    _loader.requestTip();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Tips by AI')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 64),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ValueListenableBuilder<RequestState>(
                valueListenable: _loader.loadingNotifier,
                builder: (context, state, child) {
                  return switch (state) {
                    Loading() => const LinearProgressIndicator(),
                    Failure() => Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    Success() => Column(
                        children: [
                          Text(
                            state.tip,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Latency: ${state.responseTime.inMilliseconds}ms',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                  };
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _loader.requestTip,
              child: const Text(
                'Next Flutter Tip',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
