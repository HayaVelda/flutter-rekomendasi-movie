import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Mengimpor flutter_svg
import '../models/movie.dart';
import 'movie_detail_page.dart'; // Tambahkan impor ini

class SeeAllMoviesPage extends StatelessWidget {
  final String genre;
  final List<Movie> movies;

  SeeAllMoviesPage({required this.genre, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$genre Movies',
          style: TextStyle(
            fontSize: 20, // Menetapkan ukuran font lebih kecil
            fontWeight: FontWeight.bold, // Menjadikan teks tebal (bold)
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg', // Ganti dengan path ke file SVG
            width: 24, // Ukuran ikon
            height: 24, // Ukuran ikon
            color: Colors.white, // Mengatur warna ikon jika perlu
          ),
          onPressed: () {
            Navigator.pop(context); // Menggunakan pop untuk kembali
          },
        ),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              'https://image.tmdb.org/t/p/w92${movies[index].posterPath}',
              fit: BoxFit.cover,
              width: 50,
              height: 80,
            ),
            title: Text(movies[index].title),
            subtitle: Text(movies[index].releaseDate.split('-')[0]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movie: movies[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
