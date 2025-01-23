import 'dart:convert';

import 'package:gbk_codec/gbk_codec.dart';
import 'package:swust_link/common/model/entity_model.dart';
import 'dart:typed_data';

class LeaveApplication extends JsonSerializable {
  String eventTarget;
  String eventArgument;
  String viewState;
  String viewStateGenerator;
  String leaveBeginDate;
  String leaveBeginTime;
  String leaveEndDate;
  String leaveEndTime;
  String leaveNumNo;
  String leaveType;
  String leaveThing;
  String area;
  String comeWhere1;
  String a1;
  String a2;
  String a3;
  String outAddress;
  String isTellRbl;
  String withNumNo;
  String jhrName;
  String jhrPhone;
  String outTel;
  String outMoveTel;
  String relation;
  String outName;
  String stuMoveTel;
  String stuOtherTel;
  String goDate;
  String goTime;
  String goVehicle;
  String backDate;
  String backTime;
  String backVehicle;
  String hidden1;

  LeaveApplication({
    required this.eventTarget,
    required this.eventArgument,
    required this.viewState,
    required this.viewStateGenerator,
    required this.leaveBeginDate,
    required this.leaveBeginTime,
    required this.leaveEndDate,
    required this.leaveEndTime,
    required this.leaveNumNo,
    required this.leaveType,
    required this.leaveThing,
    required this.area,
    required this.comeWhere1,
    required this.a1,
    required this.a2,
    required this.a3,
    required this.outAddress,
    required this.isTellRbl,
    required this.withNumNo,
    required this.jhrName,
    required this.jhrPhone,
    required this.outTel,
    required this.outMoveTel,
    required this.relation,
    required this.outName,
    this.stuMoveTel = '',
    this.stuOtherTel = '',
    this.goDate = '',
    required this.goTime,
    required this.goVehicle,
    this.backDate = '',
    required this.backTime,
    required this.backVehicle,
    required this.hidden1,
  });

  List<int> encodeGbk(String value) {
    // return gbk
    //     .encode(value)
    //     .map((e) => '%${e.toRadixString(16).padLeft(2, '0').toUpperCase()}')
    //     .join();
    return gbk.encode(value.toString());
  }

  String decodeGbk(String value) {
    final decodedBytes = Uri.decodeFull(value)
        .replaceAll('%', '')
        .split(RegExp(r'(?=(?:..)*$)'))
        .map((e) => int.parse(e, radix: 16))
        .toList();
    return gbk.decode(decodedBytes);
  }

  // 修改 fromJson 方法
  factory LeaveApplication.fromJson(Map<String, dynamic> json) {
    return LeaveApplication(
      eventTarget: Uri.decodeComponent(json['__EVENTTARGET'] ?? ''),
      eventArgument: Uri.decodeComponent(json['__EVENTARGUMENT'] ?? ''),
      viewState: Uri.decodeComponent(json['__VIEWSTATE'] ?? ''),
      viewStateGenerator:
          Uri.decodeComponent(json['__VIEWSTATEGENERATOR'] ?? ''),
      leaveBeginDate:
          Uri.decodeComponent(json['AllLeave1\$LeaveBeginDate'] ?? ''),
      leaveBeginTime:
          Uri.decodeComponent(json['AllLeave1\$LeaveBeginTime'] ?? ''),
      leaveEndDate: Uri.decodeComponent(json['AllLeave1\$LeaveEndDate'] ?? ''),
      leaveEndTime: Uri.decodeComponent(json['AllLeave1\$LeaveEndTime'] ?? ''),
      leaveNumNo: Uri.decodeComponent(json['AllLeave1\$LeaveNumNo'] ?? ''),
      leaveType: Uri.decodeComponent(json['AllLeave1\$LeaveType'] ?? ''),
      leaveThing: Uri.decodeComponent(json['AllLeave1\$LeaveThing'] ?? ''),
      area: Uri.decodeComponent(json['AllLeave1\$area'] ?? ''),
      comeWhere1: Uri.decodeComponent(json['AllLeave1\$ComeWhere1'] ?? ''),
      a1: Uri.decodeComponent(json['A1'] ?? ''),
      a2: Uri.decodeComponent(json['A2'] ?? ''),
      a3: Uri.decodeComponent(json['A3'] ?? ''),
      outAddress: Uri.decodeComponent(json['AllLeave1\$OutAddress'] ?? ''),
      isTellRbl: Uri.decodeComponent(json['AllLeave1\$IsTellRbl'] ?? ''),
      withNumNo: Uri.decodeComponent(json['AllLeave1\$WithNumNo'] ?? ''),
      jhrName: Uri.decodeComponent(json['AllLeave1\$JHRName'] ?? ''),
      jhrPhone: Uri.decodeComponent(json['AllLeave1\$JHRPhone'] ?? ''),
      outTel: Uri.decodeComponent(json['AllLeave1\$OutTel'] ?? ''),
      outMoveTel: Uri.decodeComponent(json['AllLeave1\$OutMoveTel'] ?? ''),
      relation: Uri.decodeComponent(json['AllLeave1\$Relation'] ?? ''),
      outName: Uri.decodeComponent(json['AllLeave1\$OutName'] ?? ''),
      stuMoveTel: Uri.decodeComponent(json['AllLeave1\$StuMoveTel'] ?? ''),
      stuOtherTel: Uri.decodeComponent(json['AllLeave1\$StuOtherTel'] ?? ''),
      goDate: Uri.decodeComponent(json['AllLeave1\$GoDate'] ?? ''),
      goTime: Uri.decodeComponent(json['AllLeave1\$GoTime'] ?? ''),
      goVehicle: Uri.decodeComponent(json['AllLeave1\$GoVehicle'] ?? ''),
      backDate: Uri.decodeComponent(json['AllLeave1\$BackDate'] ?? ''),
      backTime: Uri.decodeComponent(json['AllLeave1\$BackTime'] ?? ''),
      backVehicle: Uri.decodeComponent(json['AllLeave1\$BackVehicle'] ?? ''),
      hidden1: Uri.decodeComponent(json['AllLeave1\$Hidden1'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '__EVENTTARGET': Uri.encodeComponent(eventTarget),
      '__EVENTARGUMENT': Uri.encodeComponent(eventArgument),
      '__VIEWSTATE': Uri.encodeComponent(viewState),
      '__VIEWSTATEGENERATOR': Uri.encodeComponent(viewStateGenerator),
      'AllLeave1\$LeaveBeginDate': Uri.encodeComponent(leaveBeginDate),
      'AllLeave1\$LeaveBeginTime': Uri.encodeComponent(leaveBeginTime),
      'AllLeave1\$LeaveEndDate': Uri.encodeComponent(leaveEndDate),
      'AllLeave1\$LeaveEndTime': Uri.encodeComponent(leaveEndTime),
      'AllLeave1\$LeaveNumNo': Uri.encodeComponent(leaveNumNo),
      'AllLeave1\$LeaveType': Uri.encodeComponent(leaveType),
      'AllLeave1\$LeaveThing': Uri.encodeComponent(leaveThing),
      'AllLeave1\$area': Uri.encodeComponent(area),
      'AllLeave1\$ComeWhere1': Uri.encodeComponent(comeWhere1),
      'A1': Uri.encodeComponent(a1),
      'A2': Uri.encodeComponent(a2),
      'A3': Uri.encodeComponent(a3),
      'AllLeave1\$OutAddress': Uri.encodeComponent(outAddress),
      'AllLeave1\$IsTellRbl': Uri.encodeComponent(isTellRbl),
      'AllLeave1\$WithNumNo': Uri.encodeComponent(withNumNo),
      'AllLeave1\$JHRName': Uri.encodeComponent(jhrName),
      'AllLeave1\$JHRPhone': Uri.encodeComponent(jhrPhone),
      'AllLeave1\$OutTel': Uri.encodeComponent(outTel),
      'AllLeave1\$OutMoveTel': Uri.encodeComponent(outMoveTel),
      'AllLeave1\$Relation': Uri.encodeComponent(relation),
      'AllLeave1\$OutName': Uri.encodeComponent(outName),
      'AllLeave1\$StuMoveTel': Uri.encodeComponent(stuMoveTel),
      'AllLeave1\$StuOtherTel': Uri.encodeComponent(stuOtherTel),
      'AllLeave1\$GoDate': Uri.encodeComponent(goDate),
      'AllLeave1\$GoTime': Uri.encodeComponent(goTime),
      'AllLeave1\$GoVehicle': Uri.encodeComponent(goVehicle),
      'AllLeave1\$BackDate': Uri.encodeComponent(backDate),
      'AllLeave1\$BackTime': Uri.encodeComponent(backTime),
      'AllLeave1\$BackVehicle': Uri.encodeComponent(backVehicle),
      'AllLeave1\$Hidden1': Uri.encodeComponent(hidden1),
    };
  }
  //
  // // 修改 toJson 方法
  // Future<Map<String, dynamic>> toFormData() async {
  //   return {
  //     '__EVENTTARGET': eventTarget,
  //     '__EVENTARGUMENT': eventArgument,
  //     '__VIEWSTATE': viewState,
  //     '__VIEWSTATEGENERATOR': viewStateGenerator,
  //     'AllLeave1\$LeaveBeginDate': leaveBeginDate,
  //     'AllLeave1\$LeaveBeginTime': leaveBeginTime,
  //     'AllLeave1\$LeaveEndDate': leaveEndDate,
  //     'AllLeave1\$LeaveEndTime': leaveEndTime,
  //     'AllLeave1\$LeaveNumNo': leaveNumNo,
  //     'AllLeave1\$LeaveType': encodeGbk(leaveType),
  //     'AllLeave1\$LeaveThing': encodeGbk(leaveThing),
  //     'AllLeave1\$area': area,
  //     'AllLeave1\$ComeWhere1': encodeGbk(comeWhere1),
  //     'A1': encodeGbk(a1),
  //     'A2': encodeGbk(a2),
  //     'A3': encodeGbk(a3),
  //     'AllLeave1\$OutAddress': encodeGbk(outAddress),
  //     'AllLeave1\$IsTellRbl': isTellRbl == "是" ? 1 : 0,
  //     'AllLeave1\$WithNumNo': withNumNo,
  //     'AllLeave1\$JHRName': encodeGbk(jhrName),
  //     'AllLeave1\$JHRPhone': jhrPhone,
  //     'AllLeave1\$OutTel': outTel,
  //     'AllLeave1\$OutMoveTel': (outMoveTel),
  //     'AllLeave1\$Relation': encodeGbk(relation),
  //     'AllLeave1\$OutName': encodeGbk(outName),
  //     'AllLeave1\$StuMoveTel': (stuMoveTel),
  //     'AllLeave1\$StuOtherTel': (stuOtherTel),
  //     'AllLeave1\$GoDate': (goDate),
  //     'AllLeave1\$GoTime': (goTime),
  //     'AllLeave1\$GoVehicle': encodeGbk(goVehicle),
  //     'AllLeave1\$BackDate': (backDate),
  //     'AllLeave1\$BackTime': (backTime),
  //     'AllLeave1\$BackVehicle': encodeGbk(backVehicle),
  //     'AllLeave1\$Hidden1': (hidden1),
  //   };
  // }  // 修改 toJson 方法
  Future<Map<String, dynamic>> toFormData() async {
    return {
      '__EVENTTARGET': eventTarget,
      '__EVENTARGUMENT': eventArgument,
      '__VIEWSTATE': viewState,
      '__VIEWSTATEGENERATOR': viewStateGenerator,
      'AllLeave1\$LeaveBeginDate': leaveBeginDate,
      'AllLeave1\$LeaveBeginTime': leaveBeginTime,
      'AllLeave1\$LeaveEndDate': leaveEndDate,
      'AllLeave1\$LeaveEndTime': leaveEndTime,
      'AllLeave1\$LeaveNumNo': leaveNumNo,
      'AllLeave1\$LeaveType': (leaveType),
      'AllLeave1\$LeaveThing': (leaveThing),
      'AllLeave1\$area': area,
      'AllLeave1\$ComeWhere1': (comeWhere1),
      'A1': (a1),
      'A2': (a2),
      'A3': (a3),
      'AllLeave1\$OutAddress': (outAddress),
      'AllLeave1\$IsTellRbl': isTellRbl == "是" ? 1 : 0,
      'AllLeave1\$WithNumNo': withNumNo,
      'AllLeave1\$JHRName': (jhrName),
      'AllLeave1\$JHRPhone': jhrPhone,
      'AllLeave1\$OutTel': outTel,
      'AllLeave1\$OutMoveTel': (outMoveTel),
      'AllLeave1\$Relation': (relation),
      'AllLeave1\$OutName': (outName),
      'AllLeave1\$StuMoveTel': (stuMoveTel),
      'AllLeave1\$StuOtherTel': (stuOtherTel),
      'AllLeave1\$GoDate': (goDate),
      'AllLeave1\$GoTime': (goTime),
      'AllLeave1\$GoVehicle': (goVehicle),
      'AllLeave1\$BackDate': (backDate),
      'AllLeave1\$BackTime': (backTime),
      'AllLeave1\$BackVehicle': (backVehicle),
      'AllLeave1\$Hidden1': (hidden1),
    };
  }

  @override
  String toString() {
    return 'LeaveApplication(eventTarget: $eventTarget, eventArgument: $eventArgument, viewState: $viewState, '
        'viewStateGenerator: $viewStateGenerator, leaveBeginDate: $leaveBeginDate, leaveBeginTime: $leaveBeginTime, '
        'leaveEndDate: $leaveEndDate, leaveEndTime: $leaveEndTime, leaveNumNo: $leaveNumNo, leaveType: $leaveType, '
        'leaveThing: $leaveThing, area: $area, comeWhere1: $comeWhere1, a1: $a1, a2: $a2, a3: $a3, '
        'outAddress: $outAddress, isTellRbl: $isTellRbl, withNumNo: $withNumNo, jhrName: $jhrName, '
        'jhrPhone: $jhrPhone, outTel: $outTel, outMoveTel: $outMoveTel, relation: $relation, outName: $outName, '
        'stuMoveTel: $stuMoveTel, stuOtherTel: $stuOtherTel, goDate: $goDate, goTime: $goTime, '
        'goVehicle: $goVehicle, backDate: $backDate, backTime: $backTime, backVehicle: $backVehicle, hidden1: $hidden1)';
  }
}
