import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/paid_course_details.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_review_binding.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math';

import '../controllers/register_course/add_free_course_binding.dart';
import '../pages/course_detail/course_detail_page.dart';

class CoursePaid extends StatelessWidget {
  const CoursePaid({super.key, this.widthItem, this.courseItem});

  final double? widthItem;
  final PaidCourseDetails? courseItem;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = getCurrencyFormatVN();

    return GestureDetector(
        onTap: () {
          AddFreeCourseBinding().dependencies();
          CourseDetailBinding().dependencies();
          CartBinding().dependencies();
          CourseReviewBinding().dependencies();
          Get.to(() => CourseDetailPage(courseTitle: courseItem?.name ?? '', slug: courseItem?.slug ?? '', id: courseItem?.id ?? 0));
        },
        child: Container(
            width: widthItem ?? 160.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Row(children: [
              Container(
                width: widthItem != null ? widthItem! / 3 : 160.0,
                constraints: BoxConstraints(
                   minHeight: 120,
                   maxHeight: 150,
                 ),
                decoration: BoxDecoration(
                  image: courseItem?.thumbnailFileUrl?.isNotEmpty ?? false
                      ? DecorationImage(
                      image: CachedNetworkImageProvider(
                          courseItem?.thumbnailFileUrl  ?? ''),
                      fit: BoxFit.cover)
                      : const DecorationImage(
                      image: AssetImage('assets/images/course_image.png'),
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
              ),
              Column(children: [
                // Container(
                //   height: 100.0,
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage('assets/images/course_image.png'),
                //         fit: BoxFit.cover),
                //     borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(8.0),
                //         topRight: Radius.circular(8.0)),
                //   ),
                // ),
                Container(
                  width: widthItem != null ? widthItem! / 2 : 160.0,
                  margin: const EdgeInsets.only(top: 0),
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Text(courseItem?.name ?? "",
                      style: TextStyle(fontSize: 16.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
                Container(
                  width: widthItem != null ? widthItem! / 2 : 160.0,
                  margin: const EdgeInsets.only(top: 12.0),
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Row(children: [
                      Text("${courseItem?.totalCompleteLessons ?? 0} / ${courseItem?.totalLessons ?? 0}"),]
                    ),
                    SizedBox(width: 20,),
                    Container(
                      width: 40,
                      height: 50,
                    child:
                    CircularPercentIndicator(
                      radius: 22.0,
                      lineWidth: 4.0,
                      percent: courseItem!.totalLessons! > 0 ? (courseItem?.totalCompleteLessons)!/(courseItem?.totalLessons)! : 0.0,
                      center: Text('${courseItem?.completePercent ?? "0%"}'),
                      progressColor: Colors.green,
                    ),
                    )
                    // Text('(${courseItem?.completePercent ?? "0%"})',
                    //     style: const TextStyle(
                    //         fontSize: 10, color: Colors.black45))
                  ]),
                  // Row(mainAxisSize: MainAxisSize.min, children: [
                  //   Icon(CupertinoIcons.star_fill,
                  //       color: Colors.yellow[600], size: 16),
                  //   Icon(CupertinoIcons.star_fill,
                  //       color: Colors.yellow[600], size: 16),
                  //   Icon(CupertinoIcons.star_fill,
                  //       color: Colors.yellow[600], size: 16),
                  //   Icon(CupertinoIcons.star_fill,
                  //       color: Colors.yellow[600], size: 16),
                  //   Icon(CupertinoIcons.star,
                  //       color: Colors.yellow[600], size: 16),
                  //   const Text('(230)',
                  //       style: TextStyle(fontSize: 10, color: Colors.black45))
                  // ]),
                ),
                Container(
                  width: widthItem != null ? widthItem! / 2 : 160.0,
                  margin: const EdgeInsets.only(top: 12.0),
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 1.0),
                            child: Text(
                                ("${courseItem?.teacherName ?? ""}"),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                          // Row(
                          //   children: const [
                          //     Text('₫', style: TextStyle(fontSize: 12.0)),
                          //   ],
                          // )
                        ],
                      ),
                      const SizedBox(width: 6.0),
                      // Row(
                      //   children: [
                      //     Container(
                      //       margin: const EdgeInsets.only(right: 1.0),
                      //       child: Text("${courseItem?.slug ?? ""}",
                      //           style: TextStyle(
                      //               fontSize: 12.0,
                      //               color: Colors.black45,
                      //               decoration: TextDecoration.lineThrough)),
                      //     ),
                      //     Row(
                      //       children: const [
                      //         Text('₫',
                      //             style: TextStyle(
                      //                 fontSize: 10.0,
                      //                 color: Colors.black45,
                      //                 decoration: TextDecoration.lineThrough)),
                      //       ],
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                )
              ]),
            ])));
  }
}
