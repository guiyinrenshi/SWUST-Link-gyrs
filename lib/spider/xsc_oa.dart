import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/oa/judge_score.dart';
import 'package:swust_link/common/global.dart';

class XSCOA {
  static void initXSCOA() async {
    final url = "http://xsc.swust.edu.cn/JC/OneLogin.aspx";
    final res = await Global.xscOa?.dio.get(url);
    // 正则表达式匹配 URL
    final urlRegex = RegExp(r"window\.location\.href\s*=\s*'([^']+)'");

    // 查找匹配
    final match = urlRegex.firstMatch(res?.data);

    if (match != null) {
      final extractedUrl = match.group(1); // 提取第一个捕获组（URL）
      Global.xscOa?.dio.get(extractedUrl!);
      print('Extracted URL: $extractedUrl');
    } else {
      print('No URL found.');
    }
  }

  Future<List<JudgeScore>> getJudgeScore() async {
    final url = "http://xsc.swust.edu.cn/Sys/SystemForm/StudentJudge/StuJudgeScore.aspx";
    final res = await Global.xscOa?.dio.get(url,
        options: Options(headers: {
          "Accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
          "Accept-Language": "zh-CN,zh;q=0.9",
          "Proxy-Connection": "keep-alive",
          "Referer": "http://xsc.swust.edu.cn/Sys/SystemForm/Navigation.aspx",
          "Upgrade-Insecure-Requests": "1",
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36"
        }));
    Logger().i(res?.data);
    Logger().i(res?.statusCode);
    Logger().i(res?.headers);
    return parseHtmlToRecords(res?.data);
  }


  List<JudgeScore> parseHtmlToRecords(String htmlContent) {
    final document = parse(htmlContent);

    // 找到表格
    final table = document.querySelector('#GridView1');
    if (table == null) {
      throw Exception('Table with id "GridView1" not found.');
    }

    // 提取表格行
    final rows = table.querySelectorAll('tr');
    List<JudgeScore> records = [];

    // 跳过表头，从第二行开始解析
    for (int i = 1; i < rows.length; i++) {
      final cells = rows[i].querySelectorAll('td');
      if (cells.length < 21) continue; // 确保有足够的列

      // 将单元格数据提取为对象
      records.add(JudgeScore(
        studentId: cells[0].text.trim(),
        name: cells[1].text.trim(),
        moralScore: double.parse(cells[2].text.trim()),
        moralRankClass: cells[3].text.trim(),
        moralRankMajor: cells[4].text.trim(),
        developmentScore: double.parse(cells[5].text.trim()),
        developmentRankClass: cells[6].text.trim(),
        developmentRankMajor: cells[7].text.trim(),
        intelligenceScore: double.parse(cells[8].text.trim()),
        intelligenceRankClass: cells[9].text.trim(),
        intelligenceRankMajor: cells[10].text.trim(),
        physicalScore: double.parse(cells[11].text.trim()),
        physicalRankClass: cells[12].text.trim(),
        physicalRankMajor: cells[13].text.trim(),
        laborScore: double.parse(cells[14].text.trim()),
        laborRankClass: cells[15].text.trim(),
        laborRankMajor: cells[16].text.trim(),
        totalScore: double.parse(cells[17].text.trim()),
        totalRankClass: cells[18].text.trim(),
        totalRankMajor: cells[19].text.trim(),
        academicYear: cells[20].text.trim(),
      ));
    }
    Logger().i(records);
    return records;
  }

}
