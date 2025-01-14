import 'package:flutter/material.dart';

class CourseScore {
  final String semester; // 学期，如 2024-2025-春
  final String name; // 课程名
  final String courseCode; // 课程号
  final String credit; // 学分
  final String courseNature; // 课程性质
  final String examScore; // 正考分数
  final String retakeScore; // 补考分数
  final String gpa; // 绩点
  CourseScore({
    required this.semester,
    required this.name,
    required this.courseCode,
    required this.credit,
    required this.courseNature,
    required this.examScore,
    required this.retakeScore,
    required this.gpa,
  });
  factory CourseScore.fromJson(Map<String, dynamic> json) {
    return CourseScore(
      semester: json['semester'] ?? '',
      name: json['name'] ?? '',
      courseCode: json['courseCode'] ?? '',
      credit: json['credit'] ?? '',
      courseNature: json['courseNature'] ?? '',
      examScore: json['examScore'] ?? '',
      retakeScore: json['retakeScore'] ?? '',
      gpa: json['gpa'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'semester': semester,
      'name': name,
      'courseCode': courseCode,
      'credit': credit,
      'courseNature': courseNature,
      'examScore': examScore,
      'retakeScore': retakeScore,
      'gpa': gpa,
    };
  }

  @override
  String toString() {
    return 'Course{semester: $semester, name: $name, courseCode: $courseCode, credit: $credit, courseNature: $courseNature, examScore: $examScore, retakeScore: $retakeScore, gpa: $gpa}';
  }
}