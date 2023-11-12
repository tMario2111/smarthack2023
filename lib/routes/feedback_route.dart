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
  var _dataFetched = false;
  final _teacherList = <String, String>{};
  final _studentList = <String, String>{};
  var _dropDownValue = '';
  final _textFieldControllers = List<TextEditingController>.generate(
      StudentTeacherScoreType.values.length,
      (index) => TextEditingController());

  void _fetchData() async {
    final pb = PbInstance.getPb();
    final userId = PbInstance.id;

    if (PbInstance.isTeacher) {
      final classes =
          (await pb.collection('teachers').getOne(userId, expand: 'classes'))
              .expand['classes']!
              .toList();
      for (final cl in classes) {
        final students = (await pb
                .collection('students')
                .getList(filter: 'class.id = "${cl.id}"'))
            .items;

        for (final student in students) {
          if ((await pb.collection('teacher_student_ratings').getList(
                  filter:
                      'teacher.id = "$userId" && student.id = "${student.id}"'))
              .items
              .isNotEmpty) {
            continue;
          }
          _studentList[student.id] =
              '${student.getStringValue('first_name')} ${student.getStringValue('last_name')}';
          _dropDownValue = _studentList[student.id]!;
        }
      }
      _dataFetched = true;
      setState(() {});
    } else {
      final classId =
          (await pb.collection('students').getOne(userId, expand: 'class'))
              .expand['class']![0]
              .id;

      final teachers =
          (await pb.collection('teachers').getList(expand: 'classes')).items;
      for (final teacher in teachers) {
        for (final class_ in teacher.expand['classes']!) {
          if (class_.id == classId) {
            if ((await pb.collection('student_teacher_ratings').getList(
                    filter:
                        'teacher.id = "${teacher.id}" && student.id = "$userId"'))
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

      _dataFetched = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_dataFetched) {
      _fetchData();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Give Feedback'),
      ),
      drawer: sideDrawer(context),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dataFetched
                ? DropdownButton<String>(
                    value: _dropDownValue,
                    items: (PbInstance.isTeacher ? _studentList : _teacherList)
                        .entries
                        .map((e) {
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
            for (final i in PbInstance.isTeacher
                ? TeacherStudentScoreType.values
                : StudentTeacherScoreType.values)
              SizedBox(
                width: 400.0,
                child: TextField(
                  controller: _textFieldControllers[i.index],
                  decoration: InputDecoration(
                    hintText: PbInstance.isTeacher
                        ? getTeacherStudentScoreTypeString(
                            i as TeacherStudentScoreType)
                        : getStudentTeacherScoreTypeString(
                            i as StudentTeacherScoreType),
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

                  if (PbInstance.isTeacher) {
                    await PbInstance.getPb()
                        .collection('teacher_student_ratings')
                        .create(body: {
                      'student': _studentList.entries
                          .firstWhere(
                              (element) => element.value == _dropDownValue)
                          .key,
                      'teacher': PbInstance.id,
                      'type': i,
                      'value': value
                    });
                  } else {
                    await PbInstance.getPb()
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
                  }
                  i++;
                }
                showSnackBar(context, 'Rating successful');
                setState(() {
                  _teacherList.clear();
                });
                _dataFetched = false;
              },
              child: const Text('Send feedback'),
            )
          ],
        ),
      ),
    );
  }
}
