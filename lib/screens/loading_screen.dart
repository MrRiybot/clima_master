import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima_master/services/location.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=24.86&longitude=46.63&current_weather=true'));
      if (response.statusCode == 200) {
        String data = response.body;
        double temp = jsonDecode(data)['current_weather']['temperature'];
        var weathercode = jsonDecode(data)['current_weather']['weathercode'];
        print(weathercode);
      }
      else
        print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            getData();
          },
          child: Text("get location"),
        ),
      ),
    );
  }
}
