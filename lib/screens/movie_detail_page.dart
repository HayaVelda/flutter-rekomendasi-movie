import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import paket flutter_svg
import '../models/movie.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg', // Ganti dengan path SVG Anda
            height: 24, // Ukuran ikon
            width: 24,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text(
          'Movie Detail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: movie.posterPath.isNotEmpty
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        height: 300,
                      )
                    : Icon(Icons.movie, size: 100),
              ),
              SizedBox(height: 16),
              Text(
                movie.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text(
                '${movie.releaseDate}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/star.svg', // Ganti dengan path SVG ikon bintang
                    height: 20,
                    width: 20,
                    color: Colors.yellow, // Warna ikon bintang
                  ),
                  SizedBox(width: 8), // Jarak antara ikon dan teks
                  Text(
                    '${movie.rating}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                movie.overview,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
