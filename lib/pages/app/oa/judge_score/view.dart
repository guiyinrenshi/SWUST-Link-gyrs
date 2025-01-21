import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class JudgeScorePage extends StatelessWidget {
  JudgeScorePage({Key? key}) : super(key: key);

  final JudgeScoreLogic logic = Get.put(JudgeScoreLogic());
  final JudgeScoreState state = Get.find<JudgeScoreLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("综合测评")),
      body: Column(
        children: [
          // 学年下拉菜单
          Obx(() {
            final years =
                state.records.map((r) => r.academicYear).toSet().toList();
            return DropdownButton<String>(
              value: state.selectedRecord.value?.academicYear,
              items: years
                  .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      ))
                  .toList(),
              onChanged: (year) {
                if (year != null) {
                  logic.updateSelectedRecord(year);
                }
              },
            );
          }),
          // 选中记录详情
          Obx(() {
            final record = state.selectedRecord.value;
            if (record == null) {
              return Center(child: Text("暂无数据"));
            }

            // 使用 ListView 展示记录
            return Expanded(
                child: ListView(
              children: [
                ListTile(
                  title: Text("德行成绩"),
                  trailing: Text(record.moralScore.toString()),
                  leading: CircleAvatar(
                    backgroundColor: Color(("德行成绩".hashCode) | 0xFF000000),
                    child: Text(
                      "德"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("德行班级排名"),
                  trailing: Text(record.moralRankClass),
                  leading: CircleAvatar(
                    backgroundColor: Color(("德行班级排名".hashCode) | 0xFF000000),
                    child: Text(
                      "德"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("德行专业排名"),
                  trailing: Text(record.moralRankMajor),
                  leading: CircleAvatar(
                    backgroundColor: Color(("德行专业排名".hashCode) | 0xFF000000),
                    child: Text(
                      "德"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("发展成绩"),
                  trailing: Text(record.developmentScore.toString()),
                  leading: CircleAvatar(
                    backgroundColor: Color(("发展成绩".hashCode) | 0xFF000000),
                    child: Text(
                      "发"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("发展班级排名"),
                  trailing: Text(record.developmentRankClass),
                  leading: CircleAvatar(
                    backgroundColor: Color(("发展班级排名".hashCode) | 0xFF000000),
                    child: Text(
                      "发"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("发展专业排名"),
                  trailing: Text(record.developmentRankMajor),
                  leading: CircleAvatar(
                    backgroundColor: Color(("发展专业排名".hashCode) | 0xFF000000),
                    child: Text(
                      "发"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("智力成绩"),
                  trailing: Text(record.intelligenceScore.toString()),
                  leading: CircleAvatar(
                    backgroundColor: Color(("智力成绩".hashCode) | 0xFF000000),
                    child: Text(
                      "智"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("智力班级排名"),
                  trailing: Text(record.intelligenceRankClass),
                  leading: CircleAvatar(
                    backgroundColor: Color(("智力班级排名".hashCode) | 0xFF000000),
                    child: Text(
                      "智"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("智力专业排名"),
                  trailing: Text(record.intelligenceRankMajor),
                  leading: CircleAvatar(
                    backgroundColor: Color(("智力专业排名".hashCode) | 0xFF000000),
                    child: Text(
                      "智"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("体育成绩"),
                  trailing: Text(record.physicalScore.toString()),
                  leading: CircleAvatar(
                    backgroundColor: Color(("体育成绩".hashCode) | 0xFF000000),
                    child: Text(
                      "体"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("体育班级排名"),
                  trailing: Text(record.physicalRankClass),
                  leading: CircleAvatar(
                    backgroundColor: Color(("体育班级排名".hashCode) | 0xFF000000),
                    child: Text(
                      "体"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("体育专业排名"),
                  trailing: Text(record.physicalRankMajor),
                  leading: CircleAvatar(
                    backgroundColor: Color(("体育专业排名".hashCode) | 0xFF000000),
                    child: Text(
                      "体"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("劳动成绩"),
                  trailing: Text(record.laborScore.toString()),
                  leading: CircleAvatar(
                    backgroundColor: Color(("劳动成绩".hashCode) | 0xFF000000),
                    child: Text(
                      "劳"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("劳动班级排名"),
                  trailing: Text(record.laborRankClass),
                  leading: CircleAvatar(
                    backgroundColor: Color(("劳动班级排名".hashCode) | 0xFF000000),
                    child: Text(
                      "劳"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("劳动专业排名"),
                  trailing: Text(record.laborRankMajor),
                  leading: CircleAvatar(
                    backgroundColor: Color(("劳动专业排名".hashCode) | 0xFF000000),
                    child: Text(
                      "劳"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("综测总成绩"),
                  trailing: Text(record.totalScore.toString()),
                  leading: CircleAvatar(
                    backgroundColor: Color(("综测总成绩".hashCode) | 0xFF000000),
                    child: Text(
                      "综"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("总成绩班级排名"),
                  trailing: Text(record.totalRankClass),
                  leading: CircleAvatar(
                    backgroundColor: Color(("总成绩班级排名".hashCode) | 0xFF000000),
                    child: Text(
                      "总"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("总成绩专业排名"),
                  trailing: Text(record.totalRankMajor),
                  leading: CircleAvatar(
                    backgroundColor: Color(("总成绩专业排名".hashCode) | 0xFF000000),
                    child: Text(
                      "总"[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ));
          }),
        ],
      ),
    );
  }
}
