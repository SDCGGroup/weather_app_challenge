
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app_challenge/api/get_weather_api.dart';
import 'package:weather_app_challenge/models/forecast_model.dart';
import 'package:weather_app_challenge/models/weather_model.dart';
import 'package:weather_app_challenge/services/forecast_service.dart';

class ForecastViewModel with ChangeNotifier {
  bool isRequestPending = false;
  bool isWeatherLoaded = false;
  bool isRequestError = false;
  bool isEmpty = true;

  // WeatherCondition _condition = WeatherCondition.clear;
  // String _description = "";
  // num _minTemp = 0;
  // num _maxTemp = 0;
  // num _temp = 0;
  // num _feelsLike = 0;
  // int _locationId = 0;
  // DateTime _lastUpdated = new DateTime.now();
  // String _city = "";
  // num _latitude = 0;
  // num _longitude = 0;
  // List<Weather> _daily = [];
  // bool _isDayTime = true;
  // String _iconName = "04d";
  //
  // WeatherCondition get condition => _condition;
  // String get description => _description;
  // num get minTemp => _minTemp;
  // num get maxTemp => _maxTemp;
  // num get temp => _temp;
  // num get feelsLike => _feelsLike;
  // int get locationId => _locationId;
  // DateTime get lastUpdated => _lastUpdated;
  // String get city => _city;
  // num get longitude => _longitude;
  // num get latitude => _latitude;
  // bool get isDaytime => _isDayTime;
  // List<Weather> get daily => _daily;
  // String get iconName => _iconName;

  WeatherCondition _condition = WeatherCondition.clear;
  String? _description;
  num? _minTemp;
  num? _maxTemp;
  num? _temp;
  num? _feelsLike;
  int? _locationId;
  DateTime _lastUpdated = new DateTime.now();
  String? _city;
  num? _latitude;
  num? _longitude;
  List<Weather>? _daily;
  bool _isDayTime = true;
  String? _iconName;

  WeatherCondition get condition => _condition;
  String? get description => _description;
  num? get minTemp => _minTemp;
  num? get maxTemp => _maxTemp;
  num? get temp => _temp;
  num? get feelsLike => _feelsLike;
  int? get locationId => _locationId;
  DateTime get lastUpdated => _lastUpdated;
  String? get city => _city;
  num? get longitude => _longitude;
  num? get latitude => _latitude;
  bool get isDaytime => _isDayTime;
  List<Weather>? get daily => _daily;
  String? get iconName => _iconName;

  late ForecastService forecastService;

  ForecastViewModel() {
    forecastService =
        ForecastService(GetWeatherApi());
  }
  Future<Forecast> getLatestWeather(String city) async {

    setRequestPendingState(true);
    debugPrint("getLatestWeather1:");
    this.isRequestError = false;

    late Forecast latest;
    try {
      debugPrint("getLatestWeather2:");
      //await Future.delayed(Duration(seconds: 1), () => {});

      latest = await forecastService
          .getWeather(city)
          .catchError((onError) => this.isRequestError = true);

      debugPrint("getLatestWeather3:");
      updateModel(latest, city);
    } catch (e) {
      debugPrint("catch:"+e.toString());
      this.isRequestError = true;
    }
    debugPrint("getLatestWeather4:");
    this.isWeatherLoaded = true;
    this.isEmpty = false;
    setRequestPendingState(false);
    notifyListeners();
    debugPrint("getLatestWeather5:");
    return latest;

  }

  void setRequestPendingState(bool isPending) {
    this.isRequestPending = isPending;
    notifyListeners();
  }

  void updateModel(Forecast forecast, String city) {
    if (isRequestError) return;
    this.isEmpty = false;
    _condition = forecast.current!.condition!;
    // _city = Strings.toTitleCase(forecast.city);
    // _description = Strings.toTitleCase(forecast.current.description);
    _city = city;
    _description = forecast.current!.description!.toUpperCase();
    _lastUpdated = forecast.lastUpdated!;
    //_temp = TemperatureConvert.kelvinToCelsius(forecast.current.temp);
    //_temp = (forecast.current!.temp! - 273.15);
    _temp = forecast.current!.temp!;
    // _feelsLike =
    //     TemperatureConvert.kelvinToCelsius(forecast.current.feelLikeTemp);
    //_feelsLike = (forecast.current!.feelLikeTemp! - 273.15);
    _feelsLike = forecast.current!.feelLikeTemp!;
    _longitude = forecast.longitude!;
    _latitude = forecast.latitude!;
    _daily = forecast.daily!;
    _isDayTime = forecast.isDayTime!;
    _iconName = forecast.current!.iconName!;
  }
}