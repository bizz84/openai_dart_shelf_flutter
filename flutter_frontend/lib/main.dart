import 'package:flutter/material.dart';

import 'home/home_page.dart';

void main() {
  runApp(const GitHubProfileApp());
}

class GitHubProfileApp extends StatelessWidget {
  const GitHubProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
