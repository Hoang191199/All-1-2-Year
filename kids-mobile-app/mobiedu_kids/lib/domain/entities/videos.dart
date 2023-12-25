import 'package:mobiedu_kids/domain/entities/videos_info.dart';

class Videos {
  Videos({
    this.videos,
  });

  List<VideosInfo>? videos;

  factory Videos.fromJson(Map<String, dynamic>? json) {
    return Videos(
      videos: json?["videos"] == null
          ? null
          : List<VideosInfo>.from(
              json?["videos"].map((x) => VideosInfo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'videos': videos,
      };
}
