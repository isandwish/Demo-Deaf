import 'dart:convert';

class ResultCollection {
  final String text;
  final dynamic time;
  ResultCollection({
    required this.text,
    required this.time,
  });

  ResultCollection copyWith({
    String? text,
    dynamic? time,
  }) {
    return ResultCollection(
      text: text ?? this.text,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'time': time,
    };
  }

  factory ResultCollection.fromMap(Map<String, dynamic> map) {
    return ResultCollection(
      text: map['text'] as String,
      time: map['time'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultCollection.fromJson(String source) =>
      ResultCollection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResultCollection(text: $text, time: $time)';

  @override
  bool operator ==(covariant ResultCollection other) {
    if (identical(this, other)) return true;

    return other.text == text && other.time == time;
  }

  @override
  int get hashCode => text.hashCode ^ time.hashCode;
}
