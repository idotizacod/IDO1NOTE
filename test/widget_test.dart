import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ido1note/main.dart';

const MethodChannel _widgetChannel = MethodChannel('ido1note/widget');

void _mockWidgetChannel(WidgetTester tester) {
  tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
    _widgetChannel,
    (MethodCall call) async => null,
  );
}

void main() {
  testWidgets('IDO1NOTE muestra el editor de nota vacío', (WidgetTester tester) async {
    _mockWidgetChannel(tester);

    await tester.pumpWidget(const QuickNoteApp());
    await tester.pumpAndSettle();

    expect(find.text('IDO1NOTE'), findsOneWidget);
    expect(find.text('ESCRIBE TU NOTA...'), findsOneWidget);
    expect(find.text('VACÍO'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('escribir una nota activa el estado', (WidgetTester tester) async {
    _mockWidgetChannel(tester);

    await tester.pumpWidget(const QuickNoteApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'hola ido1note');
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('ACTIVO'), findsOneWidget);
    expect(find.text('VACÍO'), findsNothing);
  });
}