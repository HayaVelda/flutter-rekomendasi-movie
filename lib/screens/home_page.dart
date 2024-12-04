import 'package:flutter/material.dart';
import 'movie_search.dart';
import 'seeAllMovie.dart';
import 'movie_detail_page.dart';
import '../services/movie_service.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> favoriteMovies = [];
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> nowPlayingMovies;
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> topRatedMovies;
  final MovieService movieService = MovieService();

  @override
  void initState() {
    super.initState();
    popularMovies = MovieService().fetchPopularMovies();
    nowPlayingMovies =
        MovieService().fetchMoviesByGenre(28); // Example genre (Action)
    upcomingMovies = MovieService().fetchUpcomingMovies();
    topRatedMovies = MovieService().fetchTopRatedMovies();
  }

  void addToFavorites(String movie) {
    setState(() {
      favoriteMovies.add(movie);
    });
  }

  void navigateToGenre(String genre) {
    int genreId = 0;

    switch (genre) {
      case 'Action':
        genreId = 28;
        break;
      case 'Romance':
        genreId = 10749;
        break;
      case 'Comedy':
        genreId = 35;
        break;
      case 'Horror':
        genreId = 27;
        break;
    }

    movieService.fetchMoviesByGenre(genreId).then((movies) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeeAllMoviesPage(
            genre: genre,
            movies: movies,
          ),
        ),
      );
    }).catchError((e) {
      print('Error fetching movies: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie App',
          style: TextStyle(
            fontSize: 20, // Ubah ukuran teks
            fontWeight: FontWeight.bold, // Buat teks tebal
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(context: context, delegate: MovieSearch());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<Movie>>(
              future: nowPlayingMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final movies = snapshot.data!;
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: 430,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                    ),
                    items: movies.map((movie) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailPage(movie: movie),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                } else {
                  return Center(child: Text('Tidak ada film tersedia'));
                }
              },
            ),
            SizedBox(height: 25),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  GenreCard(
                    'Action',
                    SvgPicture.asset(
                      'assets/icons/action.svg', // Path ke file SVG
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                    navigateToGenre,
                  ),
                  GenreCard(
                    'Romance',
                    SvgPicture.asset(
                      'assets/icons/romance.svg', // Path ke file SVG
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                    navigateToGenre,
                  ),
                  GenreCard(
                    'Comedy',
                    SvgPicture.asset(
                      'assets/icons/comedy.svg', // Path ke file SVG
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                    navigateToGenre,
                  ),
                  GenreCard(
                    'Horror',
                    SvgPicture.asset(
                      'assets/icons/horror.svg', // Path ke file SVG
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                    navigateToGenre,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  16.0, 8.0, 8.0, 8.0), // Tambahkan padding kiri
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Popular Movies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FutureBuilder<List<Movie>>(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final movies = snapshot.data!;
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: movies[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('Tidak ada film tersedia'));
                }
              },
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  16.0, 8.0, 8.0, 8.0), // Tambahkan padding kiri
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Upcoming Movies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FutureBuilder<List<Movie>>(
              future: upcomingMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final movies = snapshot.data!;
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: movies[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('Tidak ada film tersedia'));
                }
              },
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  16.0, 8.0, 8.0, 8.0), // Tambahkan padding kiri
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Top Rated Movies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FutureBuilder<List<Movie>>(
              future: topRatedMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final movies = snapshot.data!;
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: movies[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('Tidak ada film tersedia'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GenreCard extends StatelessWidget {
  final String genre;
  final Widget icon; // Ubah tipe menjadi Widget
  final Function(String) onTap;

  GenreCard(this.genre, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(genre),
      child: Container(
        width: 80,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 108, 108, 108),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon, // Gunakan widget langsung untuk ikon (SVG atau Icon)
            SizedBox(height: 8),
            Text(
              genre,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
