import 'package:mobiedu_kids/domain/entities/news_feed/album.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/photo_post.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/video.dart';

class DataPhotoAlbumVideo {
  DataPhotoAlbumVideo({
    this.photos,
    this.albums,
    this.album,
    this.videos,
  });

  List<PhotoPost>? photos;
  List<Album>? albums;
  Album? album;
  List<Video>? videos;

  factory DataPhotoAlbumVideo.fromJson(Map<String, dynamic>? json) {
    return DataPhotoAlbumVideo(
      photos: json?["photos"] == null ? [] : List<PhotoPost>.from(json?["photos"].map((x) => PhotoPost.fromJson(x))),
      albums: json?["albums"] == null ? [] : List<Album>.from(json?["albums"].map((x) => Album.fromJson(x))),
      album: json?["album"] == null ? null : Album.fromJson(json?["album"]),
      videos: json?["videos"] == null ? [] : List<Video>.from(json?["videos"].map((x) => Video.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'photos': photos,
    'albums': albums,
    'album': album,
    'videos': videos,
  };
}