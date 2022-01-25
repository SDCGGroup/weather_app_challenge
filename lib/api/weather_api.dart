import 'package:weather_app_challenge/models/location_model.dart';
import 'package:weather_app_challenge/models/forecast_model.dart';

abstract class WeatherApi {
  Future<Forecast> getWeather(Location location);
  Future<Location> getLocation(String city);
}