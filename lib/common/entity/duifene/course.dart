
class Course {
  final String termID;
  final String termName;
  final String termStatus;
  final String courseID;
  final String courseName;
  final String backgroundColor;
  final String color;
  final String isCanel;
  final String createrID;
  final String createrDate;
  final String updaterDate;
  final String tClassID;
  final String className;

  Course({
    required this.termID,
    required this.termName,
    required this.termStatus,
    required this.courseID,
    required this.courseName,
    required this.backgroundColor,
    required this.color,
    required this.isCanel,
    required this.createrID,
    required this.createrDate,
    required this.updaterDate,
    required this.tClassID,
    required this.className,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    String backgroundColor =
    json['BackgroundColor'] == '#fff' ? '#e0e0e0' : json['BackgroundColor'];
    String color = json['Color'] == '#fff' ? '#e0e0e0' : json['Color'];

    return Course(
      termID: json['TermID'],
      termName: json['TermName'],
      termStatus: json['TermStatus'],
      courseID: json['CourseID'],
      courseName: json['CourseName'],
      backgroundColor: backgroundColor,
      color: color,
      isCanel: json['IsCanel'],
      createrID: json['CreaterID'],
      createrDate: json['CreaterDate'],
      updaterDate: json['UpdaterDate'],
      tClassID: json['TClassID'],
      className: json['ClassName'],
    );
  }
}