import 'package:peliculasapp/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies({int page = 1});
}

