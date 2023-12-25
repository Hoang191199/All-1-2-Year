import 'package:flutter/material.dart';
import 'package:mooc_app/domain/entities/review_rate.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/rate_view_item.dart';

class RateView extends StatelessWidget {
  const RateView({
    super.key,
    this.reviewRate,
  });

  final List<ReviewRate>? reviewRate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: listRateReview()
    );
  }

  List<Widget> listRateReview() {
    List<Widget> listItem = [];
    if (reviewRate?.isNotEmpty ?? false) {
      for (var i = 5; i >= 1; i--) {
        final index = reviewRate?.indexWhere((element) => element.rate == i.toDouble()) ?? -1;
        listItem.add(
          RateViewItem(
            starFillNumber: i.toDouble(), 
            ratePercent: index >= 0 ? (reviewRate?[index].percent ?? 0) : 0
          )
        );
      }
    }
    return listItem;
  }
}