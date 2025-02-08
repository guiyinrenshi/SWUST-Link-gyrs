package cn.swustmc.swust_link;

import android.appwidget.AppWidgetProvider;
import android.appwidget.AppWidgetManager;
import android.content.Context;
import android.content.Intent;
import android.widget.RemoteViews;
import cn.swustmc.swust_link.R;

public class MyWidgetProvider extends AppWidgetProvider {

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        // For each widget instance, update the widget
        for (int appWidgetId : appWidgetIds) {
            // Create a new RemoteViews object
            RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_layout);

            // Set up the widget view (e.g., set a text, image, etc.)
            views.setTextViewText(R.id.widget_text, "Hello from Flutter!");

            // Tell the AppWidgetManager to update the widget
            appWidgetManager.updateAppWidget(appWidgetId, views);
        }
    }

    @Override
    public void onEnabled(Context context) {
        // Widget is created, perform any initial setup
    }

    @Override
    public void onDisabled(Context context) {
        // Widget is destroyed, cleanup if necessary
    }
}
