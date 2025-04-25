import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.rating,
    required super.releaseDate,
    required super.genreIds,
    required super.genres,
    required super.overview,
    required super.duration,
  });

  factory MovieModel.fromPopularJson(Map<String, dynamic> json) {
  return MovieModel(
    id: json['id'],
    title: json['title'],
    posterPath: json['poster_path'] ?? '',
    rating: (json['vote_average'] as num).toDouble(),
    releaseDate: json['release_date'] ?? '',
    genreIds: List<int>.from(json['genre_ids'] ?? []),
    genres: [],
    overview: json['overview'] ?? '',
    duration: 0, // runtime no viene en /discover o /popular
  );
}
factory MovieModel.fromDetailJson(Map<String, dynamic> json) {
  return MovieModel(
    id: json['id'],
    title: json['title'],
    posterPath: json['poster_path'] ?? '',
    rating: (json['vote_average'] as num).toDouble(),
    releaseDate: json['release_date'] ?? '',
    genreIds: [], // no viene genre_ids aquí
    genres: (json['genres'] as List).map((g) => g['name'] as String).toList(),
    overview: json['overview'] ?? '',
    duration: json['runtime'] ?? 0,
  );
}



 
}
