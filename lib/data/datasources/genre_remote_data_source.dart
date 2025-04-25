import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/genre_model.dart';

abstract class GenreRemoteDataSource {
  Future<List<GenreModel>> getGenres();
}

class GenreRemoteDataSourceImpl implements GenreRemoteDataSource {
  final http.Client client;

  GenreRemoteDataSourceImpl(this.client);


  @override
  Future<List<GenreModel>> getGenres() async {
  try {
    final response = await client.get(
      Uri.parse('https://api.themoviedb.org/3/genre/movie/list?api_key=c1125c2f075c4c03fa6d2c37b36d03f3&language=es-ES'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['genres'] as List)
          .map((genre) => GenreModel.fromJson(genre))
          .toList();
    } else {
      throw Exception('Error al obtener los géneros');
    }
  } catch (e) {
    print("Error: $e");
    rethrow;
  }
}
}