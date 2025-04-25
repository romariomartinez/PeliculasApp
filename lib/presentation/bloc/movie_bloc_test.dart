// ignore: depend_on_referenced_packages
import 'package:bloc_test/bloc_test.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';

import 'package:peliculasapp/domain/entities/movie.dart';
import 'package:peliculasapp/domain/usecases/get_movies.dart';
import 'package:peliculasapp/presentation/bloc/movie_bloc.dart';

class MockGetPopularMovies extends Mock implements GetMovies {}

void main() {
  late MovieBloc movieBloc;
  late MockGetPopularMovies mockUseCase;

  setUp(() {
    mockUseCase = MockGetPopularMovies();
    movieBloc = MovieBloc(mockUseCase);
  });

  final testMovies = [
    const Movie(
      id: 1,
      title: 'Batman',
      posterPath: '/batman.jpg',
      rating: 8.5,
      releaseDate: '2022-01-01',
      genres: ['Action'],
      overview: 'A superhero movie',
      duration: 120, genreIds: [12],
    )
  ];

  blocTest<MovieBloc, MovieState>(
    'emite [MovieLoading, MovieLoaded] cuando FetchPopularMovies es exitoso',
    build: () {
      when(() => mockUseCase()).thenAnswer((_) async => testMovies);
      return movieBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      MovieLoading(),
      MovieLoaded(testMovies),
    ],
  );

  blocTest<MovieBloc, MovieState>(
    'emite [MovieLoading, MovieError] cuando FetchPopularMovies falla',
    build: () {
      when(() => mockUseCase).thenThrow(Exception('error'));
      return movieBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      MovieLoading(),
      isA<MovieError>(),
    ],
  );
}
