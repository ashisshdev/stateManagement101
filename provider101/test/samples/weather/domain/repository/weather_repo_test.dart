import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider101/samples/weather/data/http/http_helper/AppExceptions.dart';
import 'package:provider101/samples/weather/domain/models/data_error_model.dart';
import 'package:provider101/samples/weather/domain/models/weather_data_model.dart';
import 'package:provider101/samples/weather/domain/repository/weather_repo.dart';

import '../../../mocks.dart';
import '../../../mocks.mocks.dart';

void main() {
  late WeatherRepository sut;
  late MockWeatherApiService mockWeatherApiService;

  final WeatherRepoMockData weatherRepoMockData = WeatherRepoMockData();

  setUp(() {
    mockWeatherApiService = MockWeatherApiService();
    sut = WeatherRepositoryImpl(apiService: mockWeatherApiService);
  });

  group("Testing get Weather By City name method", () {
    test(
      "get weather by city success 1",
      () async {
        when(mockWeatherApiService.fetchWeatherByCity(city: "city"))
            .thenReturn(Future.value(weatherRepoMockData.goodResponse));

        final result = await sut.fetchWeatherByCity(city: "city");
        verify(mockWeatherApiService.fetchWeatherByCity(city: "city")).called(1);
        result.fold((weatherData) {
          expect(weatherData, isInstanceOf<WeatherData>());
        }, (r) {});
        // expect(result, Right(weatherRepoMockData.dataError));
        verifyNoMoreInteractions(mockWeatherApiService);
      },
    );

    test(
      "get weather by city DataError 1 - Error 404 ",
      () async {
        when(mockWeatherApiService.fetchWeatherByCity(city: "city"))
            .thenThrow(UnknownException(title: "Error", description: "Desc", code: 0, url: "NoUrl"));

        final result = await sut.fetchWeatherByCity(city: "city");
        verify(mockWeatherApiService.fetchWeatherByCity(city: "city")).called(1);
        result.fold((l) {}, (dataError) {
          expect(dataError, isInstanceOf<DataError>());
        });
        // expect(result, Right(weatherRepoMockData.dataError));
        verifyNoMoreInteractions(mockWeatherApiService);
      },
    );
  });
}
