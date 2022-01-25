import 'package:flutter/material.dart';

class TemperatureView extends StatelessWidget {
  final num temp;
  final num feelsLike;

  TemperatureView(
      { Key? key,
        required this.temp,
        required this.feelsLike})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            Text(
              '${_formatTemperature(this.temp)}°ᶜ',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Feels like ${_formatTemperature(this.feelsLike)}°ᶜ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  String _formatTemperature(num t) {
    var temp = (t == null ? '' : t.round().toString());
    return temp;
  }
}