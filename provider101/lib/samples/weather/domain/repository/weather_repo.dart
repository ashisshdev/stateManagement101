import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:provider101/samples/weather/data/http/http_helper/AppExceptions.dart';
import 'package:provider101/samples/weather/data/http/weather_api.dart';
import 'package:provider101/samples/weather/domain/models/data_error_model.dart';
import 'package:provider101/samples/weather/domain/models/weather_data_model.dart';

abstract class WeatherRepository {
  Future<Either<WeatherData, DataError>> fetchWeatherByCity({required String city});
}

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService apiService;

  WeatherRepositoryImpl({required this.apiService});

  @override
  Future<Either<WeatherData, DataError>> fetchWeatherByCity({required String city}) async {
    try {
      var response = await apiService.fetchWeatherByCity(city: city);
      if (response.statusCode == 200) {
        return Left(WeatherData.fromJson(jsonDecode(response.body)));
      } else {
        return Right(DataError(title: "Error", description: "Desc", code: 0, url: "NoUrl"));
      }
    } catch (error) {
      AppException exception = error as AppException;
      return Right(DataError(
          title: exception.title, description: exception.description, code: exception.code, url: exception.url));
    }
  }
}
