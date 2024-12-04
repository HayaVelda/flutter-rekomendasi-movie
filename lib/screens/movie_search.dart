import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';
import '../screens/movie_detail_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieSearch extends SearchDelegate<String> {
  final MovieService movieService = MovieService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/icons/back.svg', // Path ke file SVG
        width: 24, // Sesuaikan ukuran
        height: 24, // Sesuaikan ukuran
        color: Colors.white, // Set warna sesuai kebutuhan
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: movieService.searchMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final results = snapshot.data!;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w200${results[index].posterPath}',
                  fit: BoxFit.cover,
                  width: 50,
                  height: 80,
                ),
                title: Text(results[index].title),
                subtitle: Text(results[index].releaseDate.split('-')[0]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailPage(movie: results[index]),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(child: Text('No movies found'));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(); // Tidak menampilkan saran jika query kosong
    }

    return FutureBuilder<List<Movie>>(
      future: movieService.searchMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final results = snapshot.data!;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w200${results[index].posterPath}',
                  fit: BoxFit.cover,
                  width: 50,
                  height: 80,
                ),
                title: Text(results[index].title),
                subtitle: Text(results[index].releaseDate.split('-')[0]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailPage(movie: results[index]),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(child: Text('No suggestions available'));
        }
      },
    );
  }
}
