import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../routes/home_route.dart';
import '../routes/feedback_route.dart';
import 'package:smarthack2023/routes/progress_route.dart' as pg;

Drawer sideDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.purple[500]!, Colors.purple[100]!],
                    [Colors.deepPurple[300]!, Colors.deepPurple[50]!],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.10, 0.14],
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: const Size(double.infinity, double.infinity),
              ),
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  buildMenuItem('Dashboard', Icons.dashboard, () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeRoute(),
                      ),
                    );
                  }),
                  buildMenuItem('My Progress', Icons.show_chart, () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const pg.ProgressRoute(),
                      ),
                    );
                  }),
                  buildMenuItem('Feedback', Icons.feedback, () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedbackRoute(),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        buildMenuItem('Logout', Icons.logout, () {
          Navigator.pop(context);
        }),
      ],
    ),
  );
}

Widget buildMenuItem(String title, IconData icon, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
}
