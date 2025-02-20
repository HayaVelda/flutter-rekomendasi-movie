class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final double rating;
  final String releaseDate;
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.rating,
    required this.releaseDate,
  });
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'],
      rating: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'] ?? 'Unknown',
    );
  }
}
