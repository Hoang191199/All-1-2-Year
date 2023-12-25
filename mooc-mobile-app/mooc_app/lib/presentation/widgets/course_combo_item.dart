import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/domain/entities/course_combo.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_combo_detail_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_binding.dart';
import 'package:mooc_app/presentation/controllers/register_course/add_free_course_binding.dart';
import 'package:mooc_app/presentation/pages/course_detail/course_combo_detail_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseComboItem extends StatelessWidget {
  CourseComboItem({
    Key? key,
    this.widthItem,
    this.courseItem,
    this.showDiscount = false,
  }) : super(key: key);

  final double? widthItem;
  final CourseCombo? courseItem;
  final bool showDiscount;

  final currencyFormat = getCurrencyFormatVN();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          CourseComboDetailBinding().dependencies();
          CourseDetailBinding().dependencies();
          CartBinding().dependencies();
          AddFreeCourseBinding().dependencies();
          CartBinding().dependencies();
          Get.to(() => CourseComboDetailPage(
              courseTitle: courseItem?.title ?? '',
              slug: courseItem?.slug ?? '',
              id: courseItem?.id ?? 0));
        },
        child: Container(
          width: widthItem ?? 160.0,
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(66, 168, 164, 164),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: courseItem?.image_url == null ||
                          (courseItem?.image_url?.isEmpty ?? false)
                      ? const DecorationImage(
                          image: AssetImage('assets/images/course_image.png'),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: CachedNetworkImageProvider(
                              courseItem?.image_url ?? ''),
                          fit: BoxFit.cover),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(courseItem?.title ?? "",
                        style: const TextStyle(
                            fontSize: 15.0, color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 1.0),
                              child: Text(
                                  currencyFormat
                                      .format(courseItem?.sale_price ?? 0),
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            const Text('₫',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black)),
                          ],
                        ),
                        const SizedBox(width: 6.0),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 1.0),
                              child: Text(
                                  currencyFormat.format(courseItem?.price ?? 0),
                                  style: const TextStyle(
                                      fontSize: 11.0,
                                      color: Colors.black45,
                                      decoration: TextDecoration.lineThrough)),
                            ),
                            const Text('₫',
                                style: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.black45,
                                    decoration: TextDecoration.lineThrough)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              const WidgetSpan(
                                  child: Icon(
                                CupertinoIcons.group_solid,
                                size: 14,
                                color: Colors.black45,
                              )),
                              const WidgetSpan(
                                child: SizedBox(width: 6.0),
                              ),
                              TextSpan(
                                text:
                                    '${currencyFormat.format(courseItem?.totalCourses ?? 0)} ${AppLocalizations.of(context)!.course}',
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text.rich(
                          TextSpan(
                            children: [
                              const WidgetSpan(
                                  child: Icon(
                                CupertinoIcons.book_solid,
                                size: 14,
                                color: Colors.black45,
                              )),
                              const WidgetSpan(
                                child: SizedBox(width: 6.0),
                              ),
                              TextSpan(
                                text:
                                    '${currencyFormat.format(courseItem?.totalTeachers ?? 0)} ${AppLocalizations.of(context)!.teacher}',
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  String getDiscountPercent() {
    if (courseItem?.price != null && courseItem!.price > 0) {
      double percent = ((courseItem!.price - (courseItem?.sale_price ?? 0)) /
              courseItem!.price) *
          100;
      return '-${percent.ceil()}%';
    }
    return '';
  }
}
