import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/oa/leave_form.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/spider/xsc_leave.dart';
import 'package:swust_link/spider/xsc_oa.dart';

import 'state.dart';

class LeaveApplicationLogic extends GetxController {
  final LeaveApplicationState state = LeaveApplicationState();

  @override
  void onInit() {
    super.onInit();
    loadTemple();
  }

  LeaveApplication getLeaveApplication() {
    return LeaveApplication(
        eventTarget: state.eventTarget.value,
        eventArgument: state.eventArgument.value,
        viewState: state.viewState.value,
        viewStateGenerator: state.viewStateGenerator.value,
        leaveBeginDate: state.leaveBeginDate.value,
        leaveBeginTime: state.leaveBeginTime.value,
        leaveEndDate: state.leaveEndDate.value,
        leaveEndTime: state.leaveEndTime.value,
        leaveNumNo: state.leaveNumNo.value,
        leaveType: state.leaveType.value,
        leaveThing: state.leaveThing.value,
        area: state.area.value,
        comeWhere1: state.comeWhere1.value,
        a1: state.a1.value,
        a2: state.a2.value,
        a3: state.a3.value,
        outAddress: state.outAddress.value,
        isTellRbl: state.isTellRbl.value,
        withNumNo: state.withNumNo.value,
        jhrName: state.jhrName.value,
        jhrPhone: state.jhrPhone.value,
        outTel: state.outTel.value,
        outMoveTel: state.outMoveTel.value,
        relation: state.relation.value,
        outName: state.outName.value,
        goTime: state.goTime.value,
        goVehicle: state.goVehicle.value,
        backTime: state.backTime.value,
        backVehicle: state.backVehicle.value,
        stuMoveTel: state.stuMoveTel.value,
        hidden1: state.hidden1.value);
  }

  Future<void> submitForm() async {
    // 打印表单数据（可以替换为实际的提交逻辑）
    LeaveApplication leaveApplication = getLeaveApplication();
    leaveApplication.comeWhere1 =
        leaveApplication.a1 + leaveApplication.a2 + leaveApplication.a3;
    leaveApplication = await (await XSCOA.getInstance())!
        .xscLeave
        .getLeaveHiddenParams(leaveApplication);
    Logger().i(await leaveApplication.toFormData());

    final msg = await (await XSCOA.getInstance())!
        .xscLeave
        .submitLeaveApplication(leaveApplication);

    Get.snackbar('提交成功', '您的请假申请已提交！$msg', backgroundColor: Colors.white);
  }

  void saveTemple() {
    Global.localStorageService
        .saveToLocal([getLeaveApplication()], "leaveApplicationTemple");
    Get.snackbar("缓存成功", "保存模板成功!", backgroundColor: Colors.white);
  }

  void loadTemple() async {
    try {
      // 从本地存储中加载模板数据
      List<LeaveApplication> temples = await Global.localStorageService
          .loadFromLocal("leaveApplicationTemple",
              (json) => LeaveApplication.fromJson(json));

      if (temples.isNotEmpty) {
        // 取出第一个模板
        LeaveApplication leaveApplication = temples[0];
        state.leaveBeginTime.value = leaveApplication.leaveBeginTime;
        state.leaveEndTime.value = leaveApplication.leaveEndTime;
        state.leaveNumNo.value = leaveApplication.leaveNumNo;
        state.leaveType.value = leaveApplication.leaveType;
        state.leaveThing.value = leaveApplication.leaveThing;
        state.area.value = leaveApplication.area;
        state.comeWhere1.value = leaveApplication.comeWhere1;
        state.a1.value = leaveApplication.a1;
        state.a2.value = leaveApplication.a2;
        state.a3.value = leaveApplication.a3;
        state.outAddress.value = leaveApplication.outAddress;
        state.isTellRbl.value = leaveApplication.isTellRbl;
        state.withNumNo.value = leaveApplication.withNumNo;
        state.jhrName.value = leaveApplication.jhrName;
        state.jhrPhone.value = leaveApplication.jhrPhone;
        state.outTel.value = leaveApplication.outTel;
        state.outMoveTel.value = leaveApplication.outMoveTel;
        state.relation.value = leaveApplication.relation;
        state.outName.value = leaveApplication.outName;
        state.goTime.value = leaveApplication.goTime;
        state.goVehicle.value = leaveApplication.goVehicle;
        state.backTime.value = leaveApplication.backTime;
        state.backVehicle.value = leaveApplication.backVehicle;
        state.stuMoveTel.value = leaveApplication.stuMoveTel;
        Logger().i(leaveApplication.stuMoveTel);

        state.city.value =
            "${leaveApplication.a1} ${leaveApplication.a2} ${leaveApplication.a3}";

        Get.snackbar("加载成功", "模板数据已成功加载！",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
      } else {
        Get.snackbar("加载失败", "没有找到可用的模板数据",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
      }
    } catch (e) {
      Logger().e(e);
      Get.snackbar("加载失败", "模板数据加载出错，请重试！",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
    }
  }

  void updateLeaveDays() {
    try {
      if (state.leaveBeginDate.value.isNotEmpty &&
          state.leaveEndDate.value.isNotEmpty) {
        DateTime beginDate = DateTime.parse(state.leaveBeginDate.value);
        DateTime endDate = DateTime.parse(state.leaveEndDate.value);

        if (endDate.isBefore(beginDate)) {
          state.leaveNumNo.value = "0"; // 如果结束日期早于开始日期，则设置为0
          Get.snackbar("错误", "请假结束日期必须晚于或等于开始日期！");
          return;
        }

        // 计算天数
        int days = endDate.difference(beginDate).inDays + 1;
        state.leaveNumNo.value = days.toString();
      } else {
        state.leaveNumNo.value = "0"; // 日期为空时显示为0
      }
    } catch (e) {
      state.leaveNumNo.value = "0"; // 异常情况下设置为0
      Get.snackbar("错误", "日期格式错误，请重新选择！");
    }
  }
}
