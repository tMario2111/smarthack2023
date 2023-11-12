import 'package:flutter/material.dart';

import '../widgets/side_drawer.dart';

import '../pb_instance.dart';

import '../util.dart';

import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class ProgressRoute extends StatefulWidget {
  const ProgressRoute({super.key});

  @override
  State<StatefulWidget> createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<ProgressRoute> {
  var _dataFetched = false;
  final _studentRatings = <String, Map<TeacherStudentScoreType, List<int>>>{};
  final _teacherRatings = <String, Map<StudentTeacherScoreType, List<int>>>{};
  final _progressBarRows = <Column>[];

  void _getData() async {
    final pb = PbInstance.getPb();
    final id = PbInstance.id;

    if (PbInstance.isTeacher) {
      final classes =
          (await pb.collection('teachers').getOne(id, expand: 'classes'))
              .expand['classes']!
              .toList();
      for (final cl in classes) {
        final ratings = (await pb
                .collection('student_teacher_ratings')
                .getList(filter: 'teacher.id = "$id"'))
            .items;
        for (final rating in ratings) {
          if (_teacherRatings[cl.getStringValue('name')] == null) {
            _teacherRatings[cl.getStringValue('name')] =
                <StudentTeacherScoreType, List<int>>{};
          }
          if (_teacherRatings[cl.getStringValue('name')]![
                  StudentTeacherScoreType.values[rating.getIntValue('type')]] ==
              null) {
            _teacherRatings[cl.getStringValue('name')]![StudentTeacherScoreType
                .values[rating.getIntValue('type')]] = [];
          }
          _teacherRatings[cl.getStringValue('name')]![
                  StudentTeacherScoreType.values[rating.getIntValue('type')]]!
              .add(rating.getIntValue('value'));
        }
      }
      _teacherRatings.forEach((className, value) {
        final progressBars = <Column>[];
        value.forEach((key, value) {
          final averageRating = value.fold(0, (p, c) => p + c) / value.length;
          progressBars.add(
            Column(
              children: [
                SimpleCircularProgressBar(
                  size: 150,
                  progressStrokeWidth: 30,
                  backStrokeWidth: 15,
                  progressColors: const [Colors.cyan, Colors.purple],
                  valueNotifier: ValueNotifier(averageRating * 10.0),
                  animationDuration: 1,
                  onGetText: (p0) {
                    return Text(
                      key == StudentTeacherScoreType.comunicationSkills
                          ? "${p0.toStringAsFixed(2)}%"
                          : "${(p0 / 10.0).floor()}.${p0.floor() % 10} / 10",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Text(
                  getStudentTeacherScoreTypeString(key),
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
          );
        });
        _progressBarRows.add(
          Column(
            children: [
              Text(
                'Feedback from $className',
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 45.0,
              ),
              Wrap(
                spacing: 150.0,
                children: progressBars,
              ),
              const SizedBox(
                height: 50.0,
              )
            ],
          ),
        );
      });
      _dataFetched = true;
      setState(() {});
    } else {
      final list = await pb.collection('teacher_student_ratings').getList(
          filter: 'student.id = "$id"', expand: 'teacher', sort: 'type');

      for (final record in list.items) {
        final ratingType = record.getIntValue('type');
        final ratingValue = record.getIntValue('value');
        final teacherName =
            record.expand['teacher']![0].getStringValue('first_name') +
                ' ' +
                record.expand['teacher']![0].getStringValue('last_name');
        final scoreTypeIndex = TeacherStudentScoreType.values[ratingType];
        if (_studentRatings[teacherName] == null) {
          _studentRatings[teacherName] = <TeacherStudentScoreType, List<int>>{};
        }
        if (_studentRatings[teacherName]![scoreTypeIndex] == null) {
          _studentRatings[teacherName]![scoreTypeIndex] = <int>[];
        }
        _studentRatings[teacherName]![scoreTypeIndex]!.add(ratingValue);
      }

      _studentRatings.forEach((teacherName, value) {
        final progressBars = <Column>[];
        value.forEach((key, value) {
          final averageRating = value.fold(0, (p, c) => p + c) / value.length;
          progressBars.add(
            Column(
              children: [
                SimpleCircularProgressBar(
                  size: 150,
                  progressStrokeWidth: 30,
                  backStrokeWidth: 15,
                  progressColors: const [Colors.cyan, Colors.purple],
                  valueNotifier: ValueNotifier(averageRating * 10.0),
                  animationDuration: 1,
                  onGetText: (p0) {
                    return Text(
                      key == TeacherStudentScoreType.attendance
                          ? "${p0.toStringAsFixed(2)}%"
                          : "${(p0 / 10.0).floor()}.${p0.floor() % 10} / 10",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Text(
                  getTeacherStudentScoreTypeString(key),
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
          );
        });
        _progressBarRows.add(
          Column(
            children: [
              Text(
                'Feedback from $teacherName',
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 45.0,
              ),
              Wrap(
                spacing: 150.0,
                children: progressBars,
              ),
              const SizedBox(
                height: 50.0,
              )
            ],
          ),
        );
      });

      _dataFetched = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_dataFetched) {
      _getData();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Progress'),
      ),
      drawer: sideDrawer(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 25.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                          _progressBarRows.isEmpty ? [] : _progressBarRows,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
