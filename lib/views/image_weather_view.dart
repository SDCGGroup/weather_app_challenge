import 'package:flutter/material.dart';

class ImageWeatherView extends StatelessWidget {
  final String iconName;

  ImageWeatherView(
      { Key? key,
        required this.iconName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(padding: const EdgeInsets.only(top: 5),
                child: Image.network(
                  'http://openweathermap.org/img/w/${this.iconName}.png',
                  width: MediaQuery.of(context).size.width/3,
                  height: MediaQuery.of(context).size.width/4,
                  fit: BoxFit.cover,
                ),
            ),
            SizedBox(width: 10),
          ],
        )
      ]),
    );
  }
}