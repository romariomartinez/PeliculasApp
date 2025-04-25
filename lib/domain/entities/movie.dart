class Movie{
  final int id;
  final String title;
  final String posterPath;
  final double rating;
  final String releaseDate;
  final List<String> genres;
  final List<int> genreIds;
  final String overview;
  final int duration;
  

  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.rating,
    required this.releaseDate,
    required this.genreIds,
    required this.genres,
    required this.overview,
    required this.duration,
  });  
}