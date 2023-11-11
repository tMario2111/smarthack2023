import 'package:flutter/material.dart';

import 'package:pocketbase/pocketbase.dart';

import '../pb_instance.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<StatefulWidget> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  void test() async {
    final list = await PbInstance.getPb().collection('schools').getList();
    print(list.items[0].id);
  }

  @override
  Widget build(BuildContext context) {
    test();
    return Scaffold(
      appBar: AppBar(
        title: Text('School Buddy'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
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
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Progress'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: (){
                Navigator.pop(context);
              }
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Your main content goes here'),
      ),
    );
  }
}
