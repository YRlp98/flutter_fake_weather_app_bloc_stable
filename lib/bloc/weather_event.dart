part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final String cityName;

  const GetWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class GetDeatailedWeather extends WeatherEvent {
  final String cityName;

  const GetDeatailedWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}
