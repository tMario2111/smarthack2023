import 'package:flutter/material.dart';

import 'package:pocketbase/pocketbase.dart';

import '../pb_instance.dart';

import '../widgets/side_drawer.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<StatefulWidget> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: sideDrawer(context),
      body: const Center(
        child: Text('Home Route'),
      ),
    );
  }
}
