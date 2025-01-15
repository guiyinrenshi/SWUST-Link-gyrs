// 考试
import 'package:html/parser.dart';
import 'package:swust_link/common/entity/oa/exam.dart';
import 'package:swust_link/spider/oa_auth.dart';

class ExamTable {
  late OAAuth oa;

  ExamTable(String username, String password) {
    oa = OAAuth(
        service:
            "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=studentPortal:DEFAULT_EVENT",
        username: username,
        password: password);
  }

  Future<List<FinalExam>> getExams() async {
    await oa.login();
    final url =
        "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=studentPortal:examTable";
    var data = await oa.dio.get(url);
    final document = parse(data.data);
    final rows = document.querySelectorAll('.editRows');
    return rows.map((row) {
      final cells = row.querySelectorAll('td');
      return FinalExam(
        index: int.parse(cells[0].text.trim()),
        course: cells[1].text.trim(),
        week: cells[2].text.trim(),
        session: cells[3].text.trim(),
        date: cells[4].text.trim(),
        time: cells[5].text.trim(),
        classroom: cells[6].text.trim(),
        seat: int.parse(cells[7].text.trim()),
        location: cells[8].text.trim(),
      );
    }).toList();
  }
}
