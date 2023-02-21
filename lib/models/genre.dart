import 'dart:convert';

class Genre {
  final int genreId;
  final String genreName;
  Genre({
    required this.genreId,
    required this.genreName,
  });

  Genre copyWith({
    int? genreId,
    String? genreName,
  }) {
    return Genre(
      genreId: genreId ?? this.genreId,
      genreName: genreName ?? this.genreName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'genreId': genreId,
      'genreName': genreName,
    };
  }

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      genreId: map['genreId']?.toInt() ?? 0,
      genreName: map['genreName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Genre.fromJson(String source) => Genre.fromMap(json.decode(source));

  @override
  String toString() => 'Genre(genreId: $genreId, genreName: $genreName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Genre &&
        other.genreId == genreId &&
        other.genreName == genreName;
  }

  @override
  int get hashCode => genreId.hashCode ^ genreName.hashCode;
}
