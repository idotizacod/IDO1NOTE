package com.example.quick_note_widget;

import android.app.Activity;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;

public class QuickNoteInputActivity extends Activity {

    private static final String PREFS_NAME = "ido1note_prefs";
    private static final String KEY_NOTE_CONTENT = "note_content";

    private EditText inputNote;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_quick_note_input);

        inputNote = findViewById(R.id.input_note);

        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, MODE_PRIVATE);
        inputNote.setText(prefs.getString(KEY_NOTE_CONTENT, ""));
        inputNote.setSelection(inputNote.getText().length());
        inputNote.requestFocus();

        findViewById(R.id.btn_save).setOnClickListener(view -> saveAndFinish());

        View overlay = findViewById(R.id.input_overlay);
        overlay.setOnClickListener(view -> finish());
    }

    @Override
    protected void onStop() {
        hideKeyboard();
        super.onStop();
    }

    private void saveAndFinish() {
        String content = inputNote.getText().toString();
        getSharedPreferences(PREFS_NAME, MODE_PRIVATE)
                .edit()
                .putString(KEY_NOTE_CONTENT, content)
                .apply();
        Ido1NoteWidgetProvider.notifyWidgetUpdate(this);
        hideKeyboard();
        finish();
    }

    private void hideKeyboard() {
        InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
        if (imm != null && getCurrentFocus() != null) {
            imm.hideSoftInputFromWindow(getCurrentFocus().getWindowToken(), 0);
        }
    }
}