import 'package:flutter/material.dart';

import '../widgets/side_drawer.dart';

class ProgressRoute extends StatefulWidget {
  const ProgressRoute({super.key});

  @override
  State<StatefulWidget> createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<ProgressRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Progress'),
      ),
      drawer: sideDrawer(context),
      body: const Center(
        child: Text('Progress route'),
      ),
    );
  }
}
