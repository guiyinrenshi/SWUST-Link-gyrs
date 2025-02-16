import 'package:html/parser.dart';
import 'package:logger/logger.dart';

class CourseFrame {
  final String id;
  final String department;
  final String code;
  final String name;
  final int hours;
  final String credits;
  final String maxPerWeek;
  final String requiredProjects;
  final bool isPackageSelectable;

  CourseFrame({
    required this.id,
    required this.department,
    required this.code,
    required this.name,
    required this.hours,
    required this.credits,
    required this.maxPerWeek,
    required this.requiredProjects,
    required this.isPackageSelectable,
  });

  factory CourseFrame.fromJson(Map<String, dynamic> json) {
    return CourseFrame(
      id: json['id'],
      department: json['department'],
      code: json['code'],
      name: json['name'],
      hours: int.tryParse(json['hours']) ?? 0,
      credits: json['credits'] ?? '',
      maxPerWeek: json['maxPerWeek'] ?? '',
      requiredProjects: json['requiredProjects'] ?? '',
      isPackageSelectable: json['isPackageSelectable'] == '是',
    );
  }

  @override
  String toString() {
    return 'CourseFrame{id: $id, department: $department, code: $code, name: $name, hours: $hours, credits: $credits, maxPerWeek: $maxPerWeek, requiredProjects: $requiredProjects, isPackageSelectable: $isPackageSelectable}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'department': department,
      'code': code,
      'name': name,
      'hours': hours.toString(),
      'credits': credits,
      'maxPerWeek': maxPerWeek,
      'requiredProjects': requiredProjects,
      'isPackageSelectable': isPackageSelectable ? '是' : '否',
    };
  }

  static List<CourseFrame> fromHtml(String html) {
    var document = parse(html);
    List<CourseFrame> courses = [];

    document.querySelectorAll(".tablelist tbody tr").forEach((row) {
      var cells = row.querySelectorAll("td");
      if (cells.length >= 9) {
        courses.add(CourseFrame(
          id: cells[0].querySelector("input")?.attributes['value'] ?? '',
          department: cells[1].text.trim(),
          code: cells[2].text.trim(),
          name: cells[3].text.trim(),
          hours: int.tryParse(cells[4].text.trim()) ?? 0,
          credits: cells[5].text.trim(),
          maxPerWeek: cells[6].text.trim(),
          requiredProjects: cells[7].text.trim(),
          isPackageSelectable: cells[8].text.trim() == '是',
        ));
      }
    });

    return courses;
  }
}

class Experiment {
  final String id;
  final String code;
  final String name;
  final int hours;
  final String credits;
  final String type;
  final String schedule;
  final String location;
  final String instructor;
  final int maxStudents;
  final int minStudents;
  final int availableSeats;

  Experiment({
    required this.id,
    required this.code,
    required this.name,
    required this.hours,
    required this.credits,
    required this.type,
    required this.schedule,
    required this.location,
    required this.instructor,
    required this.maxStudents,
    required this.minStudents,
    required this.availableSeats,
  });

  factory Experiment.fromJson(Map<String, dynamic> json) {
    return Experiment(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      hours: int.tryParse(json['hours']) ?? 0,
      credits: json['credits'] ?? '',
      type: json['type'] ?? '',
      schedule: json['schedule'] ?? '',
      location: json['location'] ?? '',
      instructor: json['instructor'] ?? '',
      maxStudents: int.tryParse(json['maxStudents']) ?? 0,
      minStudents: int.tryParse(json['minStudents']) ?? 0,
      availableSeats: int.tryParse(json['availableSeats']) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'hours': hours.toString(),
      'credits': credits,
      'type': type,
      'schedule': schedule,
      'location': location,
      'instructor': instructor,
      'maxStudents': maxStudents.toString(),
      'minStudents': minStudents.toString(),
      'availableSeats': availableSeats.toString(),
    };
  }

  @override
  String toString() {
    return 'Experiment{id: $id, code: $code, name: $name, hours: $hours, credits: $credits, type: $type, schedule: $schedule, location: $location, instructor: $instructor, maxStudents: $maxStudents, minStudents: $minStudents, availableSeats: $availableSeats}';
  }

  static List<Experiment> fromHtml(String html) {
    var document = parse(html);
    List<Experiment> experiments = [];

    document.querySelectorAll(".tablelist tbody tr").forEach((row) {
      var cells = row.querySelectorAll("td");
      if (cells.length >= 12) {
        experiments.add(Experiment(
          id: cells[0].text.trim()=="已选"?"已选":cells[0].querySelector("input")?.attributes['value']??"",
          code: cells[1].text.trim(),
          name: cells[2].text.trim(),
          hours: int.tryParse(cells[3].text.trim()) ?? 0,
          credits: cells[4].text.trim(),
          type: cells[5].text.trim(),
          schedule: cells[6].text.trim(),
          location: cells[7].text.trim(),
          instructor: cells[8].text.trim(),
          maxStudents: int.tryParse(cells[9].text.trim()) ?? 0,
          minStudents: int.tryParse(cells[10].text.trim()) ?? 0,
          availableSeats: int.tryParse(cells[11].text.trim()) ?? 0,
        ));
      }
    });

    return experiments;
  }
}


class ExperimentProject {
  final String id;
  final String name;
  final int expId;

  ExperimentProject({
    required this.id,
    required this.name,
    required this.expId,
  });

  factory ExperimentProject.fromJson(Map<String, dynamic> json) {
    return ExperimentProject(
      id: json['id'],
      name: json['name'],
      expId: int.tryParse(json['expId']) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'expId': expId.toString(),
    };
  }

  @override
  String toString() {
    return 'ExperimentProject{id: $id, name: $name, expId: $expId}';
  }

  static List<ExperimentProject> fromHtml(String html) {
    var document = parse(html);
    List<ExperimentProject> projects = [];

    document.querySelectorAll("#Nav a").forEach((element) {
      var onClickAttr = element.attributes['onclick'];
      var expIdMatch = RegExp(r'exps\((\d+)\);').firstMatch(onClickAttr ?? '');
      if (expIdMatch != null) {
        projects.add(ExperimentProject(
          id: element.id,
          name: element.text.trim(),
          expId: int.tryParse(expIdMatch.group(1) ?? '') ?? 0,
        ));
      }
    });
    return projects;
  }
}
