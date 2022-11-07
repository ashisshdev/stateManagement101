import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider101/samples/weather/data/http/http_helper/app_exceptions.dart';
import 'package:provider101/samples/weather/data/http/weather_api.dart';

import '../../../mocks.dart';
import '../../../mocks.mocks.dart';

/// What is the purpose of WeatherApiServiceImpl Class ?
/// Its purpose is to make api requests and forward the response received.
/// Its only functions are receiving inputs and make calls and return results as they are.

void main() {
  late WeatherApiService sut;
  late MockServer mockServer;

  WeatherApiTestMockData weatherApiTestMockData = WeatherApiTestMockData();

  setUp(() {
    mockServer = MockServer();
    sut = WeatherApiServiceImpl(server: mockServer);
  });

  group(("testing weather api service methods"), () {
    test("get weather by city name - success", () async {
      when(mockServer.get(city: 'city'))
          .thenAnswer((invocation) => Future.value(weatherApiTestMockData.successResponse));
      expect(await sut.fetchWeatherByCity(city: "city"), weatherApiTestMockData.successResponse);
      verify(mockServer.get(city: 'city')).called(1);
    });

    test("get weather by city name - server side error", () async {
      when(mockServer.get(city: "city")).thenThrow(IncorrectQueryException(code: 401, url: "url"));
      expect(sut.fetchWeatherByCity(city: "city"), throwsA(isInstanceOf<IncorrectQueryException>()));
      verify(mockServer.get(city: 'city')).called(1);
    });

    test("get weather by city name - some device error", () async {
      when(mockServer.get(city: "city")).thenThrow(NoConnectionException(code: 0, url: "url"));
      expect(sut.fetchWeatherByCity(city: "city"), throwsA(isInstanceOf<NoConnectionException>()));
      verify(mockServer.get(city: 'city')).called(1);
    });
  });
}
