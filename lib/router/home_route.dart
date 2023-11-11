import 'package:flutter/material.dart';

import 'package:pocketbase/pocketbase.dart';

import '../pb_instance.dart';

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
        title: const Text('School Buddy'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Meniu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('My Progress'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                title: const Text('Feedback'),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: const Center(
        child: Text('Your main content goes here'),
      ),
    );
  }
}
