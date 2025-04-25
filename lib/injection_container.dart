import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:peliculasapp/data/datasources/favorite_local_data_source.dart';
import 'package:peliculasapp/data/datasources/genre_remote_data_source.dart';
import 'package:peliculasapp/data/datasources/movie_detail_remote_data_source.dart';
import 'package:peliculasapp/domain/repositories/movie_repository_impl.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/get_movies.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // UseCases
  if (!sl.isRegistered<GetMovies>()) {
  sl.registerLazySingleton(() => GetMovies(sl()));
}

  // Repositories
  sl.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(remoteDataSource: sl()));
// External
  sl.registerLazySingleton(() => http.Client());
  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<GenreRemoteDataSource>(
      () => GenreRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<MovieDetailRemoteDataSource>(
      () => MovieDetailRemoteDataSource(sl())); 


  // Hive
  final favoritesBox = await Hive.openBox<int>('favorites');
  sl.registerLazySingleton<FavoriteLocalDataSource>(
      () => FavoriteLocalDataSourceImpl(favoritesBox));
}


