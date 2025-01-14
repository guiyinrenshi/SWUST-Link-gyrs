import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/pages/web/web_view.dart';
import 'package:swust_link/spider/duifene.dart';

import 'logic.dart';
import 'state.dart';

class DuifenePaperPage extends StatelessWidget {
  DuifenePaperPage({Key? key}) : super(key: key);

  final DuifenePaperLogic logic = Get.put(DuifenePaperLogic());
  final DuifenePaperState state = Get.find<DuifenePaperLogic>().state;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("对分易在线练习"),),
  //     body: Obx(() {
  //       return ListView.builder(
  //         itemCount: state.papers.length,
  //         itemBuilder: (context, index) {
  //           Paper paper = state.papers[index];
  //           return Card(
  //             margin: EdgeInsets.all(8.0),
  //             elevation: 4.0,
  //             child: ListTile(
  //               contentPadding: EdgeInsets.all(16.0),
  //               title: Text(
  //                 paper.name,
  //                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
  //               ),
  //               subtitle: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('创建日期：${paper.createDate}', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
  //                   Text('结束日期：${paper.endDate}', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
  //                   Text('我的得分：${paper.myScore}', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
  //                   Text('我的完成日期：${paper.myDoneDate}', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
  //                 ],
  //               ),
  //               leading: Container(
  //                 width: 40,
  //                 height: 40,
  //                 decoration: BoxDecoration(
  //                   color: Colors.blue, // 可以根据试卷的某个属性设置不同的颜色
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: Center(
  //                   child: Text(
  //                     paper.name[0].toUpperCase(),
  //                     style: TextStyle(color: Colors.white, fontSize: 18.0),
  //                   ),
  //                 ),
  //               ),
  //               trailing: IconButton(
  //                 icon: Icon(Icons.arrow_forward_ios, size: 18.0),
  //                 onPressed: () {
  //                   // 点击时的处理逻辑，例如跳转到试卷详情页面
  //                   // Get.to(() => PaperDetailPage(paper: paper));
  //                   Get.to(() => WebViewPage(
  //                     url: 'https://www.duifene.com/_UserCenter/MB/index.aspx',
  //                     cookieJar: state.duifeneClient.cookieJar,
  //
  //                   ));
  //                 },
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     }),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text("对分易练习")),
          ],
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: state.papers.length,
          itemBuilder: (context, index) {
            final paper = state.papers[index];
            return ListTile(
              title: Text(paper.name),
              subtitle: Text("开始: ${paper.createDate}\n结束: ${paper.endDate}"),
              trailing: Column(
                  children: [
                    Text("分数: ${paper.myScore}"),
                  ],
                ),

              leading: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Color((paper.name.hashCode) | 0xFF000000),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  paper.name[0], // 使用文字的首字母作为图标
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
