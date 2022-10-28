import 'dart:async';

import 'package:http/http.dart' as http;

import 'http_helper/base_http.dart';

abstract class WeatherApiService {
  Future<http.Response> fetchWeatherByCity({required String city});
}

class WeatherApiServiceImpl implements WeatherApiService {
  final Server server;

  WeatherApiServiceImpl({required this.server});

  @override
  Future<http.Response> fetchWeatherByCity({required String city}) async {
    return await server.get(city: city);
  }
}
