import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final num longitude;
  final num latitude;
  final String city;

  LocationView(
      { Key? key,
        required this.longitude,
        required this.latitude,
        required this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text('${this.city.toUpperCase()}',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w300,
              color: Colors.black45,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.black45, size: 15),
            SizedBox(width: 10),
            Text(this.longitude.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                )),
            Text(' , ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                )),
            Text(this.latitude.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                )),
          ],
        )
      ]),
    );
  }
}