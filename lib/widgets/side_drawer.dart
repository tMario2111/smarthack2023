import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../routes/home_route.dart';
import '../routes/progress_route.dart';
import '../routes/feedback_route.dart';

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
                  ListTile(
                    title: const Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeRoute(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'My Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProgressRoute(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Feedback',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeedbackRoute(),
                        ),
                      );
                    },
                  ),
                ],
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
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
