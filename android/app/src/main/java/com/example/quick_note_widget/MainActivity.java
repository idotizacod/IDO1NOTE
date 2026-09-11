package com.example.quick_note_widget;

import android.content.SharedPreferences;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "ido1note/widget";
    private static final String PREFS_NAME = "ido1note_prefs";
    private static final String KEY_NOTE_CONTENT = "note_content";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler((call, result) -> {
                if ("saveNote".equals(call.method)) {
                    String content = call.argument("content");
                    saveNote(content);
                    result.success(null);
                } else if ("loadNote".equals(call.method)) {
                    result.success(loadNote());
                } else {
                    result.notImplemented();
                }
            });
    }

    @Override
    protected void onPause() {
        Ido1NoteWidgetProvider.notifyWidgetUpdate(this);
        super.onPause();
    }

    private void saveNote(String content) {
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, MODE_PRIVATE);
        prefs.edit().putString(KEY_NOTE_CONTENT, content == null ? "" : content).apply();
        Ido1NoteWidgetProvider.notifyWidgetUpdate(this);
    }

    private String loadNote() {
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, MODE_PRIVATE);
        return prefs.getString(KEY_NOTE_CONTENT, "");
    }
}