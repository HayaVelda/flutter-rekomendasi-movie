import 'movie.dart';

class MovieDetail {
  final Movie movie;

  MovieDetail({required this.movie});

  // Factory constructor to create MovieDetail from JSON
  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    // Mengambil data movie yang berada dalam key 'movie'
    var movieData = json['movie'] ?? json;

    return MovieDetail(
      movie: Movie.fromJson(movieData),
    );
  }
}
