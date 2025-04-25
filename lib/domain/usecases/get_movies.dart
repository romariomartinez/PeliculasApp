import 'package:peliculasapp/domain/entities/movie.dart';
import 'package:peliculasapp/domain/repositories/movie_repository.dart';

class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<List<Movie>> call({int page = 1}) async {
    return await repository.getMovies(page: page);
  }
}

