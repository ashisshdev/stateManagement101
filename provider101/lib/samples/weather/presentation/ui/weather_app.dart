import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider101/samples/weather/domain/models/weather_data_model.dart';
import 'package:provider101/samples/weather/presentation/controllers/weather_provider.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _controller = TextEditingController();

  @override
  dispose() async {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.center,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'City Name',
                  hintText: 'ex London',
                  suffix: IconButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty && _controller.text.length > 2) {
                          Provider.of<WeatherProvider>(context, listen: false).getWeatherDataByCity(_controller.text);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text("Enter a valid city name")));
                        }
                      },
                      icon: const Icon(Icons.search)),
                ),
              ),
            ),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                switch (weatherProvider.status) {
                  case Status.loading:
                    return const Center(child: CircularProgressIndicator());
                  case Status.error:
                    return Text(weatherProvider.error);
                  case Status.success:
                    return SuccessWeatherDataWidget(
                      weatherData: weatherProvider.weatherData,
                    );
                  case Status.initial:
                  default:
                    return const Center(
                      child: Text("Enter city name to fetch weather."),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessWeatherDataWidget extends StatelessWidget {
  final WeatherData weatherData;

  const SuccessWeatherDataWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Text(weatherData.main.temp.toString());
  }
}
