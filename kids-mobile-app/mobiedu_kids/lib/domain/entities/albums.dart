import 'package:mobiedu_kids/domain/entities/albums_details.dart';

class Albums {
  Albums({
    this.albums,
  });

  List<AlbumsDetails>? albums;

  factory Albums.fromJson(Map<String, dynamic>? json) {
    return Albums(
      albums: json?["albums"] == null
          ? null
          : List<AlbumsDetails>.from(
              json?["albums"].map((x) => AlbumsDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'albums': albums,
      };
}
