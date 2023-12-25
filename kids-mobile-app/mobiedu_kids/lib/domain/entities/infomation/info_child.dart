import 'package:mobiedu_kids/domain/entities/infomation/data_prescription.dart';
import 'package:mobiedu_kids/domain/entities/infomation/info_attendance.dart';
import 'package:mobiedu_kids/domain/entities/infomation/info_child_review.dart';
import 'package:mobiedu_kids/domain/entities/infomation/review_studen.dart';

class InfoChild {
  InfoChild({
      this.infoChildReview,
      this.infoChildReviewDay,
      this.infoChildReviewWeek,
      this.infoAttendance,
      this.medicines,
      this.attendances_back
    }
  );

  List<InfoChildReview>? infoChildReview;
  List<ReviewStudent>? infoChildReviewDay;
  List<ReviewStudent>? infoChildReviewWeek;
  List<InfoAttendance>? infoAttendance;
  List<DataPrescription>? medicines;
  List<InfoAttendance>? attendances_back;

  factory InfoChild.fromJson(Map<String, dynamic>? json) {
    return InfoChild(
      infoChildReview:json?['infoChildReview'] == null ? null : List<InfoChildReview>.from(json?["infoChildReview"].map((x) => InfoChildReview.fromJson(x))),
      infoChildReviewDay:json?['infoChildReviewDay'] == null ? null : List<ReviewStudent>.from(json?["infoChildReviewDay"].map((x) => ReviewStudent.fromJson(x))),
      infoChildReviewWeek:json?['infoChildReviewWeek'] == null ? null : List<ReviewStudent>.from(json?["infoChildReviewWeek"].map((x) => ReviewStudent.fromJson(x))),
      infoAttendance:json?['attendances'] == null ? null : List<InfoAttendance>.from(json?["attendances"].map((x) => InfoAttendance.fromJson(x))),
      medicines:json?['medicines'] == null ? null : List<DataPrescription>.from(json?["medicines"].map((x) => DataPrescription.fromJson(x))),
      attendances_back:json?['attendances_back'] == null ? null : List<InfoAttendance>.from(json?["attendances_back"].map((x) => InfoAttendance.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'infoChildReview': infoChildReview,
    'infoChildReviewDay': infoChildReviewDay,
    'infoChildReviewWeek': infoChildReviewWeek,
    'attendances': infoAttendance,
    'medicines': medicines,
    'attendances_back': attendances_back
  };
}
