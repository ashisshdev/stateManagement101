import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:provider101/samples/weather/presentation/ui/weather_app.dart';

import '../../../mocks.mocks.dart';

void main() {
  widgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => MockWeatherProvider(),
        child: const WeatherApp(),
      ),
    );
  }

  group('initial state of weatherApp', () {
    testWidgets('app Bar is good', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());
      Finder title = find.text("Weather App");
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
}
