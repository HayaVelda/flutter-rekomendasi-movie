import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<String> favoriteMovies;
  FavoritesPage({required this.favoriteMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film Favorit'),
      ),
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteMovies[index]),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.favorite, color: Colors.red),
          );
        },
      ),
    );
  }
}
