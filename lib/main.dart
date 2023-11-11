import 'package:flutter/material.dart';

import 'router/home_route.dart';

import 'pb_instance.dart';

void main() {
  PbInstance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const HomeRoute(),
    );
  }
}
