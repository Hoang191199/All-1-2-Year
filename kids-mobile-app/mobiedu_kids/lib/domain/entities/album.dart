import 'package:mobiedu_kids/domain/entities/album_details.dart';

class Album {
  Album({
    this.album,
  });

  AlbumDetails? album;

  factory Album.fromJson(Map<String, dynamic>? json) {
    return Album(
      album:
          json?["album"] == null ? null : AlbumDetails.fromJson(json?["album"]),
    );
  }

  Map<String, dynamic> toJson() => {
        'album': album,
      };
}
