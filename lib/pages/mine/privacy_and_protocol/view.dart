import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class PrivacyAndProtocolPage extends StatelessWidget {
  PrivacyAndProtocolPage({Key? key}) : super(key: key);

  final PrivacyAndProtocolLogic logic = Get.put(PrivacyAndProtocolLogic());
  final PrivacyAndProtocolState state =
      Get.find<PrivacyAndProtocolLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('隐私与协议'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '隐私与协议',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                '1. 用户须知:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '- 本程序基于无后端架构开发，所有相关信息仅存储于您的本地设备，确保您的数据隐私安全。\n'
                '- 我们不会通过网络传输或存储您的任何数据，且不会向第三方共享。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '2. 用户行为规范:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '- 用户在使用本程序时需遵守相关法律法规，禁止通过本程序进行任何非法或有害行为。\n'
                '- 用户需妥善保管自己的设备和数据，对因用户个人行为造成的数据丢失或损坏，本程序开发者不承担任何责任。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '3. 数据使用规则:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '- 您的数据仅在本地设备上进行处理，用于提供程序功能。\n'
                '- 请勿试图篡改、反向工程或利用程序进行非授权的操作。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '4. 服务条款变更:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '- 我们保留随时更新和修改服务条款的权利，修改后的条款将通过应用内或官网通知用户。\n'
                '- 如您在条款更新后继续使用本程序，即视为您接受更新后的条款。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '5. 联系方式:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '- 邮箱：3088506834@qq.com\n',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
