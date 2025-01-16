class CheckIn {
  final String id;
  final String checkInCode;
  final String checkInType;
  final String createrDate;
  final String remark;
  final String applyLimitDate;
  final String studentID;
  final String checkInDate;
  final String checkInStatus;
  final String canApply;
  final String statusID;
  final String statusName;
  final String applyStatus;
  final String approvalTime;
  final String approverID;
  final String fillDate;
  final String fillStatus;
  final String applyDel;

  CheckIn({
    required this.id,
    required this.checkInCode,
    required this.checkInType,
    required this.createrDate,
    required this.remark,
    required this.applyLimitDate,
    required this.studentID,
    required this.checkInDate,
    required this.checkInStatus,
    required this.canApply,
    required this.statusID,
    required this.statusName,
    required this.applyStatus,
    required this.approvalTime,
    required this.approverID,
    required this.fillDate,
    required this.fillStatus,
    required this.applyDel,
  });

  factory CheckIn.fromJson(Map<String, dynamic> json) {
    return CheckIn(
      id: json['ID'],
      checkInCode: json['CheckInCode'],
      checkInType: json['CheckInType'],
      createrDate: json['CreaterDate'],
      remark: json['Remark'],
      applyLimitDate: json['ApplyLimitDate'],
      studentID: json['StudentID'],
      checkInDate: json['CheckInDate'],
      checkInStatus: json['CheckInStatus'],
      canApply: json['CanApply'],
      statusID: json['StatusID'],
      statusName: json['StatusName'],
      applyStatus: json['ApplyStatus'],
      approvalTime: json['ApprovalTime'],
      approverID: json['ApproverID'],
      fillDate: json['FillDate'],
      fillStatus: json['FillStatus'],
      applyDel: json['ApplyDel'],
    );
  }
}