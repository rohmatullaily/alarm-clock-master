import 'package:flutter/material.dart';

import 'home_page.dart';
import 'package:timezone/data/latest.dart' as timezone;


void main() {
  timezone.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        disabledColor: Colors.blue

      ),
      home: const HomePage(title: 'Rohmatul Laily'),
    );
  }
}
