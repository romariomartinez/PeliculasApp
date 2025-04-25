import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/movie.dart';
import '../../data/datasources/genre_remote_data_source.dart';
import '../../data/datasources/movie_detail_remote_data_source.dart';
import '../../injection_container.dart' as di;

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Box<int> favoritesBox;
  bool isFavorite = false;
  List<String> genreNames = [];
  int? runtime;
  String? trailerVideoId;

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<int>('favorites');
    isFavorite = favoritesBox.containsKey(widget.movie.id);
    _loadGenres();
    _loadRuntime();
    _loadTrailer();
  }

  void _toggleFavorite() async {
    if (favoritesBox.containsKey(widget.movie.id)) {
      await favoritesBox.delete(widget.movie.id);
    } else {
      await favoritesBox.put(widget.movie.id, widget.movie.id);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Future<void> _loadGenres() async {
    final genreDataSource = context.read<GenreRemoteDataSource>();
    final allGenres = await genreDataSource.getGenres();
    final movieGenreNames = allGenres
        .where((genre) => widget.movie.genreIds.contains(genre.id))
        .map((genre) => genre.name)
        .toList();

    setState(() {
      genreNames = movieGenreNames;
    });
  }

  Future<void> _loadRuntime() async {
    try {
      final durationFetched =
          await di.sl<MovieDetailRemoteDataSource>().getRuntime(widget.movie.id);
      setState(() {
        runtime = durationFetched;
      });
    } catch (e) {
      runtime = null;
    }
  }

  Future<void> _loadTrailer() async {
    try {
      final videoId = await di
          .sl<MovieDetailRemoteDataSource>()
          .getTrailerVideoId(widget.movie.id);
      setState(() {
        trailerVideoId = videoId;
      });
    } catch (e) {
      trailerVideoId = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final stars = (movie.rating / 2).round();
    final year = movie.releaseDate.split('-').first;

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'poster_${movie.id}',
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.jpg',
                image: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Icon(
                          i < stars ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('($year)', style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('Géneros:',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children:
                        genreNames.map((g) => Chip(label: Text(g))).toList(),
                  ),
                  const SizedBox(height: 12),
                  Text('Duración: ${runtime != null ? '$runtime min' : '...'}'),
                  const SizedBox(height: 16),

                  if (trailerVideoId != null) ...[
                    ElevatedButton.icon(
                      onPressed: () => launchTrailer(trailerVideoId!),
                      icon: const Icon(Icons.play_circle_fill),
                      label: const Text('Ver tráiler'),
                    ),
                    const SizedBox(height: 12),
                  ],

                  ElevatedButton.icon(
                    onPressed: _toggleFavorite,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    label: Text(
                      isFavorite
                          ? 'Quitar de favoritos'
                          : 'Agregar a favoritos',
                    ),
                  ),
                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed: () {
                      final url =
                          'https://www.themoviedb.org/movie/${widget.movie.id}';
                      final message =
                          '🎬 ¡Recomiendo esta película!\n${movie.title}\n$url';
                      Share.share(message);
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Compartir'),
                  ),
                  const SizedBox(height: 16),

                  Text('Sinopsis:',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(movie.overview),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void launchTrailer(String videoId) async {
  final url = Uri.parse('https://www.youtube.com/watch?v=$videoId');
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
