import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_weather_app_bloc_stable/bloc/weather_bloc.dart';
import 'package:flutter_fake_weather_app_bloc_stable/data/weather_repository.dart';

import 'pages/weather_search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Weather App',
      home: new BlocProvider(
        create: (context) => WeatherBloc(FakeWeatherRepository()),
        child: new WeatherSearchPage(),
      ),
    );
  }
}
