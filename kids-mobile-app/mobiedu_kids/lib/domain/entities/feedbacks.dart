import 'package:mobiedu_kids/domain/entities/feedbacks_details.dart';

class FeedBacks {
  FeedBacks({
    this.feedbacks,
  });

  List<FeedBacksDetails>? feedbacks;
  factory FeedBacks.fromJson(Map<String, dynamic>? json) {
    return FeedBacks(
      feedbacks: json?["feedbacks"] == null
          ? null
          : List<FeedBacksDetails>.from(
              json?["feedbacks"].map((x) => FeedBacksDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'feedbacks': feedbacks,
      };
}
