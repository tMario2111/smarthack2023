import 'package:flutter/material.dart';

import '../routes/home_route.dart';
import '../routes/progress_route.dart';
import '../routes/feedback_route.dart';

Drawer sideDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Dashboard'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeRoute()));
                },
              ),
              ListTile(
                title: const Text('My Progress'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProgressRoute()));
                },
              ),
              ListTile(
                title: const Text('Feedback'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedbackRoute()));
                },
              ),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.logout),
              SizedBox(width: 10),
              Text('Logout'),
            ],
          ),
          onTap: () {
            // Implement your logout functionality here
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
