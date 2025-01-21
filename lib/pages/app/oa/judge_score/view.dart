import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/judge_score.dart';

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
            return Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: state.selectedRecord.value?.academicYear,
                    isExpanded: true,
                    // 确保下拉菜单项占满宽度
                    underline: SizedBox(),
                    // 隐藏默认下划线
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
                  )),
            );
          }),
          // 筛选条件
          Obx(() {
            final filters = ["成绩", "班级排名", "专业排名"];
            return Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  value: state.selectedFilter.value,
                  isExpanded: true,
                  // 确保下拉菜单项占满宽度
                  underline: SizedBox(),
                  // 隐藏默认下划线
                  items: filters
                      .map((filter) => DropdownMenuItem(
                            value: filter,
                            child: Text(filter),
                          ))
                      .toList(),
                  onChanged: (filter) {
                    if (filter != null) {
                      state.selectedFilter.value = filter;
                    }
                  },
                ),
              ),
            );
          }),
          // 选中记录详情
          Obx(() {
            final record = state.selectedRecord.value;
            if (record == null) {
              return Center(child: Text("暂无数据"));
            }

            // 根据筛选条件调整展示内容
            final filter = state.selectedFilter.value;
            final items = _getFilteredItems(record, filter);

            // 使用 ListView 展示记录
            return Expanded(
                child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item['title']!),
                  trailing: Text(item['value']!),
                  leading: CircleAvatar(
                    backgroundColor:
                        Color((item['title'].hashCode) | 0xFF000000),
                    child: Text(
                      item['title']![0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ));
          }),
        ],
      ),
    );
  }

  // 获取筛选后的内容
  List<Map<String, String>> _getFilteredItems(
      JudgeScore record, String filter) {
    switch (filter) {
      case "成绩":
        return [
          {'title': "德行成绩", 'value': record.moralScore.toString()},
          {'title': "发展成绩", 'value': record.developmentScore.toString()},
          {'title': "智力成绩", 'value': record.intelligenceScore.toString()},
          {'title': "体育成绩", 'value': record.physicalScore.toString()},
          {'title': "劳动成绩", 'value': record.laborScore.toString()},
          {'title': "综测总成绩", 'value': record.totalScore.toString()},
        ];
      case "班级排名":
        return [
          {'title': "德行班级排名", 'value': record.moralRankClass},
          {'title': "发展班级排名", 'value': record.developmentRankClass},
          {'title': "智力班级排名", 'value': record.intelligenceRankClass},
          {'title': "体育班级排名", 'value': record.physicalRankClass},
          {'title': "劳动班级排名", 'value': record.laborRankClass},
          {'title': "总成绩班级排名", 'value': record.totalRankClass},
        ];
      case "专业排名":
        return [
          {'title': "德行专业排名", 'value': record.moralRankMajor},
          {'title': "发展专业排名", 'value': record.developmentRankMajor},
          {'title': "智力专业排名", 'value': record.intelligenceRankMajor},
          {'title': "体育专业排名", 'value': record.physicalRankMajor},
          {'title': "劳动专业排名", 'value': record.laborRankMajor},
          {'title': "总成绩专业排名", 'value': record.totalRankMajor},
        ];
      default:
        return [];
    }
  }
}
