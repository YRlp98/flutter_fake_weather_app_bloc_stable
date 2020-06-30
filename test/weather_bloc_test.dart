import 'package:flutter_fake_weather_app_bloc_stable/bloc/weather_bloc.dart';
import 'package:flutter_fake_weather_app_bloc_stable/data/model/weather.dart';
import 'package:flutter_fake_weather_app_bloc_stable/data/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
  });

  group('GetWeather', () {
    final weather = Weather(cityName: 'Arak', temperatureCelsius: 27);

    // Old way of testing Blocs - like regular Streams
    test(
      'OLD WAY emits [WeatherLoading, WeatherLoaded] when successful',
      () {
        when(mockWeatherRepository.fetchWeather(any))
            .thenAnswer((_) async => weather);
        final bloc = WeatherBloc(mockWeatherRepository);
        bloc.add(GetWeather('Arak'));
        expectLater(
          bloc,
          emitsInOrder([
            WeatherInitial(),
            WeatherLoading(),
            WeatherLoaded(weather),
          ]),
        );
      },
    );
  });
}
