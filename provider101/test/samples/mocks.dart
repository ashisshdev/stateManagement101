import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:provider101/samples/counter/counter_provider.dart';
import 'package:provider101/samples/weather/data/http/http_helper/base_http.dart';
import 'package:provider101/samples/weather/data/http/weather_api.dart';
import 'package:provider101/samples/weather/domain/models/data_error_model.dart';
import 'package:provider101/samples/weather/domain/models/weather_data_model.dart';
import 'package:provider101/samples/weather/domain/repository/weather_repo.dart';
import 'package:provider101/samples/weather/presentation/controllers/weather_provider.dart';
import 'package:provider101/samples/weather/utils/api_details.dart';

// /// external package/service mocks
// class MockHttpClient extends Mock implements http.Client {}
//
// /// Data services helper's mocks for service classes
// class MockServer extends Mock implements Server {}
//
// class MockWeatherApiService extends Mock implements WeatherApiServiceImpl {}
//
//
// class MockWeather extends Mock implements Server {}
//

@GenerateMocks([
  /// Data services helper's mocks for service classes
  Server,

  /// DataService class mocks for repos
  WeatherApiService,

  /// Repositories mocks for providers/Blocs/Controllers
  WeatherRepository,

  /// Blocs/Providers/Controllers mocks for WidgetTests
  CounterProvider,
  WeatherProvider,
], customMocks: [
  /// external package/service mocks for helper classes
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

/// after every change in above files
/// run -> flutter pub run build_runner build

// Mock Data for Testing vivid scenarios below
/// Base HTTP class test data

class BaseHttpTestMockData {
// response with success data
// 1 when searched for goa , response.body =
  static Map<String, dynamic> goaBody = {
    "coord": {"lon": 74.0833, "lat": 15.3333},
    "weather": [
      {
        "id": 804,
        "main": "Clouds",
        "description"
            "": "overcast clouds",
        "icon": "04d"
      }
    ],
    "base": "stations",
    "main": {
      "temp": 301.36,
      "feels_like": 306.12,
      "temp_min": 301.36,
      "temp_max": 301.36,
      "pressure": 1009,
      "humidity": 82,
      "sea_level": 1009,
      "grnd_level": 996
    },
    "visibility": 10000,
    "wind": {"speed": 1.98, "deg": 217, "gust": 2.7},
    "clouds": {"all": 94},
    "dt": 1666092061,
    "sys": {"type": 1, "id": 9233, "country": "IN", "sunrise": 1666054546, "sunset": 1666096900},
    "timezone": 19800,
    "id": 1271157,
    "name": "Goa",
    "cod": 200
  };
  http.Response goaResponse = http.Response(jsonEncode(goaBody), 200);

// 2 when searched for delhi , response.body =
  static Map<String, dynamic> delhiBody = {
    "coord": {"lon": 77.2167, "lat": 28.6667},
    "weather": [
      {
        "id": 721,
        "main": "Haze",
        "descrip"
            "tion": "haze",
        "icon": "50d"
      }
    ],
    "base": "stations",
    "main": {
      "temp": 305.2,
      "feels_like": 303.36,
      "temp_min": 305.2,
      "temp_max": 305.2,
      "pressure": 1010,
      "humidity": 23
    },
    "visibility": 3500,
    "wind": {"speed": 2.06, "deg": 280},
    "clouds": {"all": 0},
    "dt": 1666092330,
    "sys": {"type": 1, "id": 9165, "country": "IN", "sunrise": 1666054402, "sunset": 1666095540},
    "timezone": 19800,
    "id": 1273294,
    "name": "Delhi",
    "cod": 200
  };
  http.Response delhiResponse = http.Response(jsonEncode(delhiBody), 200);

// response with error data
// 1 error 401
  static Map<String, dynamic> error401json = {
    "cod": 401,
    "message": "Invalid API key. Please see https://openweathermap.org/faq#error401 for more info.",
  };
  http.Response error401Response = http.Response(jsonEncode(error401json), 401);

// 2 Error 404
  static Map<String, dynamic> error404json = {
    "cod": "404",
    "message": "Internal error",
  };
  http.Response error404Response = http.Response(jsonEncode(error404json), 404);

// 3 Error 429
  static Map<String, dynamic> error429json = {
    "cod": "429",
    "message": "Subscription plan limit reached, please upgrade your plan.",
  };
  http.Response error429Response = http.Response(jsonEncode(error429json), 429);

// 4 Error 429
  static Map<String, dynamic> error500json = {
    "cod": "500",
    "message": "Contact support with API call and response Metadata.",
  };
  http.Response error500Response = http.Response(jsonEncode(error500json), 500);

  Uri getUriUrl({required String city}) {
    return Uri.parse("${baseUrl}q=$city&appid=$appid");
  }
}

class WeatherApiTestMockData {
  http.Response successResponse = http.Response(jsonEncode({"data": "data", "code": 200}), 200);
}

class WeatherDataModelMockData {
  /// pass them to test fromJson method
  Map<String, dynamic> goaJsonFrom = {
    "coord": {"lon": 74.0833, "lat": 15.3333},
    "weather": [
      {
        "id": 804,
        "main": "Clouds",
        "description"
            "": "overcast clouds",
        "icon": "04d"
      }
    ],
    "base": "stations",
    "main": {
      "temp": 301.36,
      "feels_like": 306.12,
      "temp_min": 301.36,
      "temp_max": 301.36,
      "pressure": 1009,
      "humidity": 82,
      "sea_level": 1009,
      "grnd_level": 996
    },
    "visibility": 10000,
    "wind": {"speed": 1.98, "deg": 217, "gust": 2.7},
    "clouds": {"all": 94},
    "dt": 1666092061,
    "sys": {"type": 1, "id": 9233, "country": "IN", "sunrise": 1666054546, "sunset": 1666096900},
    "timezone": 19800,
    "id": 1271157,
    "name": "Goa",
    "cod": 200
  };
  Map<String, dynamic> delhiJsonFrom = {
    "coord": {"lon": 77.2167, "lat": 28.6667},
    "weather": [
      {"id": 721, "main": "Haze", "description": "haze", "icon": "50d"}
    ],
    "base": "stations",
    "main": {
      "temp": 305.2,
      "feels_like": 303.36,
      "temp_min": 305.2,
      "temp_max": 305.2,
      "pressure": 1010,
      "humidity": 23
    },
    "visibility": 3500,
    "wind": {"speed": 2.06, "deg": 280},
    "clouds": {"all": 0},
    "dt": 1666092330,
    "sys": {"type": 1, "id": 9165, "country": "IN", "sunrise": 1666054402, "sunset": 1666095540},
    "timezone": 19800,
    "id": 1273294,
    "name": "Delhi",
    "cod": 200
  };

  /// expected results
  WeatherData goaWeatherData = WeatherData(
      coord: Coord(lon: 74.0833, lat: 15.3333),
      weather: [Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")],
      base: "stations",
      main: Main(temp: 301.36, pressure: 1009, humidity: 82),
      wind: Wind(speed: 1.98),
      dt: 1666092061,
      sys: Sys(country: "IN", sunrise: 1666054546, sunset: 1666096900),
      timezone: 19800,
      id: 1271157,
      name: "Goa",
      cod: 200);
  WeatherData delhiWeatherData = WeatherData(
      coord: Coord(lon: 77.2167, lat: 28.6667),
      weather: [Weather(id: 721, main: "Haze", description: "haze", icon: "50d")],
      base: "stations",
      main: Main(temp: 305.2, humidity: 23, pressure: 1010),
      wind: Wind(speed: 2.06),
      dt: 1666092330,
      sys: Sys(country: "IN", sunrise: 1666054402, sunset: 1666095540),
      timezone: 19800,
      id: 1273294,
      name: "Delhi",
      cod: 200);
}

class WeatherRepoMockData {
  // static Map<String, dynamic> goodResponseBody = {
  //   "coord": {
  //     "lon": 76.7933,
  //     "lat": 30.7343,
  //   },
  //   "weather": [
  //     {
  //       "id": 800,
  //       "main": "Clear",
  //       "description": "clear sky",
  //       "icon": "01d",
  //     }
  //   ],
  //   "base": "stations",
  //   "main": {
  //     "temp": 299.41,
  //     "feels_like": 299.41,
  //     "temp_min": 299.41,
  //     "temp_max": 299.41,
  //     "pressure": 1012,
  //     "humidity": 42,
  //     "sea_level": 1012,
  //     "grnd_level": 973,
  //   },
  //   "visibility": 10000,
  //   "wind": {
  //     "speed": 2.25,
  //     "deg": 359,
  //     "gust": 3.51,
  //   },
  //   "clouds": {"all": 0},
  //   "dt": 1666954920,
  //   "sys": {
  //     "country": "IN",
  //     "sunrise": 1666919049,
  //     "sunset": 1666958934,
  //   },
  //   "timezone": 19800,
  //   "id": 1274746,
  //   "name": "Chandigarh",
  //   "cod": 200,
  // };

  http.Response goodResponse = http.Response(
      jsonEncode({
        "coord": {
          "lon": 76.7933,
          "lat": 30.7343,
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d",
          }
        ],
        "base": "stations",
        "main": {
          "temp": 299.41,
          "feels_like": 299.41,
          "temp_min": 299.41,
          "temp_max": 299.41,
          "pressure": 1012,
          "humidity": 42,
          "sea_level": 1012,
          "grnd_level": 973,
        },
        "visibility": 10000,
        "wind": {
          "speed": 2.25,
          "deg": 359,
          "gust": 3.51,
        },
        "clouds": {"all": 0},
        "dt": 1666954920,
        "sys": {
          "country": "IN",
          "sunrise": 1666919049,
          "sunset": 1666958934,
        },
        "timezone": 19800,
        "id": 1274746,
        "name": "Chandigarh",
        "cod": 200,
      }),
      200);

  WeatherData goodResponseInWeatherModel = WeatherData(
      coord: Coord(lon: 74.0833, lat: 15.3333),
      weather: [Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")],
      base: "stations",
      main: Main(temp: 301.36, pressure: 1009, humidity: 82),
      wind: Wind(speed: 1.98),
      dt: 1666092061,
      sys: Sys(country: "IN", sunrise: 1666054546, sunset: 1666096900),
      timezone: 19800,
      id: 1271157,
      name: "Goa",
      cod: 200);

  http.Response badResponse = http.Response(jsonEncode({"code": 404, "error": "Some error"}.toString()), 404);
  DataError dataError = DataError(title: "Error", description: "Desc", code: 0, url: "NoUrl");
}

class WeatherProviderMockData {
  WeatherData goaWeatherData = WeatherData(
      coord: Coord(lon: 74.0833, lat: 15.3333),
      weather: [Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")],
      base: "stations",
      main: Main(temp: 301.36, pressure: 1009, humidity: 82),
      wind: Wind(speed: 1.98),
      dt: 1666092061,
      sys: Sys(country: "IN", sunrise: 1666054546, sunset: 1666096900),
      timezone: 19800,
      id: 1271157,
      name: "Goa",
      cod: 200);

  DataError dataError1 = DataError(title: "Error1", description: "Desc1", code: 1, url: "NoUrl1");
}

class WeatherAppWidgetMockData {
  WeatherData goaWeatherData = WeatherData(
      coord: Coord(lon: 74.0833, lat: 15.3333),
      weather: [Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")],
      base: "stations",
      main: Main(temp: 301.36, pressure: 1009, humidity: 82),
      wind: Wind(speed: 1.98),
      dt: 1666092061,
      sys: Sys(country: "IN", sunrise: 1666054546, sunset: 1666096900),
      timezone: 19800,
      id: 1271157,
      name: "Goa",
      cod: 200);
}
