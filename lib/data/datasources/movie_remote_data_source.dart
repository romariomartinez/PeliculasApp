import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMovies({required int page});
}


class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
Future<List<MovieModel>> getMovies({int page = 1}) async {

    final url = Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?api_key=c1125c2f075c4c03fa6d2c37b36d03f3&language=es-ES&&page=$page'
    );

     final response = await client.get(url);

  if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['results'] as List;
      return results.map((json) => MovieModel.fromPopularJson(json)).toList();
    } else {
      throw Exception('Error al cargar las películas');
    }
  }
}



