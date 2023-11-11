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
    return Scaffold();
  }
}
