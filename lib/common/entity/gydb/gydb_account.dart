class UserAccount {
  final int id;
  final String realName;
  final String userName;
  final String passWord;
  final String telPhone;
  final int userType;
  final bool status;
  final bool isChange;
  final String? headPoint;
  final bool isRegister;

  UserAccount({
    required this.id,
    required this.realName,
    required this.userName,
    required this.passWord,
    required this.telPhone,
    required this.userType,
    required this.status,
    required this.isChange,
    this.headPoint,
    required this.isRegister,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      id: json['Id'],
      realName: json['RealName'],
      userName: json['UserName'],
      passWord: json['PassWord'],
      telPhone: json['TelPhone'],
      userType: json['UserType'],
      status: json['Status'],
      isChange: json['IsChange'],
      headPoint: json['HeadPoint'],
      isRegister: json['IsRegister'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'RealName': realName,
      'UserName': userName,
      'PassWord': passWord,
      'TelPhone': telPhone,
      'UserType': userType,
      'Status': status,
      'IsChange': isChange,
      'HeadPoint': headPoint,
      'IsRegister': isRegister,
    };
  }

  @override
  String toString() {
    return 'UserAccount{id: $id, realName: $realName, userName: $userName, passWord: $passWord, telPhone: $telPhone, userType: $userType, status: $status, isChange: $isChange, headPoint: $headPoint, isRegister: $isRegister}';
  }
}