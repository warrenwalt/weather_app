// ignore_for_file: unused_field, unused_element, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatherService = WeatherService();
  Weather? _weather;

  //fetch the weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentLocation();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        print('🚶🚶$_weather');
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/cloudy.json';
    return 'assets/sunny.json';
  }

  // init stat
  @override
  void initState() {
    super.initState();

    // fetch weather on start up
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? 'Loading city...'),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
      
            // temperature
            Text('${_weather?.temperature.round()} C'),

            // condition
            Text(_weather?.mainCondition ?? ''),
          ],
        ),
      ),
    );
  }
}