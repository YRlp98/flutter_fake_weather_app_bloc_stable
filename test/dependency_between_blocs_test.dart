import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fake_weather_app_bloc_stable/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  test('Example mocked BLoC test', () {
    whenListen(
      mockWeatherBloc,
      Stream.fromIterable([WeatherInitial(), WeatherLoading()]),
    );

    expectLater(
      mockWeatherBloc,
      emitsInOrder([WeatherInitial(), WeatherLoading()]),
    );
  });
}
