
import 'package:flutter/material.dart';
import 'package:weather_app_challenge/models/weather_model.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_challenge/viewModels/city_entry_viewmodel.dart';

import 'package:weather_app_challenge/viewModels/forecast_viewmodel.dart';
import 'package:weather_app_challenge/views/image_weather_view.dart';
import 'package:weather_app_challenge/views/temp_view.dart';
import 'package:weather_app_challenge/views/weather_description_view.dart';
import 'package:weather_app_challenge/views/gradient_container.dart';

import 'city_entry_view.dart';
import 'daily_summary_view.dart';
import 'last_update_view.dart';
import 'location_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    onStart();
  }

  Future<void> onStart() async {
     // setState(() {
     //
     // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (context, model, child) => Scaffold(
        body: _buildDayNighttheme(
            model.condition, model.isDaytime, buildHomeView(context)),
      ),
    );
  }

  Widget buildHomeView(BuildContext context) {
    return Consumer<ForecastViewModel>(
        builder: (context, forecastViewModel, child) => Container(
            height: MediaQuery.of(context).size.height,

            child: RefreshIndicator(
                color: Colors.transparent,
                backgroundColor: Colors.transparent,
                onRefresh: () => refreshWeather(forecastViewModel, context),
                child: ListView(
                  children: <Widget>[
                    CityEntryView(),
                    forecastViewModel.isRequestPending
                        ? buildBusyIndicator()
                        : forecastViewModel.isRequestError
                        ? Center(
                        child: Text('Invalid city name',
                            style: TextStyle(
                                fontSize: 21, color: Colors.white)))
                        : forecastViewModel.isEmpty
                        ? Container()
                        : Column(children: [
                      ImageWeatherView(
                          iconName: forecastViewModel.iconName!
                      ),
                      TemperatureView(
                          temp: forecastViewModel.temp!,
                          feelsLike: forecastViewModel.feelsLike!
                      ),
                      SizedBox(height: 20),
                      LocationView(
                        longitude: forecastViewModel.longitude!,
                        latitude: forecastViewModel.latitude!,
                        city: forecastViewModel.city!,
                      ),
                      SizedBox(height: 20),
                      WeatherDescriptionView(
                          weatherDescription:
                          forecastViewModel.description!),
                      LastUpdatedView(
                          lastUpdatedOn:
                          forecastViewModel.lastUpdated),
                    ]),
                  ],
                ))
        )
    );
  }

  Widget buildBusyIndicator() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
      SizedBox(
        height: 20,
      ),
      Text('Please Wait...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ))
    ]);
  }


  Future<void> refreshWeather(
      ForecastViewModel weatherVM, BuildContext context) {
    // get the current city
    String city = Provider.of<CityEntryViewModel>(context, listen: false).city;
    debugPrint("refreshWeather:"+city);
    return weatherVM.getLatestWeather(city);
  }

  GradientContainer _buildDayNighttheme(
      WeatherCondition condition, bool isDayTime, Widget child) {
    GradientContainer container;

    // if night time then just default to a blue/grey
    if (isDayTime != null && !isDayTime)
      container = GradientContainer(color: Colors.blueGrey, child: child);
    else {
      switch (condition) {
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          container = GradientContainer(color: Colors.yellow, child: child);
          break;
        case WeatherCondition.fog:
        case WeatherCondition.atmosphere:
        case WeatherCondition.rain:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          container = GradientContainer(color: Colors.indigo, child: child);
          break;
        case WeatherCondition.snow:
          container = GradientContainer(color: Colors.lightBlue, child: child);
          break;
        case WeatherCondition.thunderstorm:
          container = GradientContainer(color: Colors.deepPurple, child: child);
          break;
        default:
          container = GradientContainer(color: Colors.lightBlue, child: child);
      }
    }

    return container;
  }
}