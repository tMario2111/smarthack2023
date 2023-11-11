import 'package:flutter/material.dart';

import '../widgets/side_drawer.dart';

import '../pb_instance.dart';

class FeedbackRoute extends StatefulWidget {
  const FeedbackRoute({super.key});

  @override
  State<StatefulWidget> createState() => _FeedbackRouteState();
}

class _FeedbackRouteState extends State<FeedbackRoute> {
  var _data_fetched = false;
  final _teacherList = <String, String>{};
  var _dropDownValue = '';

  void _fetchData() async {
    final pb = PbInstance.getPb();
    final user_id = PbInstance.id;
    final class_id =
        (await pb.collection('students').getOne(user_id, expand: 'class'))
            .expand['class']![0]
            .id;

    final teachers =
        (await pb.collection('teachers').getList(expand: 'classes')).items;
    for (final teacher in teachers) {
      for (final class_ in teacher.expand['classes']!) {
        if (class_.id == class_id) {
          _teacherList[teacher.id] =
              '${teacher.getStringValue('first_name')} ${teacher.getStringValue('last_name')}';
          _dropDownValue = _teacherList[teacher.id]!;
        }
      }
    }

    _data_fetched = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_data_fetched) {
      _fetchData();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      drawer: sideDrawer(context),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _data_fetched
                ? DropdownButton<String>(
                    value: _dropDownValue,
                    items: _teacherList.entries.map((e) {
                      return DropdownMenuItem<String>(
                          value: e.value, child: Text(e.value));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _dropDownValue = value!;
                      });
                    },
                  )
                : const Center(),
          ],
        ),
      ),
    );
  }
}
