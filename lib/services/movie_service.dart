import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/movie_detail.dart';
import '../models/genre.dart';

class MovieService {
  final String _apiKey =
      'c9bcdc85c0d5d8bc0243d0b95ad0c5b2'; // Ganti dengan API Key TMDB Anda
  final String _baseUrl = 'https://api.themoviedb.org/3';

  // Fetch Popular Movies
  Future<List<Movie>> fetchPopularMovies() async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Pastikan ada hasil
        if (data['results'] != null) {
          return (data['results'] as List)
              .map((movie) => Movie.fromJson(movie))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception(
            'Failed to load popular movies: ${response.statusCode}');
      }
    } catch (e) {
      rethrow; // Menangani error jaringan atau kesalahan lainnya
    }
  }

  // Fetch Upcoming Movies
  Future<List<Movie>> fetchUpcomingMovies() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          return (data['results'] as List)
              .map((movie) => Movie.fromJson(movie))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception(
            'Failed to load upcoming movies: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Top Rated Movies
  Future<List<Movie>> fetchTopRatedMovies() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          return (data['results'] as List)
              .map((movie) => Movie.fromJson(movie))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception(
            'Failed to load top rated movies: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Movie Detail
  Future<MovieDetail> fetchMovieDetail(int movieId) async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/movie/$movieId?api_key=$_apiKey&append_to_response=videos,credits'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieDetail.fromJson(data);
      } else {
        throw Exception('Failed to load movie detail: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Genres
  Future<List<Genre>> fetchGenres() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/genre/movie/list?api_key=$_apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['genres'] != null) {
          return (data['genres'] as List)
              .map((genre) => Genre.fromJson(genre))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load genres: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Movies by Genre
  Future<List<Movie>> fetchMoviesByGenre(int genreId) async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/discover/movie?api_key=$_apiKey&with_genres=$genreId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          return (data['results'] as List)
              .map((movie) => Movie.fromJson(movie))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception(
            'Failed to load movies by genre: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Search Movies by Query
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/search/movie?api_key=$_apiKey&query=${Uri.encodeQueryComponent(query)}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          return (data['results'] as List)
              .map((movie) => Movie.fromJson(movie))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to search movies: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Trailers for a Movie
  Future<List<String>> fetchMovieTrailers(int movieId) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/movie/$movieId/videos?api_key=$_apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          return (data['results'] as List)
              .where((video) => video['site'] == 'YouTube')
              .map<String>((video) => video['key'])
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load trailers: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
