import 'dart:convert';

class ContentCollection {
  final String text;
  ContentCollection({
    required this.text,
  });

  ContentCollection copyWith({
    String? text,
  }) {
    return ContentCollection(
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory ContentCollection.fromMap(Map<String, dynamic> map) {
    return ContentCollection(
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContentCollection.fromJson(String source) =>
      ContentCollection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ContentCollection(text: $text)';

  @override
  bool operator ==(covariant ContentCollection other) {
    if (identical(this, other)) return true;

    return other.text == text;
  }

  @override
  int get hashCode => text.hashCode;
}
