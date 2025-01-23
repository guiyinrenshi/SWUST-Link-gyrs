import 'package:html/parser.dart';

class LeaveApplicationParser {
  final String htmlContent;

  LeaveApplicationParser(this.htmlContent);

  // 提取 ViewState 和其他隐藏字段
  Map<String, String> extractHiddenFields() {
    final document = parse(htmlContent);
    final hiddenInputs = document.querySelectorAll('input[type="hidden"]');

    final Map<String, String> hiddenFields = {};
    for (var input in hiddenInputs) {
      final name = input.attributes['name'];
      final value = input.attributes['value'] ?? '';
      if (name != null) {
        hiddenFields[name] = value;
      }
    }

    return hiddenFields;
  }

  // 提取表格中的请假记录
  List<LeaveRecord> extractLeaveRecords() {
    final document = parse(htmlContent);
    final table = document.querySelector('#GridView1');
    final rows = table?.querySelectorAll('tr');

    if (rows == null || rows.isEmpty) return [];

    final List<LeaveRecord> records = [];

    for (var i = 1; i < rows.length; i++) {
      // 从第二行开始（跳过表头）
      final cells = rows[i].querySelectorAll('td');
      if (cells.length >= 7) {
        records.add(
          LeaveRecord(
            id: cells[0].text.trim(),
            studentId: cells[1].text.trim(),
            leaveTime: cells[2].text.trim(),
            leaveType: cells[3].text.trim(),
            location: cells[4].text.trim(),
            status: cells[5].text.trim(),
            leaveState: cells[6].text.trim(),
          ),
        );
      }
    }

    return records;
  }

  // 提取分页信息
  PaginationInfo extractPaginationInfo() {
    final document = parse(htmlContent);
    final pageInfo = document.querySelector('#TPagedInfo1_myinfolbl');

    if (pageInfo != null) {
      final matches = RegExp(r'共检索到\s*(\d+)\s*条记录.*共\s*(\d+)\s*页')
          .firstMatch(pageInfo.text);

      if (matches != null) {
        return PaginationInfo(
          totalRecords: int.tryParse(matches.group(1) ?? '0') ?? 0,
          totalPages: int.tryParse(matches.group(2) ?? '0') ?? 0,
        );
      }
    }

    return PaginationInfo(totalRecords: 0, totalPages: 0);
  }
}

class LeaveRecord {
  final String id;
  final String studentId;
  final String leaveTime;
  final String leaveType;
  final String location;
  final String status;
  final String leaveState;

  LeaveRecord({
    required this.id,
    required this.studentId,
    required this.leaveTime,
    required this.leaveType,
    required this.location,
    required this.status,
    required this.leaveState,
  });

  @override
  String toString() {
    return 'LeaveRecord(id: $id, studentId: $studentId, leaveTime: $leaveTime, leaveType: $leaveType, location: $location, status: $status, leaveState: $leaveState)';
  }
}

class PaginationInfo {
  final int totalRecords;
  final int totalPages;

  PaginationInfo({required this.totalRecords, required this.totalPages});

  @override
  String toString() {
    return 'PaginationInfo(totalRecords: $totalRecords, totalPages: $totalPages)';
  }
}

class LeaveInfoRecord {
  late final List<LeaveRecord> records;
  late final PaginationInfo paginationInfo;

  LeaveInfoRecord(String html){
    LeaveApplicationParser leaveApplicationParser =LeaveApplicationParser(html);
    records = leaveApplicationParser.extractLeaveRecords();
    paginationInfo = leaveApplicationParser.extractPaginationInfo();
  }
}
