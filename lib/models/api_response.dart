class APIResponse<T> {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<T> results;

  APIResponse({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.results,
  });

  // Factory constructor untuk memparsing JSON menjadi APIResponse
  factory APIResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) create) {
    // Memastikan bahwa 'results' adalah list dan mengonversinya
    var resultsList = json['results'] is List
        ? (json['results'] as List).map((item) => create(item)).toList()
        : <T>[]; // Jika 'results' tidak ada atau bukan List, kembalikan list kosong

    return APIResponse(
      page: json['page'] ?? 0, // Menangani jika 'page' null
      totalResults:
          json['total_results'] ?? 0, // Menangani jika 'total_results' null
      totalPages: json['total_pages'] ?? 0, // Menangani jika 'total_pages' null
      results: resultsList,
    );
  }
}
