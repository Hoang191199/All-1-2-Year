import 'package:mobiedu_kids/domain/entities/shuttle/data_in_day_assign.dart';

class DayInAssignShuttle {
  DayInAssignShuttle({
    this.hai,
    this.ba,
    this.bon,
    this.nam,
    this.sau,
    this.bay,
    this.cn
  });
  List<DataInDatAssign>? hai;
  List<DataInDatAssign>? ba;
  List<DataInDatAssign>? bon;
  List<DataInDatAssign>? nam;
  List<DataInDatAssign>? sau;
  List<DataInDatAssign>? bay;
  List<DataInDatAssign>? cn;

    factory DayInAssignShuttle.fromJson(Map<String, dynamic>? json) {
    return DayInAssignShuttle(
      hai:json?['2'] == null ? null : List<DataInDatAssign>.from(json?["2"].map((x) => DataInDatAssign.fromJson(x))),
      ba:json?['3'] == null ? null : List<DataInDatAssign>.from(json?["3"].map((x) => DataInDatAssign.fromJson(x))),
      bon:json?['4'] == null ? null : List<DataInDatAssign>.from(json?["4"].map((x) => DataInDatAssign.fromJson(x))),
      nam:json?['5'] == null ? null : List<DataInDatAssign>.from(json?["5"].map((x) => DataInDatAssign.fromJson(x))),
      sau:json?['6'] == null ? null : List<DataInDatAssign>.from(json?["6"].map((x) => DataInDatAssign.fromJson(x))),
      bay:json?['7'] == null ? null : List<DataInDatAssign>.from(json?["7"].map((x) => DataInDatAssign.fromJson(x))),
      cn:json?['cn'] == null ? null : List<DataInDatAssign>.from(json?["cn"].map((x) => DataInDatAssign.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    '2': hai,
    '3': ba,
    '4': bon,
    '5': nam,
    '6': sau,
    '7': bay,
    'cn': cn,
  };
}