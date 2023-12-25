import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_review_binding.dart';
import 'dart:math';

import '../pages/course_detail/course_detail_page.dart';

class CourseItem2 extends StatelessWidget {
  const CourseItem2({super.key, this.widthItem, this.courseItem});

  final double? widthItem;
  final Course? courseItem;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = getCurrencyFormatVN();

    return GestureDetector(
        onTap: () {
          CourseDetailBinding().dependencies();
          CartBinding().dependencies();
          CourseReviewBinding().dependencies();
          Get.to(() => CourseDetailPage(
              courseTitle: courseItem?.title ?? '',
              slug: courseItem?.slug ?? '',
              id: courseItem?.id ?? 0));
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
                height: 120.0,
                decoration: BoxDecoration(
                  image: courseItem?.image_url != null
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(
                              courseItem?.image_url ?? ''),
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
                  margin: const EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Text(courseItem?.title ?? "",
                      style: TextStyle(fontSize: 16.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
                Container(
                  width: widthItem != null ? widthItem! / 2 : 160.0,
                  margin: const EdgeInsets.only(top: 12.0),
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Row(
                      children:
                          getListStarViewOfFive(courseItem?.review?.star ?? 0),
                    ),
                    Text('(${courseItem?.review?.total ?? 0})',
                        style: const TextStyle(
                            fontSize: 10, color: Colors.black45))
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
                                currencyFormat
                                    .format(courseItem?.sale_price ?? 0),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Row(
                            children: const [
                              Text('₫', style: TextStyle(fontSize: 12.0)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 6.0),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 1.0),
                            child: Text(
                                currencyFormat.format(courseItem?.price ?? 0),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black45,
                                    decoration: TextDecoration.lineThrough)),
                          ),
                          Row(
                            children: const [
                              Text('₫',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.black45,
                                      decoration: TextDecoration.lineThrough)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ])));
  }
}
