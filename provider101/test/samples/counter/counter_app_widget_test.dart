import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:provider101/samples/counter/counter_app.dart';
import 'package:provider101/samples/counter/counter_provider.dart';

void main() {
  widgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => CounterProvider(),
        child: const CounterApp(),
      ),
    );
  }

  group('initial state of counterApp', () {
    testWidgets('app Bar is good', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      Finder title = find.text("Counter App");
      expect(title, findsOneWidget);
    });

    testWidgets('Static Widgets are good', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      Finder text1 = find.text("Counter Value is");
      expect(text1, findsOneWidget);

      Finder text2 = find.text("0");
      expect(text2, findsOneWidget);

      Finder addIcon = find.byIcon(Icons.exposure_plus_1);
      expect(addIcon, findsOneWidget);

      Finder subIcon = find.byIcon(Icons.exposure_minus_1);
      expect(subIcon, findsOneWidget);

      Finder resetIcon = find.byIcon(Icons.refresh);
      expect(resetIcon, findsOneWidget);

      // Finder containerWidget = find.byKey(const Key("container-key"));
      // expect(containerWidget, findsOneWidget);
    });
  });

  group('interacting with counterApp Widgets', () {
    testWidgets('tapping increment icon', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      /// find counter value text widget with initial value
      Finder counterValueTextBefore = find.text("0");
      expect(counterValueTextBefore, findsOneWidget);

      /// find increment value TextButton widget with icon child
      Finder incrementButton = find.widgetWithIcon(TextButton, Icons.exposure_plus_1);
      expect(incrementButton, findsOneWidget);

      /// tap on the button we found
      await tester.tap(incrementButton);

      /// rebuilds state after widget rebuild
      await tester.pump();

      /// find counter value text widget AGAIN with expected new value
      Finder counterValueTextAfter = find.text("1");
      expect(counterValueTextAfter, findsOneWidget);

      /// and there should not be any widget with previous value i.e. 0
      expect(counterValueTextBefore, findsNothing);
    });

    testWidgets('tapping decrement icon', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      /// find counter value text widget with initial value
      Finder counterValueTextBefore = find.text("0");
      expect(counterValueTextBefore, findsOneWidget);

      /// find increment value TextButton widget with icon child
      Finder decrementButton = find.widgetWithIcon(TextButton, Icons.exposure_minus_1);
      expect(decrementButton, findsOneWidget);

      /// tap on the button we found
      await tester.tap(decrementButton);

      /// rebuilds state after widget rebuild
      await tester.pump();

      /// find counter value text widget AGAIN with expected new value
      Finder counterValueTextAfter = find.text("-1");
      expect(counterValueTextAfter, findsOneWidget);

      /// and there should not be any widget with previous value i.e. 0
      expect(counterValueTextBefore, findsNothing);
    });

    testWidgets('tapping reset after increment icon', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      /// find counter value text widget with initial value
      Finder counterValueTextBefore = find.text("0");
      expect(counterValueTextBefore, findsOneWidget);

      /// find increment value TextButton widget with icon child
      Finder incrementButton = find.widgetWithIcon(TextButton, Icons.exposure_plus_1);
      expect(incrementButton, findsOneWidget);

      /// tap on the button we found
      await tester.tap(incrementButton);

      /// rebuilds state after widget rebuild
      await tester.pump();

      /// find counter value text widget AGAIN with expected new value
      Finder counterValueTextAfter = find.text("1");
      expect(counterValueTextAfter, findsOneWidget);

      /// and there should not be any widget with previous value i.e. 0
      expect(counterValueTextBefore, findsNothing);

      /// find reset value TextButton widget with icon child
      Finder resetButton = find.widgetWithIcon(TextButton, Icons.refresh);
      expect(resetButton, findsOneWidget);

      /// tap on the button we found
      await tester.tap(resetButton);

      /// rebuilds state after widget rebuild
      await tester.pump();

      /// and there should be one widget with 0 i.e. initial value
      expect(counterValueTextBefore, findsOneWidget);
    });

    testWidgets('tapping reset after decrement icon', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      /// find counter value text widget with initial value
      Finder counterValueTextBefore = find.text("0");
      expect(counterValueTextBefore, findsOneWidget);

      /// find increment value TextButton widget with icon child
      Finder decrementButton = find.widgetWithIcon(TextButton, Icons.exposure_minus_1);
      expect(decrementButton, findsOneWidget);

      /// tap on the button we found
      await tester.tap(decrementButton);

      /// rebuilds state after widget rebuild
      await tester.pump();

      /// find counter value text widget AGAIN with expected new value
      Finder counterValueTextAfter = find.text("-1");
      expect(counterValueTextAfter, findsOneWidget);

      /// and there should not be any widget with previous value i.e. 0
      expect(counterValueTextBefore, findsNothing);

      /// find reset value TextButton widget with icon child
      Finder resetButton = find.widgetWithIcon(TextButton, Icons.refresh);
      expect(resetButton, findsOneWidget);

      /// tap on the button we found
      await tester.tap(resetButton);

      /// rebuilds state after widget rebuild
      await tester.pump();

      /// and there should be one widget with 0 i.e. initial value
      expect(counterValueTextBefore, findsOneWidget);
    });

    testWidgets('tapping reset after tapping decrement icon 5 times', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      /// find counter value text widget with initial value
      Finder counterValueTextBefore = find.text("0");
      expect(counterValueTextBefore, findsOneWidget);

      /// find increment value TextButton widget with icon child
      Finder decrementButton = find.widgetWithIcon(TextButton, Icons.exposure_minus_1);
      expect(decrementButton, findsOneWidget);

      /// tap on the button we found
      for (int i = 0; i < 5; i++) {
        await tester.tap(decrementButton);
      }

      /// rebuilds state after widget rebuild
      await tester.pump();

      /// find counter value text widget AGAIN with expected new value
      Finder counterValueTextAfter = find.text("-5");
      expect(counterValueTextAfter, findsOneWidget);

      /// and there should not be any widget with previous value i.e. 0
      expect(counterValueTextBefore, findsNothing);

      /// find reset value TextButton widget with icon child
      Finder resetButton = find.widgetWithIcon(TextButton, Icons.refresh);
      expect(resetButton, findsOneWidget);

      /// tap on the button we found
      await tester.tap(resetButton);

      /// rebuilds state after widget rebuild
      await tester.pump();

      /// and there should be one widget with 0 i.e. initial value
      expect(counterValueTextBefore, findsOneWidget);
    });
  });
}

/// finding widgets with the help of a key
// Finder containerWidget = find.byKey(const Key("container-key"));
// expect(containerWidget, findsOneWidget);

/// finding widgets with the help of a text
//  Finder counterValueTextAfter = find.text("-5");
//  expect(counterValueTextAfter, findsOneWidget);

/// finding button with help of icon
//  Finder resetButton = find.widgetWithIcon(TextButton, Icons.refresh);
//  expect(resetButton, findsOneWidget);
//  tap on the button we found
//  await tester.tap(resetButton);
//  rebuilds state after widget rebuild
//  await tester.pump();
