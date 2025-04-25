import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getPopularMovies;

  MovieBloc(this.getPopularMovies) : super(MovieInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await getPopularMovies();
        emit(MovieLoaded(movies));
      } catch (e) {
  emit(const MovieError("Error cargando películas"));
}
    });
  }
}
