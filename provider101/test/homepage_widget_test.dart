import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider101/homepage.dart';

void main() {
  widgetUnderTest() {
    return const MaterialApp(
      home: HomePage(),
    );
  }

  group('initial state of homepage', () {
    testWidgets('app Bar', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      Finder title = find.text("Provider Examples");
      expect(title, findsOneWidget);
    });
  });

  testWidgets('Examples Tiles', (WidgetTester tester) async {
    await tester.pumpWidget(widgetUnderTest());

    Finder title1 = find.text("Counter Example");
    expect(title1, findsOneWidget);

    Finder title2 = find.text("Weather Example");
    expect(title2, findsOneWidget);

    // Finder containerWidget = find.byKey(const Key("container-key"));
    // expect(containerWidget, findsOneWidget);
  });
}
