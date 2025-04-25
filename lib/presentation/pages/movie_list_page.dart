import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../bloc/movie_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../data/datasources/genre_remote_data_source.dart';
import '../../data/models/genre_model.dart';
import '../../core/theme_controller.dart';
import 'movie_detail_page.dart';
import 'favorites_page.dart'; 

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';
  int? selectedGenreId;
  List<Movie> filteredMovies = [];
  List<GenreModel> genres = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadGenres();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<MovieBloc>().add(LoadNextPage());
    }
  }

  Future<void> _loadGenres() async {
    final genreDataSource = context.read<GenreRemoteDataSource>();
    final result = await genreDataSource.getGenres();
    setState(() {
      genres = result;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterMovies(MovieLoaded state) {
    filteredMovies = state.movies.where((movie) {
      final matchesSearch =
          movie.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesGenre =
          selectedGenreId == null || movie.genreIds.contains(selectedGenreId);
      return matchesSearch && matchesGenre;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text("Películas Populares"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Ver favoritos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            tooltip: 'Cambiar tema',
            onPressed: () {
              context.read<ThemeController>().toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                 
                ],
              ),
            );
          } else if (state is MovieLoaded) {
            _filterMovies(state);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        _filterMovies(state);
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Buscar película...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                if (genres.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: genres.map((genre) {
                        final isSelected = genre.id == selectedGenreId;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ChoiceChip(
                            label: Text(genre.name),
                            selected: isSelected,
                            onSelected: (_) {
                              setState(() {
                                selectedGenreId =
                                    isSelected ? null : genre.id;
                                _filterMovies(state);
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<MovieBloc>().add(FetchPopularMovies());
                    },
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: filteredMovies.length,
                      itemBuilder: (context, index) {
                        final movie = filteredMovies[index];
                        final stars = (movie.rating / 2).round();
                        final year = movie.releaseDate.split('-').first;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetailPage(movie: movie),
                              ),
                            );
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag: 'poster_${movie.id}',
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          ...List.generate(
                                            5,
                                            (i) => Icon(
                                              i < stars
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Colors.amber,
                                              size: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text('($year)',
                                              style: const TextStyle(
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (state is MovieError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 48, color: Colors.redAccent),
                  SizedBox(height: 12),
                  Text(
                    'Error al cargar las películas',
                    style: TextStyle(fontSize: 18, color: Colors.redAccent),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("Bloc is starting..."));
        },
      ),
    );
  }
}
