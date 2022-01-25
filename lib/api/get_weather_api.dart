
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_app_challenge/api/weather_api.dart';
import 'package:weather_app_challenge/models/forecast_model.dart';

import 'package:weather_app_challenge/models/location_model.dart';

class GetWeatherApi extends WeatherApi {
  static const endPointUrl = 'https://api.openweathermap.org/data/2.5';
  static const apiKey = "7eea842a7614eeb9b5964cb2df83b5d0";
  late http.Client httpClient;

  GetWeatherApi() {
    this.httpClient = new http.Client();
  }

  Future<Location> getLocation(String city) async {
    final requestUrl = '$endPointUrl/weather?q=$city&APPID=$apiKey';
    final response = await this.httpClient.get(Uri.parse(requestUrl));

    if (response.statusCode != 200) {
      throw Exception(
          'error retrieving location for city $city: ${response.statusCode}');
    }
    debugPrint("getLocation response:" + response.body);
    return Location.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Forecast> getWeather(Location location) async {
    final requestUrl =
        '$endPointUrl/onecall?lat=${location.latitude}&lon=${location.longitude}&units=metric&exclude=hourly,minutely&APPID=$apiKey';
    final response = await this.httpClient.get(Uri.parse(requestUrl));

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }
    debugPrint("getWeather response:" + response.body);
    return Forecast.fromJson(jsonDecode(response.body));
  }
}