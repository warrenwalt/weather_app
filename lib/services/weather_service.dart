// ignore_for_file: constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://weatherapi-com.p.rapidapi.com/current.json';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    var url = Uri.parse('$BASE_URL?q=$cityName');
    var appHeaders = {
      'X-RapidAPI-Key': '7b8c0385a6msh3c52b2c2e530c0dp18c14bjsn6b9d1061c385',
      'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com',
    };
    final response = await http
        .get(url, headers: appHeaders);

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentLocation() async {

    // get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // convert location into a list of placemark objects
    List<Placemark> placemarks = 
      await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract city name from the first placemark
    String? city = placemarks[0].locality;

    return city ?? '';
  }
}