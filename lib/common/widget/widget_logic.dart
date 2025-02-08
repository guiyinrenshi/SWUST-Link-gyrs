import 'package:home_widget/home_widget.dart';

class WidgetLogic {
  static Future<void> updateWidget(String className, String time, String location,String courseStatus) async {
    await HomeWidget.saveWidgetData<String>('class_name', className);
    await HomeWidget.saveWidgetData<String>('time_remaining', time);
    await HomeWidget.saveWidgetData<String>('location', location);
    await HomeWidget.saveWidgetData<String>('course_status', courseStatus);

    // 更新小组件
    await HomeWidget.updateWidget(name: 'ClassCardWidgetProvider');
  }


}
