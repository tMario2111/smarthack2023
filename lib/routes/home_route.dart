import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smarthack2023/pb_instance.dart';

import '../widgets/side_drawer.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<StatefulWidget> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    String formattedDate = DateFormat.yMMMMd().format(now).toString();
    String userName = PbInstance.first_name!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: sideDrawer(context),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 250,
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.2,
          padding: const EdgeInsets.only(left: 35, top: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Colors.purple[500]!, Colors.purple[100]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 100),
                  Text(
                    'Welcome back, $userName!',
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Always stay updated in your student portal',
                    style: TextStyle(
                      color: Color.fromARGB(158, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 0),
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    '../../assets/welcome_student.png',
                    width: 500,
                    height: 500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeRoute(),
  ));
}
