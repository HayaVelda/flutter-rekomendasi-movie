import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/movie_detail_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ekstrak tahun dari tanggal rilis
    String releaseYear = movie.releaseDate.split('-')[0];

    return GestureDetector(
      onTap: () {
        // Arahkan ke halaman detail film
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movie: movie),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Film
            AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            // Judul Film
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 4),
            // Tanggal Rilis (hanya tahun)
            Text(
              releaseYear,
              style: TextStyle(
                  color: Colors.grey, fontSize: 12), // Ukuran font lebih kecil
            ),
          ],
        ),
      ),
    );
  }
}
