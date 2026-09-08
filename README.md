# IDO1NOTE — Ultra-Studio

Nota rápida con guardado automático y widget de pantalla de inicio. Escribe una sola nota; se guarda sola mientras tipeas y se sincroniza al home widget de Android.

**Stack:** Flutter (Material 3) + widget nativo Android (AppWidgetProvider + MethodChannel).
**Estética:** VOCAL ULTRA-STUDIO / Idotiza — JetBrains Mono, knob con espiral dibujado a mano, display oscuro con métricas CHARS/LINES, rojo = ACTIVO, footer "IDOTIZA".

## Estructura
```
quick_note_widget/
 ├─ lib/main.dart       — Toda la UI Flutter + _KnobPainter (espiral, notch, punto)
 ├─ web/                — Build web + manifest PWA con icono knob
 ├─ android/            — MainActivity + Ido1NoteWidgetProvider + WidgetConfigureActivity
 └─ IDO1NOTE.apk        — APK Android (debug)
```

## Widget home
`ido1note_widget.xml` (110dp) lee la nota vía SharedPreferences mediante `MethodChannel('ido1note/widget')` → `MainActivity`:
- Guardar: `saveNote({content})`
- Leer: `loadNote`

## Características
- Auto-guardado en cada tecla.
- Contador de caracteres y líneas en display oscuro.
- Indicador ACTIVO/VACÍO en knob; estado LIVE rojo.
- Limpiar con haptic.
- Tema claro/oscuro 1:1 con tokens Ultra-Studio.

## APK
`IDO1NOTE.apk` — Android debug (Flutter).

## Web
`web/` contiene el target web con manifest PWA, colores `#121212`/`#f8f9fa`, icono knob y favicon/logo `.ico`.
