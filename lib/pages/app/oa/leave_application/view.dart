import 'dart:math';

import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';

import '../../../../common/global.dart';
import '../../../../common/model/font_size_model.dart';
import 'logic.dart';
import 'state.dart';

class LeaveApplicationPage extends StatelessWidget {
  LeaveApplicationPage({Key? key}) : super(key: key);

  final LeaveApplicationLogic logic = Get.put(LeaveApplicationLogic());
  final LeaveApplicationState state = Get.find<LeaveApplicationLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
      title:  Text('日常请假申请',style: TextStyle(
      fontSize:
      (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0)),
      actions: [
        TextButton(
            onPressed: () {
              logic.saveTemple();
            },
            child: Text("保存模板"))
      ],
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateTimePicker(
                  '请假开始时间',
                  state.leaveBeginDate,
                  state.leaveBeginTime,
                ),
                const SizedBox(height: 16),
                _buildDateTimePicker(
                  '请假结束时间',
                  state.leaveEndDate,
                  state.leaveEndTime,
                ),
                const SizedBox(height: 16),
                _buildRadioGroup(
                  '请假事由类型',
                  'leaveType',
                  ['求职', '实习', '返家', '培训', '旅游', '病假', '事假'],
                  state.leaveType,
                ),
                const SizedBox(height: 16),
                _buildTextField('外出请假事由', 'leaveThing', state.leaveThing),
                const SizedBox(height: 16),
                _buildCityPicker('外出地点', state.city),
                const SizedBox(height: 16),
                _buildTextField('详细地址', 'outAddress', state.outAddress),
                const SizedBox(height: 16),
                _buildRadioGroup(
                  '是否已告知家长',
                  'isTellRbl',
                  ['是', '否'],
                  state.isTellRbl,
                ),
                const SizedBox(height: 16),
                _buildTextField('同行人数', 'withNumNo', state.withNumNo),
                const SizedBox(height: 16),
                _buildTextField('家长姓名', 'jhrName', state.jhrName),
                const SizedBox(height: 16),
                _buildTextField('家长电话', 'jhrPhone', state.jhrPhone),
                const SizedBox(height: 16),
                _buildTextField('联系人姓名', 'outName', state.outName),
                const SizedBox(height: 16),
                _buildTextField('联系人固定电话', 'outTel', state.outTel),
                const SizedBox(height: 16),
                _buildTextField('联系人移动电话', 'outMoveTel', state.outMoveTel),
                const SizedBox(height: 16),
                _buildTextField('联系人关系', 'relation', state.relation),
                const SizedBox(height: 16),
                _buildTextField('学生电话', 'stuMoveTel', state.stuMoveTel),
                const SizedBox(height: 16),
                _buildDateTimePicker(
                  '去程时间',
                  state.goDate,
                  state.goTime,
                ),
                _buildRadioGroup(
                  '去程交通工具',
                  'goVehicle',
                  ['汽车', '火车', '飞机', '自行车', '其他'],
                  state.goVehicle,
                ),
                const SizedBox(height: 16),
                _buildDateTimePicker(
                  '返程时间',
                  state.backDate,
                  state.backTime,
                ),
                _buildRadioGroup(
                  '返程交通工具',
                  'backVehicle',
                  ['汽车', '火车', '飞机', '自行车', '其他'],
                  state.backVehicle,
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          logic.submitForm();
                        },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          backgroundColor: WidgetStateProperty.all(Colors.blue),
                        ),
                        child: const Text('提交申请',style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget _buildDateTimePicker(String label, RxString date, RxString time) {
    return Row(
      children: [
        Expanded(
          child: Obx(() {
            return TextField(
              controller: TextEditingController(text: date.value),
              decoration: InputDecoration(
                labelText: '$label (日期)',
                border: const OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  date.value =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  logic.updateLeaveDays();
                }
              },
            );
          }),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Obx(() {
            // 如果当前时间值为空或不在范围内，设置为默认值 "00"
            if (!List.generate(24, (index) => index.toString().padLeft(2, '0'))
                .contains(time.value)) {
              time.value = "00";
            }

            return DropdownButtonFormField<String>(
              value: time.value,
              items: List.generate(24, (index) {
                String value = index.toString().padLeft(2, '0');
                return DropdownMenuItem(
                  value: value,
                  child: Text('$value 点'),
                );
              }),
              onChanged: (newValue) => time.value = newValue ?? "00",
              decoration: InputDecoration(
                labelText: '$label (时间)',
                border: const OutlineInputBorder(),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String fieldName, RxString value,
      {bool isReadOnly = false}) {
    // 创建持久化的 TextEditingController
    final TextEditingController controller = TextEditingController();

    // 监听 RxString 的变化并更新 TextEditingController 的值
    controller.text = value.value;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      readOnly: isReadOnly,
      onChanged: isReadOnly
          ? null
          : (newValue) {
              value.value = newValue; // 更新 RxString 的值
            },
    );
  }

  Widget _buildRadioGroup(String label, String fieldName, List<String> options,
      RxString selectedValue) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8.0,
            children: options
                .map((option) => ChoiceChip(
                      label: Text(option),
                      selected: selectedValue.value == option,
                      onSelected: (isSelected) {
                        if (isSelected) selectedValue.value = option;
                      },
                    ))
                .toList(),
          ),
        ],
      );
    });
  }

  Widget _buildCityPicker(String label, RxString city) {
    return Obx(() {
      return TextField(
        controller: TextEditingController(text: city.value),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        readOnly: true,
        onTap: () async {
          Result? result = await CityPickers.showCityPicker(
            context: Get.context!,
          );
          if (result != null) {
            city.value =
                "${result.provinceName} ${result.cityName} ${result.areaName}";
            state.a1.value = result.provinceName!;
            state.a2.value = result.cityName!;
            state.a3.value = result.areaName!;
            state.area.value = result.areaId!;
          }
        },
      );
    });
  }
}
