import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:provider101/samples/counter/counter_provider.dart';
import 'package:provider101/samples/weather/data/http/http_helper/base_http.dart';
import 'package:provider101/samples/weather/data/http/weather_api.dart';
import 'package:provider101/samples/weather/domain/repository/weather_repo.dart';

import 'samples/weather/presentation/controllers/weather_provider.dart';

final locator = GetIt.instance;

void init() {
  /// using top to bottom approach

  /// data
  // external package
  locator.registerLazySingleton(() => http.Client());

  // http base client
  locator.registerLazySingleton<Server>(() => Server(client: locator()));

  // remote data sources
  locator.registerLazySingleton<WeatherApiService>(() => WeatherApiServiceImpl(server: locator()));

  /// domain
  // repositories
  // weather
  locator.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(apiService: locator()));

  /// presentation
  // controllers as factories
  locator.registerFactory(() => CounterProvider());
  locator.registerFactory(() => WeatherProvider(weatherDataRepo: locator()));
}
