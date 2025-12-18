import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('App starts with Login Screen', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const MyApp());

    // Kiểm tra MaterialApp tồn tại
    expect(find.byType(MaterialApp), findsOneWidget);

    // Kiểm tra màn hình login (tùy text bạn có)
    expect(find.textContaining('Login'), findsWidgets);
  });
}
