
class DianFei {
  final int gyRoomId;
  final double roomMoney;
  final String roomName;

  DianFei({
    required this.gyRoomId,
    required this.roomMoney,
    required this.roomName,
  });

  factory DianFei.fromJson(Map<String, dynamic> json) {
    return DianFei(
      gyRoomId: json['gyroomid'],
      roomMoney: json['roommoney'],
      roomName: json['roomname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gyroomid': gyRoomId,
      'roommoney': roomMoney,
      'roomname': roomName,
    };
  }

  @override
  String toString() {
    return 'DianFei(gyRoomId: $gyRoomId, roomMoney: $roomMoney, roomName: $roomName)';
  }
}
