import 'package:mobiedu_kids/domain/entities/growths_info.dart';

class OverView {
  OverView({
        this.school_id,
        this.childPicture,
        this.monthNow,
        this.link,
        this.growthLatest,
        this.growths,
        this.vaccinating,
        this.interestInfo
  });

      String? school_id;
      String? childPicture;
      int? monthNow;
      String? link;
      GrowthsInfo? growthLatest;
      List<GrowthsInfo>? growths;
      String? vaccinating;
      List<Object>? interestInfo;

  factory OverView.fromJson(Map<String, dynamic>? json) {
    return OverView(
        school_id:
          json?["school_id"] == null ? null : json?['school_id'] as String,
        childPicture:
          json?["childPicture"] == null ? null : json?['childPicture'] as String,
        monthNow:
          json?["monthNow"] == null ? null : json?['monthNow'] as int,
        link:
          json?["link"] == null ? null : json?['link'] as String,
        growthLatest:
          json?["growthLatest"] == null ? null : GrowthsInfo.fromJson(json?['growthLatest']),
        growths: json?['growths'] == null
          ? null
          : List<GrowthsInfo>.from(
              json?["growths"].map((x) => GrowthsInfo.fromJson(x))),
        vaccinating:
          json?["vaccinating"] == null ? null : json?['vaccinating'] as String,
        interestInfo: json?['interestInfo'] == null
          ? null
          : List<Object>.from(
              json?["interestInfo"].map((x) => Object())),    
    );
  }

  Map<String, dynamic> toJson() => {
        "school_id": school_id,
        "childPicture": childPicture,
        "monthNow": monthNow,
        "link": link,
        "growthLatest": growthLatest,
        "growths":growths,
        "vaccinating": vaccinating,
        "interestInfo": interestInfo
      };
}
