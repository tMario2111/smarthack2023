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
