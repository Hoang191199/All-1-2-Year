import 'package:mobiedu_kids/domain/entities/child_basic.dart';
import 'package:mobiedu_kids/domain/entities/growths_details.dart';

class ChildBasicInfo {
  ChildBasicInfo({
    this.child_info,
    this.growths_class,
    this.total_child,
    this.foetus_growth,
    this.child_growth,
  });

  ChildBasic? child_info;
  List<GrowthsDetails>? growths_class;
  int? total_child;
  GrowthsDetails? foetus_growth;
  GrowthsDetails? child_growth;

  factory ChildBasicInfo.fromJson(Map<String, dynamic>? json) {
    return ChildBasicInfo(
      child_info: json?["child_info"] == null
          ? null
          : ChildBasic.fromJson(json?['child_info']),
      growths_class: json?["growths_class"] == null
          ? null
          : List<GrowthsDetails>.from(
              json?["growths_class"].map((x) => GrowthsDetails.fromJson(x))),
      total_child:
          json?["total_child"] == null ? null : json?['total_child'] as int,
      foetus_growth: json?["foetus_growth"] == null
          ? null
          : GrowthsDetails.fromJson(json?['foetus_growth']),
      child_growth: json?["child_growth"] == null
          ? null
          : GrowthsDetails.fromJson(json?['child_growth']),
    );
  }

  Map<String, dynamic> toJson() => {
        "child_info": child_info,
        "growths_class": growths_class,
        "total_child": total_child,
        "foetus_growth": foetus_growth,
        "child_growth": child_growth,
      };
}
