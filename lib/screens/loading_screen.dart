import 'dart:convert';

import 'package:clima_master/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima_master/services/location.dart';
import 'package:clima_master/services/networking.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String latitude;
  String longitude;

  void getLocationData() async {
    Location location = Location();
    await location.getLocation();
    latitude = location.latitude.toStringAsFixed(2);
    longitude = location.longitude.toStringAsFixed(2);
    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=12.1&longitude=12.123&current_weather=true';
    NetworkHelper networkHelper = NetworkHelper(url);
    var data = await networkHelper.getData();
    print(data['current_weather']['temperature']);
    print(data['current_weather']['weathercode']);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            getLocationData();
          },
          child: Text("get location"),
        ),
      ),
    );
  }
}
