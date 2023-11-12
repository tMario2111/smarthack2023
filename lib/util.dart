import 'package:flutter/material.dart';

enum TeacherStudentScoreType {
  classActivity,
  attendance,
  homework,
}

String getTeacherStudentScoreTypeString(TeacherStudentScoreType scoreType) {
  if (scoreType == TeacherStudentScoreType.classActivity) {
    return "Class activity";
  } else if (scoreType == TeacherStudentScoreType.attendance) {
    return "Class attendance";
  } else {
    return "Homework";
  }
}

enum StudentTeacherScoreType {
  teachingEfficiency,
  comunicationSkills,
  studentInteractions
}

String getStudentTeacherScoreTypeString(StudentTeacherScoreType scoreType) {
  if (scoreType == StudentTeacherScoreType.teachingEfficiency) {
    return 'Teaching Efficiency';
  } else if (scoreType == StudentTeacherScoreType.comunicationSkills) {
    return 'Communication Skills';
  } else {
    return 'Student Interactions';
  }
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
      ),
    );
}
