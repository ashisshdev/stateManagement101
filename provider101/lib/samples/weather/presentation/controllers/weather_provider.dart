import 'package:flutter/cupertino.dart';
import 'package:provider101/samples/weather/domain/models/weather_data_model.dart';
import 'package:provider101/samples/weather/domain/repository/weather_repo.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository weatherDataRepo;

  WeatherProvider({required this.weatherDataRepo});

  late WeatherData _weatherData;
  Status _status = Status.initial;
  late String _error;

  WeatherData get weatherData => _weatherData;
  Status get status => _status;
  String get error => _error;

  getWeatherDataByCity(String city) async {
    _status = Status.loading;
    notifyListeners();

    // delaying api response so use can see loading
    await Future.delayed(const Duration(seconds: 2));

    await weatherDataRepo.fetchWeatherByCity(city: city).then((value) {
      value.fold((weatherData) {
        _weatherData = weatherData;
        _status = Status.success;
        notifyListeners();
      }, (dataError) {
        /// set error
        _error = dataError.title;
        _status = Status.error;
        notifyListeners();
      });
    });
  }
}

enum Status { initial, loading, success, error }
