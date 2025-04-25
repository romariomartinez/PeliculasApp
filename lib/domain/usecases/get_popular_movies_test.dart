// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:peliculasapp/domain/entities/movie.dart';
import 'package:peliculasapp/domain/repositories/movie_repository.dart';
import 'package:peliculasapp/domain/usecases/get_movies.dart'; // asegúrate de que esté actualizado

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetMovies usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = GetMovies(mockRepository); // <- usa el nuevo caso de uso
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
      duration: 120,
      genreIds: [12],
    )
  ];

  test('debe retornar una lista de películas desde el repositorio', () async {
    when(() => mockRepository.getMovies()).thenAnswer((_) async => testMovies);

    final result = await usecase();

    expect(result, testMovies);
    verify(() => mockRepository.getMovies()).called(1);
  });
}
