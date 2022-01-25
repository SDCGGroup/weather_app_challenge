import 'package:weather_app_challenge/models/forecast_model.dart';
import 'package:weather_app_challenge/api/weather_api.dart';

class ForecastService {
  final WeatherApi weatherApi;
  ForecastService(this.weatherApi);

  Future<Forecast> getWeather(String city) async {
    final location = await weatherApi.getLocation(city);
    return await weatherApi.getWeather(location);
  }
}