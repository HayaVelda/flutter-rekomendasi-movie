class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0, // Pastikan ada nilai default jika id tidak ada
      name:
          json['name'] ?? '', // Pastikan ada nilai default jika name tidak ada
    );
  }
}
