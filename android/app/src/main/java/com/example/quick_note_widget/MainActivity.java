package com.example.quick_note_widget;

import android.content.SharedPreferences;
import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "ido1note/widget";
    private static final String PREFS_NAME = "ido1note_prefs";
    private static final String KEY_NOTE_CONTENT = "note_content";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler((call, result) -> {
                if (call.method.equals("saveNote")) {
                    String content = call.argument("content");
                    saveNote(content);
                    result.success(null);
                } else if (call.method.equals("loadNote")) {
                    String content = loadNote();
                    result.success(content);
                } else {
                    result.notImplemented();
                }
            });
    }

    private void saveNote(String content) {
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, MODE_PRIVATE);
        prefs.edit().putString(KEY_NOTE_CONTENT, content).apply();
        Ido1NoteWidgetProvider.notifyWidgetUpdate(this);
    }

    private String loadNote() {
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, MODE_PRIVATE);
        return prefs.getString(KEY_NOTE_CONTENT, "");
    }
}