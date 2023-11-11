import 'package:flutter/material.dart';

import 'routes/home_route.dart';

import 'pb_instance.dart';

void main() async {
  await PbInstance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const HomeRoute(),
    );
  }
}
