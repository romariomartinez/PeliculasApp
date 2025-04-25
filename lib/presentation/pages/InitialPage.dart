import 'package:flutter/material.dart';
import 'package:uni_links3/uni_links.dart';

import 'dart:async';

import '../../domain/usecases/get_movies.dart';
import '../../presentation/pages/movie_detail_page.dart';
import '../../domain/entities/movie.dart';
import '../../injection_container.dart' as di;

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleInitialLink();
    _sub = uriLinkStream.listen((Uri? uri) {
      _navigateToMovie(uri);
    });
  }

  Future<void> _handleInitialLink() async {
    final Uri? uri = await getInitialUri();
    if (uri != null) {
      _navigateToMovie(uri);
    } else {
      // Si no hay deep link, carga la app normal
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }

  void _navigateToMovie(Uri? uri) async {
    if (uri != null && uri.host == 'movie') {
      final movieId = int.tryParse(uri.pathSegments.first);
      if (movieId != null) {
        final movies = await di.sl<GetMovies>()();
        final movie = movies.firstWhere(
          (m) => m.id == movieId,
          orElse: () => const Movie(
            id: 0,
            title: 'No encontrada',
            posterPath: '',
            rating: 0,
            releaseDate: '',
            genreIds: [],
            overview: 'No se encontró la película',
            duration: 0, genres: [],
          ),
        );

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailPage(movie: movie),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/movie.png', 
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
