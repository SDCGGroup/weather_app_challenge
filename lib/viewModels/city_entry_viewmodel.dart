
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_challenge/viewModels/forecast_viewmodel.dart';

class CityEntryViewModel with ChangeNotifier {
  late String _city;

  CityEntryViewModel();

  String get city => _city;

  void refreshWeather(String newCity, BuildContext context) {
    Provider.of<ForecastViewModel>(context, listen: false)
        .getLatestWeather(_city);
        //.getLatestWeather(_city, context);

    notifyListeners();
  }

  void updateCity(String newCity) {
    _city = newCity;
  }
}