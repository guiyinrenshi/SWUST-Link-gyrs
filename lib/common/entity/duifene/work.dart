class Work {
  final String studentID;
  final String tClassID;
  final String courseID;
  final String hWID;
  final String hWName;
  final String depression;
  final String endDate;
  final String postTime;
  final String submitNumber;
  final String correctNumber;
  final String sumNumber;
  final bool isSubmit;

  Work({
    required this.studentID,
    required this.tClassID,
    required this.courseID,
    required this.hWID,
    required this.hWName,
    required this.depression,
    required this.endDate,
    required this.postTime,
    required this.submitNumber,
    required this.correctNumber,
    required this.sumNumber,
    required this.isSubmit,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      studentID: json['StudentID'],
      tClassID: json['TClassID'],
      courseID: json['CourseID'],
      hWID: json['HWID'],
      hWName: json['HWName'],
      depression: json['Depression'],
      endDate: json['EndDate'],
      postTime: json['PostTime'],
      submitNumber: json['SubmitNumber'],
      correctNumber: json['CorrectNumber'],
      sumNumber: json['SumNumber'],
      isSubmit: json['IsSubmit'] == "1",
    );
  }
}