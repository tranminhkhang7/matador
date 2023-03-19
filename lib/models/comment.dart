import 'dart:convert';

class Comment {
  final int? commentId;
  final String content;
  final double rating;
  final DateTime timestamp;
  final String name;
  Comment({
    this.commentId,
    required this.content,
    required this.rating,
    required this.timestamp,
    required this.name,
  });

  Comment copyWith({
    int? commentId,
    String? content,
    double? rating,
    DateTime? timestamp,
    String? name,
  }) {
    return Comment(
      commentId: commentId ?? this.commentId,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      timestamp: timestamp ?? this.timestamp,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'content': content,
      'rating': rating,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'name': name,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      commentId: map['commentId']?.toInt(),
      content: map['content'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          DateTime.parse(map['timestamp']).millisecondsSinceEpoch),
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(commentId: $commentId, content: $content, rating: $rating, timestamp: $timestamp, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.commentId == commentId &&
        other.content == content &&
        other.rating == rating &&
        other.timestamp == timestamp &&
        other.name == name;
  }

  @override
  int get hashCode {
    return commentId.hashCode ^
        content.hashCode ^
        rating.hashCode ^
        timestamp.hashCode ^
        name.hashCode;
  }
}
