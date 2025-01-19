import '../../model/entity_model.dart';

class FinalExam extends JsonSerializable{
  final int index;
  final String course;
  final String week;
  final String session;
  final String date;
  final String time;
  final String classroom;
  final int seat;
  final String location;

  FinalExam({
    required this.index,
    required this.course,
    required this.week,
    required this.session,
    required this.date,
    required this.time,
    required this.classroom,
    required this.seat,
    required this.location,
  });
  factory FinalExam.fromJson(Map<String, dynamic> json) {
    return FinalExam(
      index: json['index'],
      course: json['course'],
      week: json['week'],
      session: json['session'],
      date: json['date'],
      time: json['time'],
      classroom: json['classroom'],
      seat: json['seat'],
      location: json['location'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'course': course,
      'week': week,
      'session': session,
      'date': date,
      'time': time,
      'classroom': classroom,
      'seat': seat,
      'location': location,
    };
  }
  @override
  String toString() {
    return 'FinalExam(index: $index, course: $course, week: $week, session: $session, date: $date, time: $time, classroom: $classroom, seat: $seat, location: $location)';
  }
}

