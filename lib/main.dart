import 'package:flutter/material.dart';

import 'pages/weather_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
