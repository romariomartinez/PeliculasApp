import 'package:hive/hive.dart';

abstract class FavoriteLocalDataSource {
  Future<void> toggleFavorite(int movieId);
  Future<bool> isFavorite(int movieId);
  Future<List<int>> getFavoriteMovieIds();
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final Box<int> box;

  FavoriteLocalDataSourceImpl(this.box);

  @override
  Future<void> toggleFavorite(int movieId) async {
    if (box.containsKey(movieId)) {
      await box.delete(movieId);
    } else {
      await box.put(movieId, movieId);
    }
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    return box.containsKey(movieId);
  }

  @override
  Future<List<int>> getFavoriteMovieIds() async {
    return box.values.toList();
  }
}
