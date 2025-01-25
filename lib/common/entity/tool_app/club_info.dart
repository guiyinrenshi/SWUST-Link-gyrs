import 'package:swust_link/common/model/entity_model.dart';

class ClubInfo {
  final String name;
  final String qq;

  ClubInfo(this.name, this.qq);

  factory ClubInfo.fromJson(Map<String, dynamic> json) {
    return ClubInfo(json['name'], json['qq']);
  }
}
