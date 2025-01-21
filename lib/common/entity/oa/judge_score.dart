import 'package:swust_link/common/model/entity_model.dart';

class JudgeScore extends JsonSerializable{
  final String studentId;
  final String name;
  final double moralScore;
  final String moralRankClass;
  final String moralRankMajor;
  final double developmentScore;
  final String developmentRankClass;
  final String developmentRankMajor;
  final double intelligenceScore;
  final String intelligenceRankClass;
  final String intelligenceRankMajor;
  final double physicalScore;
  final String physicalRankClass;
  final String physicalRankMajor;
  final double laborScore;
  final String laborRankClass;
  final String laborRankMajor;
  final double totalScore;
  final String totalRankClass;
  final String totalRankMajor;
  final String academicYear;

  // Constructor
  JudgeScore({
    required this.studentId,
    required this.name,
    required this.moralScore,
    required this.moralRankClass,
    required this.moralRankMajor,
    required this.developmentScore,
    required this.developmentRankClass,
    required this.developmentRankMajor,
    required this.intelligenceScore,
    required this.intelligenceRankClass,
    required this.intelligenceRankMajor,
    required this.physicalScore,
    required this.physicalRankClass,
    required this.physicalRankMajor,
    required this.laborScore,
    required this.laborRankClass,
    required this.laborRankMajor,
    required this.totalScore,
    required this.totalRankClass,
    required this.totalRankMajor,
    required this.academicYear,
  });

  // toString method
  @override
  String toString() {
    return '''
JudgeScore(
  studentId: $studentId,
  name: $name,
  moralScore: $moralScore,
  moralRankClass: $moralRankClass,
  moralRankMajor: $moralRankMajor,
  developmentScore: $developmentScore,
  developmentRankClass: $developmentRankClass,
  developmentRankMajor: $developmentRankMajor,
  intelligenceScore: $intelligenceScore,
  intelligenceRankClass: $intelligenceRankClass,
  intelligenceRankMajor: $intelligenceRankMajor,
  physicalScore: $physicalScore,
  physicalRankClass: $physicalRankClass,
  physicalRankMajor: $physicalRankMajor,
  laborScore: $laborScore,
  laborRankClass: $laborRankClass,
  laborRankMajor: $laborRankMajor,
  totalScore: $totalScore,
  totalRankClass: $totalRankClass,
  totalRankMajor: $totalRankMajor,
  academicYear: $academicYear,
)
    ''';
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'name': name,
      'moralScore': moralScore,
      'moralRankClass': moralRankClass,
      'moralRankMajor': moralRankMajor,
      'developmentScore': developmentScore,
      'developmentRankClass': developmentRankClass,
      'developmentRankMajor': developmentRankMajor,
      'intelligenceScore': intelligenceScore,
      'intelligenceRankClass': intelligenceRankClass,
      'intelligenceRankMajor': intelligenceRankMajor,
      'physicalScore': physicalScore,
      'physicalRankClass': physicalRankClass,
      'physicalRankMajor': physicalRankMajor,
      'laborScore': laborScore,
      'laborRankClass': laborRankClass,
      'laborRankMajor': laborRankMajor,
      'totalScore': totalScore,
      'totalRankClass': totalRankClass,
      'totalRankMajor': totalRankMajor,
      'academicYear': academicYear,
    };
  }

  // fromJson method
  factory JudgeScore.fromJson(Map<String, dynamic> json) {
    return JudgeScore(
      studentId: json['studentId'],
      name: json['name'],
      moralScore: (json['moralScore'] as num).toDouble(),
      moralRankClass: json['moralRankClass'],
      moralRankMajor: json['moralRankMajor'],
      developmentScore: (json['developmentScore'] as num).toDouble(),
      developmentRankClass: json['developmentRankClass'],
      developmentRankMajor: json['developmentRankMajor'],
      intelligenceScore: (json['intelligenceScore'] as num).toDouble(),
      intelligenceRankClass: json['intelligenceRankClass'],
      intelligenceRankMajor: json['intelligenceRankMajor'],
      physicalScore: (json['physicalScore'] as num).toDouble(),
      physicalRankClass: json['physicalRankClass'],
      physicalRankMajor: json['physicalRankMajor'],
      laborScore: (json['laborScore'] as num).toDouble(),
      laborRankClass: json['laborRankClass'],
      laborRankMajor: json['laborRankMajor'],
      totalScore: (json['totalScore'] as num).toDouble(),
      totalRankClass: json['totalRankClass'],
      totalRankMajor: json['totalRankMajor'],
      academicYear: json['academicYear'],
    );
  }
}
