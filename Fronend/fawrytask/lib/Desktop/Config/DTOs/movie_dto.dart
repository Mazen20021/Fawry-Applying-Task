class MovieDTO {
  final String title;
  final String year;
  final String type;
  final String imdbID;
  final String poster;

  MovieDTO({
    required this.title,
    required this.year,
    required this.type,
    required this.imdbID,
    required this.poster,
  });

  // ✅ Factory method to convert JSON into MovieDTO object
  factory MovieDTO.fromJson(Map<String, dynamic> json) {
    return MovieDTO(
      title: json["title"] ?? "Unknown",
      year: json["year"] ?? "N/A",
      type: json["type"] ?? "N/A",
      imdbID: json["imdbID"] ?? "",
      poster: json["poster"] ?? "",
    );
  }
}
