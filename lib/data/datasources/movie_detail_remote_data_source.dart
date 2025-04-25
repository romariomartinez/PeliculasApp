import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieDetailRemoteDataSource {
  final http.Client client;

  MovieDetailRemoteDataSource(this.client);

  // Obtener duración de la película
  Future<int> getRuntime(int movieId) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId?api_key=c1125c2f075c4c03fa6d2c37b36d03f3&language=es-ES',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // Asegúrate de que la duración esté en el formato correcto
      return jsonData['runtime'] ?? 0;  // Si no hay duración, retornar 0
    } else {
      throw Exception('Error al obtener duración de la película');
    }
  }

  // Obtener ID de tráiler de la película
  Future<String?> getTrailerVideoId(int movieId) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=c1125c2f075c4c03fa6d2c37b36d03f3&language=es-ES',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['results'] as List;

      // Buscamos el primer tráiler de YouTube disponible
      final trailer = results.firstWhere(
        (video) =>
            video['site'] == 'YouTube' &&  // Asegúrate de que sea de YouTube
            video['type'] == 'Trailer' &&  // Solo tipo 'Trailer'
            video['key'] != null,          // Asegúrate de que el video tenga una clave
        orElse: () => null,
      );

      return trailer != null ? trailer['key'] : null;
    } else {
      throw Exception('Error al obtener tráiler de la película');
    }
  }
}
