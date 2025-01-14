
class Paper {
  final String histPaperID;
  final String name;
  final String createDate;
  final String endDate;
  final String myScore;
  final String myDoneDate;

  Paper({
    required this.histPaperID,
    required this.name,
    required this.createDate,
    required this.endDate,
    required this.myScore,
    required this.myDoneDate,
  });

  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper(
      histPaperID: json['HistPaperID'],
      name: json['Name'],
      createDate: json['CreateDate'],
      endDate: json['EndDate'],
      myScore: json['MyScore'],
      myDoneDate: json['MyDoneDate'],
    );
  }
}
