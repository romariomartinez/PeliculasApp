import 'package:peliculasapp/data/datasources/movie_remote_data_source.dart';
import 'package:peliculasapp/domain/entities/movie.dart';
import 'package:peliculasapp/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getMovies({int page = 1}) async {
    return await remoteDataSource.getMovies(page: page);
  }
}

