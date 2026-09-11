package com.example.quick_note_widget;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.RemoteViews;
import com.example.quick_note_widget.R;

public class Ido1NoteWidgetProvider extends AppWidgetProvider {

    private static final String PREFS_NAME = "ido1note_prefs";
    private static final String KEY_NOTE_CONTENT = "note_content";

    @Override
    public void onEnabled(Context context) {
        super.onEnabled(context);
        // First widget created - ensure initial update
        notifyWidgetUpdate(context);
    }

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        for (int appWidgetId : appWidgetIds) {
            updateWidget(context, appWidgetManager, appWidgetId);
        }
    }

    @Override
    public void onAppWidgetOptionsChanged(Context context, AppWidgetManager appWidgetManager, int appWidgetId, Bundle newOptions) {
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions);
        updateWidget(context, appWidgetManager, appWidgetId);
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        super.onReceive(context, intent);
        // Handle custom actions if needed
        if (intent.getAction() != null && intent.getAction().equals("ido1note.FORCE_UPDATE")) {
            notifyWidgetUpdate(context);
        }
    }

    public static void updateWidget(Context context, AppWidgetManager appWidgetManager, int appWidgetId) {
        SharedPreferences prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        String noteContent = prefs.getString(KEY_NOTE_CONTENT, "");

        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.ido1note_widget);

        if (noteContent.isEmpty()) {
            views.setTextViewText(R.id.widget_content, "Toca para escribir...");
        } else {
            String displayText = noteContent.length() > 200 
                ? noteContent.substring(0, 200) + "..." 
                : noteContent;
            views.setTextViewText(R.id.widget_content, displayText);
        }

        Intent intent = new Intent(context, QuickNoteInputActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        android.app.PendingIntent pendingIntent = android.app.PendingIntent.getActivity(
            context, 0, intent, 
            android.app.PendingIntent.FLAG_UPDATE_CURRENT | android.app.PendingIntent.FLAG_IMMUTABLE
        );
        views.setOnClickPendingIntent(R.id.widget_root, pendingIntent);

        appWidgetManager.updateAppWidget(appWidgetId, views);
    }

    public static void notifyWidgetUpdate(Context context) {
        AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(context);
        int[] appWidgetIds = appWidgetManager.getAppWidgetIds(
            new android.content.ComponentName(context, Ido1NoteWidgetProvider.class)
        );
        for (int appWidgetId : appWidgetIds) {
            updateWidget(context, appWidgetManager, appWidgetId);
        }
    }
}