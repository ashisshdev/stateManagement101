import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider101/samples/weather/presentation/controllers/weather_provider.dart';

import '../../../mocks.dart';
import '../../../mocks.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late WeatherProvider sut;

  final WeatherProviderMockData weatherProviderMockData = WeatherProviderMockData();

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    sut = WeatherProvider(weatherDataRepo: mockWeatherRepository);
  });

  test("Provider - get weather by city - success", () async {
    when(mockWeatherRepository.fetchWeatherByCity(city: "city"))
        .thenAnswer((_) async => Left(weatherProviderMockData.goaWeatherData));

    /// running function
    sut.getWeatherDataByCity("city");

    /// expecting change in status
    expect(sut.status, Status.loading);

    /// waiting for few seconds as waiting originally in real function implementation
    await Future.delayed(const Duration(seconds: 3));

    /// verifying the function dependency repository was called
    verify(mockWeatherRepository.fetchWeatherByCity(city: "city")).called(1);

    /// expecting change in variables
    expect(sut.status, Status.success);
    expect(sut.weatherData, weatherProviderMockData.goaWeatherData);
  });

  test("Provider - get weather by city - failure 1", () async {
    when(mockWeatherRepository.fetchWeatherByCity(city: "city"))
        .thenAnswer((_) async => Right(weatherProviderMockData.dataError1));

    /// running function
    sut.getWeatherDataByCity("city");

    /// expecting change in status
    expect(sut.status, Status.loading);

    /// waiting for few seconds as waiting originally in real function implementation
    await Future.delayed(const Duration(seconds: 3));

    /// verifying the function dependency repository was called
    verify(mockWeatherRepository.fetchWeatherByCity(city: "city")).called(1);

    /// expecting change in variables
    expect(sut.status, Status.error);
    expect(sut.error, weatherProviderMockData.dataError1.title);
  });
}
