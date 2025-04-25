part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMovies extends MovieEvent {}
class LoadNextPage extends MovieEvent {}