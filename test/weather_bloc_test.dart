import 'package:bloc_test/bloc_test.dart';
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

    test(
      'NEWER WAY BUT LONG-WINDED emits [WeatherLoading, WeatherLoaded] when successful',
      () {
        when(mockWeatherRepository.fetchWeather(any))
            .thenAnswer((_) async => weather);

        final bloc = WeatherBloc(mockWeatherRepository);

        bloc.add(GetWeather('Arak'));

        emitsExactly(bloc, [
          WeatherInitial(),
          WeatherLoading(),
          WeatherLoaded(weather),
        ]);
      },
    );

    //?  BlocTest ==========================================
    blocTest(
      'emits [WeatherLoading, WeatherLoaded] when successful',
      build: () {
        when(mockWeatherRepository.fetchWeather(any))
            .thenAnswer((_) async => weather);
        return WeatherBloc(mockWeatherRepository);
      },
      act: (bloc) => bloc.add(GetWeather('Arak')),
      expect: [
        WeatherInitial(),
        WeatherLoading(),
        WeatherLoaded(weather),
      ],
    );

    blocTest(
      'emits [WeatherLoading, WeatherError] when unsuccessful',
      build: () {
        when(mockWeatherRepository.fetchWeather(any)).thenThrow(NetworkError());
        return WeatherBloc(mockWeatherRepository);
      },
      act: (bloc) => bloc.add(GetWeather('Arak')),
      expect: [
        WeatherInitial(),
        WeatherLoading(),
        WeatherError("Couldn't fetch weather. Is the device online?"),
      ],
    );
  });
}
