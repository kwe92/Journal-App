class Photo {
  int? id;
  int entryID;
  final String imageName;

  Photo({this.id, required this.entryID, required this.imageName});

  Map<String, dynamic> toMap() => {
        'id': id,
        'entry_id': entryID,
        'image_name': imageName,
      };

  factory Photo.fromJSON(Map<String, dynamic> json) => Photo(
        id: json['id'],
        entryID: json['entry_id'],
        imageName: json['image_name'],
      );

  @override
  String toString() => 'Photo(id: $id, entryID: $entryID)';
}
