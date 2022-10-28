import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:provider101/samples/weather/presentation/controllers/weather_provider.dart';
import 'package:provider101/samples/weather/presentation/ui/weather_app.dart';

import '../../../mocks.dart';
import '../../../mocks.mocks.dart';

void main() {
  late MockWeatherProvider mockWeatherProvider;
  late Widget widgetUnderTest;
  final WeatherAppWidgetMockData weatherAppWidgetMockData = WeatherAppWidgetMockData();

  setUpAll(() {
    mockWeatherProvider = MockWeatherProvider();
    widgetUnderTest = ChangeNotifierProvider<WeatherProvider>.value(
      /// this is where we are mockProvider instead of real
      value: mockWeatherProvider,
      child: const MaterialApp(home: WeatherApp()),
    );
  });

  /// I better store all these Widgets keys in a separate file under app_theme folder
  Finder title = find.text("Weather App");
  Finder textField = find.byKey(const Key("city search text-field"));
  Finder searchButton = find.byKey(const Key("Icon Button"));
  Finder instructionText = find.text("Enter city name to fetch weather.");
  Finder circularProgressIndicator = find.byKey(const Key("circular progress indicator"));
  Finder snackBar = find.byType(SnackBar);

  testWidgets('should show static widgets in Initial State', (WidgetTester tester) async {
    when(mockWeatherProvider.status).thenReturn(Status.initial);
    await tester.pumpWidget(widgetUnderTest);

    // app bar
    expect(title, findsOneWidget);
    expect(textField, findsOneWidget);
    expect(searchButton, findsOneWidget);
    expect(instructionText, findsOneWidget);
  });

  testWidgets('should trigger a SnackBar when user enters nothing and hit search', (WidgetTester tester) async {
    when(mockWeatherProvider.status).thenReturn(Status.initial);
    await tester.pumpWidget(widgetUnderTest);

    /// now use do not enter anything into the textField
    /// and he taps on searchButton

    await tester.tap(searchButton);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(snackBar, equals(findsOneWidget));

    expect(textField, findsOneWidget);
    expect(searchButton, findsOneWidget);
    expect(instructionText, findsOneWidget);
    expect(circularProgressIndicator, findsNothing);

    // textField
  });

  testWidgets('should trigger a SnackBar when user enters less than 3 characters and hit search',
      (WidgetTester tester) async {
    when(mockWeatherProvider.status).thenReturn(Status.initial);
    await tester.pumpWidget(widgetUnderTest);

    /// now use do not enter anything into the textField
    /// and he taps on searchButton

    await tester.enterText(textField, "oi");
    await tester.tap(searchButton);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(snackBar, equals(findsOneWidget));

    expect(textField, findsOneWidget);
    expect(searchButton, findsOneWidget);
    expect(instructionText, findsOneWidget);
    expect(circularProgressIndicator, findsNothing);

    // textField
  });

  testWidgets('should show CircularProgressIndicator while Loading', (WidgetTester tester) async {
    when(mockWeatherProvider.status).thenReturn(Status.loading);

    await tester.pumpWidget(widgetUnderTest);

    // await tester.enterText(textField, "goa");
    // await tester.tap(searchButton);

    expect(circularProgressIndicator, findsOneWidget);
    expect(textField, findsOneWidget);
    expect(searchButton, findsOneWidget);
    expect(instructionText, findsNothing);
    // textField
  });

  testWidgets('should show data when success', (WidgetTester tester) async {
    when(mockWeatherProvider.status).thenReturn(Status.success);
    when(mockWeatherProvider.weatherData).thenReturn(weatherAppWidgetMockData.goaWeatherData);

    await tester.pumpWidget(widgetUnderTest);

    expect(find.text(weatherAppWidgetMockData.goaWeatherData.main.temp.toString()), findsOneWidget);

    expect(textField, findsOneWidget);
    expect(searchButton, findsOneWidget);
    expect(circularProgressIndicator, findsNothing);
    expect(instructionText, findsNothing);
  });

  testWidgets('should show error when error', (WidgetTester tester) async {
    when(mockWeatherProvider.status).thenReturn(Status.error);
    when(mockWeatherProvider.error).thenReturn("Some Error !");

    when(mockWeatherProvider.weatherData).thenReturn(weatherAppWidgetMockData.goaWeatherData);

    await tester.pumpWidget(widgetUnderTest);

    expect(find.text("Some Error !"), findsOneWidget);

    expect(textField, findsOneWidget);
    expect(searchButton, findsOneWidget);
    expect(circularProgressIndicator, findsNothing);
    expect(instructionText, findsNothing);
  });
}
