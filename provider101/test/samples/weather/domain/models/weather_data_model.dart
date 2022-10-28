import 'package:flutter_test/flutter_test.dart';
import 'package:provider101/samples/weather/domain/models/weather_data_model.dart';

import '../../../mocks.dart';

void main() {
  final WeatherDataModelMockData weatherDataModelMockData = WeatherDataModelMockData();

  group("json to WeatherDataModel Tests", () {
    test(
      "fromJson method test 1 - goa",
      () async {
        final result = WeatherData.fromJson(weatherDataModelMockData.goaJsonFrom);
        expect(result.id, weatherDataModelMockData.goaWeatherData.id);
        expect(result.weather[0].id, weatherDataModelMockData.goaWeatherData.weather[0].id);
        expect(result.coord.lat, weatherDataModelMockData.goaWeatherData.coord.lat);
        expect(result.dt, weatherDataModelMockData.goaWeatherData.dt);
      },
    );

    test(
      "fromJson method test 2 - delhi",
      () async {
        final result = WeatherData.fromJson(weatherDataModelMockData.delhiJsonFrom);
        expect(result.id, weatherDataModelMockData.delhiWeatherData.id);
        expect(result.weather[0].description, weatherDataModelMockData.delhiWeatherData.weather[0].description);
        expect(result.coord.lat, weatherDataModelMockData.delhiWeatherData.coord.lat);
        expect(result.dt, weatherDataModelMockData.delhiWeatherData.dt);
      },
    );
  });

  /// if we are also sending the data to api's then we also need to test the toJson method
  /// not testing here as it isn't required
}
