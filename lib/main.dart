// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:light_sensor/light_sensor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isdark = false;
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  Color _appBarColor = Colors.black;

  Text _appBarTitle = Text(
      'Light Sensor Demo'); // Add this line to define the _appBarTitle variable

  StreamSubscription<int>? _lightSubscription;

  @override
  void initState() {
    super.initState();
    initLightSensor();
  }

  @override
  void dispose() {
    _lightSubscription?.cancel();
    super.dispose();
  }

  void initLightSensor() async {
    _lightSubscription = LightSensor.lightSensorStream.listen((illumination) {
      setState(() {
        print("illumination: $illumination");
        if (illumination <= 60) {
          isdark = true;
          _backgroundColor = Colors.black;
          _textColor = Colors.white;
          _appBarColor = Colors.white;
          _appBarTitle = Text('Light Sensor Demo (Dark Mode)',
              style: TextStyle(color: Colors.black));
        } else {
          isdark = false;
          _backgroundColor = Colors.white;
          _textColor = Colors.black;
          _appBarColor = Colors.black;
          _appBarTitle = Text('Light Sensor Demo (Light Mode)',
              style: TextStyle(color: Colors.white));
        }
        print("isdark$isdark");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Light Sensor',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: _appBarColor,
        ),
      ),
      home: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          leading: isdark
              ? Image.asset(
                  'images/switch-dark.jpg',
                  width: 40,
                  height: 40,
                )
              : Image.asset(
                  'images/swich-light.jpg',
                  width: 40,
                  height: 40,
                ),
          title: _appBarTitle,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello-Mostafa',
                style: TextStyle(
                  color: _textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              isdark
                  ? Image.asset(
                      'images/moon.png',
                      width: 100,
                      height: 100,
                    )
                  : Image.asset(
                      'images/sun.png',
                      width: 100,
                      height: 100,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
