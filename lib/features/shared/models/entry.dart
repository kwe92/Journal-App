import 'dart:convert';

class Entry {
  final String createdDate;
  final String entry;
  const Entry({
    required this.createdDate,
    required this.entry,
  });

  Map<String, dynamic> toMap() {
    return {
      'createdDate': createdDate,
      'entry': entry,
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      createdDate: map['createdDate'] ?? '',
      entry: map['entry'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Entry.fromJson(String source) => Entry.fromMap(json.decode(source));

  @override
  String toString() => 'Entry(createdDate: $createdDate, entry: $entry)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Entry && other.createdDate == createdDate && other.entry == entry;
  }

  @override
  int get hashCode => createdDate.hashCode ^ entry.hashCode;
}
