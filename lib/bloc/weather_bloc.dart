import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fake_weather_app_bloc_stable/data/model/weather.dart';
import 'package:flutter_fake_weather_app_bloc_stable/data/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if (event is GetWeather) {
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield WeatherError("Couldn't fetch weather. is the device online?!");
      }
    } else if (event is GetDeatailedWeather) {
      try {
        final weather =
            await weatherRepository.fetchDetailedWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield WeatherError("Counl't fetch weather. is the device online?!");
      }
    }
  }
}
