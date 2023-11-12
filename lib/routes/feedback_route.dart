import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarthack2023/util.dart';

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
  final _textFieldControllers = List<TextEditingController>.generate(
      StudentTeacherScoreType.values.length,
      (index) => TextEditingController());

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
          if ((await pb.collection('student_teacher_ratings').getList(
                  filter:
                      'teacher.id = "${teacher.id}" && student.id = "$user_id"'))
              .items
              .isNotEmpty) {
            continue;
          }
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
            for (final i in StudentTeacherScoreType.values)
              SizedBox(
                width: 400.0,
                child: TextField(
                  controller: _textFieldControllers[i.index],
                  decoration: InputDecoration(
                    hintText: getStudentTeacherScoreTypeString(i),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            const SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
              onPressed: () async {
                for (final controller in _textFieldControllers) {
                  if (controller.text.isEmpty) {
                    showSnackBar(context, 'All 3 fields must be filled');
                    return;
                  }
                  final value = int.parse(controller.text);
                  if (value <= 0 || value > 10) {
                    showSnackBar(context, 'Rating must be between 1 and 10');
                    return;
                  }
                }
                var i = 0;
                for (final controller in _textFieldControllers) {
                  final value = int.parse(controller.text);

                  final model = await PbInstance.getPb()
                      .collection('student_teacher_ratings')
                      .create(body: {
                    'student': PbInstance.id,
                    'teacher': _teacherList.entries
                        .firstWhere(
                            (element) => element.value == _dropDownValue)
                        .key,
                    'type': i,
                    'value': value
                  });
                  i++;
                }
                showSnackBar(context, 'Rating successful');
                setState(() {
                  _teacherList.clear();
                });
                _data_fetched = false;
              },
              child: const Text('Send feedback'),
            )
          ],
        ),
      ),
    );
  }
}
