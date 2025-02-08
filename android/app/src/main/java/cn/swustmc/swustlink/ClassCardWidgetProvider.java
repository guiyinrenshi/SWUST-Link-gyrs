package cn.swustmc.swustlink;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.SharedPreferences;
import android.widget.RemoteViews;
import android.content.Intent;
import android.app.PendingIntent;
public class ClassCardWidgetProvider extends AppWidgetProvider {

    public static void updateAppWidget(Context context, AppWidgetManager appWidgetManager, int appWidgetId) {
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.class_card_widget_layout);

        // 从 SharedPreferences 获取数据（Flutter 端存储）
        SharedPreferences prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE);
        String className = prefs.getString("class_name", "暂无课程");
        String timeRemaining = prefs.getString("time_remaining", "时间剩余");
        String location = prefs.getString("location", "未知地点");
        String course_status = prefs.getString("course_status", "课程状态:");

        views.setTextViewText(R.id.class_name, className);
        views.setTextViewText(R.id.time_remaining, timeRemaining);
        views.setTextViewText(R.id.location, location);
        views.setTextViewText(R.id.course_status, course_status);
        // 设置点击事件 -> 启动 MainActivity
        Intent intent = new Intent(context, MainActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(
                context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE
        );
        views.setOnClickPendingIntent(R.id.widget_container, pendingIntent);
        appWidgetManager.updateAppWidget(appWidgetId, views);
    }

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        for (int appWidgetId : appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId);
        }
    }
}
