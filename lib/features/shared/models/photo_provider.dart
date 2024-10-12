import 'package:journal_app/features/shared/models/photo.dart';
import 'package:journal_app/features/shared/services/services.dart';

class PhotoProvider {
  PhotoProvider._();

  static Future<List<int>> insert(List<Photo> images) async {
    List<int> imageIds = [];

    for (int i = 0; i < images.length; i++) {
      imageIds.add(await databaseService.db.insert(databaseService.table.images, images[i].toMap()));
    }

    return imageIds;
  }

  static Future<List<Photo>> getAllImages() async {
    final result = await databaseService.db.query(databaseService.table.images);

    final images = [for (Map<String, dynamic> image in result) Photo.fromJSON(image)];

    return images;
  }

  static Future<void> delete(Photo image) async {
    await databaseService.db.delete(databaseService.table.images, where: 'id = ?', whereArgs: [image.id]);
  }

  static Future<void> deleteMulti(List<Photo?> images) async {
    for (var i = 0; i < images.length; i++) {
      await databaseService.db.delete(databaseService.table.images, where: 'id = ?', whereArgs: [images[i]?.id]);
    }
  }

  static Future<void> edit(Photo image) async {
    await databaseService.db.update(
      databaseService.table.images,
      image.toMap(),
      where: 'id = ?',
      whereArgs: [image.id],
    );
  }
}
