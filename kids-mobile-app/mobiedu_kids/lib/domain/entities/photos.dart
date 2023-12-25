import 'package:mobiedu_kids/domain/entities/photos_details.dart';

class Photos {
  Photos({
    this.photos,
  });

  List<PhotosDetails>? photos;

  factory Photos.fromJson(Map<String, dynamic>? json) {
    return Photos(
      photos: json?["photos"] == null
          ? null
          : List<PhotosDetails>.from(
              json?["photos"].map((x) => PhotosDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "photos": photos,
      };
}
