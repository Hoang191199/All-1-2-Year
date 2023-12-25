import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_combo_detail_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_scroll_controller.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/price_course.dart';

import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mooc_app/presentation/pages/course_detail/widgets/register_course_bottom.dart';
import 'package:mooc_app/presentation/widgets/circular_loading_indicator.dart';
import 'package:mooc_app/presentation/widgets/course_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/course_combo_detail_image_video.dart';

class CourseComboDetailPage extends StatelessWidget {
  CourseComboDetailPage({
    Key? key,
    required this.courseTitle,
    required this.slug,
    required this.id,
  }) : super(key: key);

  final String courseTitle;
  final String slug;
  final int id;

  final scrollController = ScrollController();
  final courseComboDetailController = Get.find<CourseComboDetailController>();
  final courseScrollController = Get.put(CourseDetailScrollController());
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    
    return GetX(
        init: courseComboDetailController,
        initState: (state) {
          courseComboDetailController.fetchData(id, slug);
          courseComboDetailController.fetchDataCourseFullSlug(slug);
        },
        builder: (_) {
          return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                  middle: Text(AppLocalizations.of(context)!.courseComboDetail,
                      style: const TextStyle(color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  trailing: Obx(() => badges.Badge(
                      position: badges.BadgePosition.topEnd(top: 0.0, end: 0.0),
                      badgeContent: Text(
                          cartController.numCoursesInCart < 100
                              ? cartController.numCoursesInCart.toString()
                              : '99+',
                          style: const TextStyle(
                              fontSize: 10.0, color: Colors.white)),
                      child: GestureDetector(
                        onTap: () {
                          handlePressCart();
                        },
                        child: const SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Icon(CupertinoIcons.cart_badge_plus,
                              size: 26.0, color: Colors.black),
                        ),
                      )))),
              child: courseComboDetailController.isLoading.value
                  ? Container(
                      color: Colors.white,
                      child: const Center(
                        child: CircularLoadingIndicator(),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CourseComboDetailImageVideo(
                                    courseInfo: courseComboDetailController
                                        .courseComboData.value,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          courseComboDetailController
                                                  .courseComboData
                                                  .value
                                                  ?.name ??
                                              '',
                                          style: const TextStyle(
                                              color: Colors.black),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(width: 10.0),
                                        PriceCourse(
                                          price: courseComboDetailController
                                                  .courseComboData.value?.price
                                                  .toDouble() ??
                                              0.0,
                                          sellPrice: courseComboDetailController
                                                  .courseComboData
                                                  .value
                                                  ?.sellingPrice  ??
                                              0.0,
                                          discount: getDiscountPercent(),
                                          slug: slug,
                                        ),
                                        const SizedBox(width: 10.0),
                                        Row(
                                          children: [
                                            Text.rich(
                                              TextSpan(children: [
                                                const WidgetSpan(
                                                  child: Icon(
                                                    CupertinoIcons.group_solid,
                                                    size: 18,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                                const WidgetSpan(
                                                    child:
                                                        SizedBox(width: 6.0)),
                                                TextSpan(
                                                  text:
                                                      '${courseComboDetailController.courseComboData.value?.totalCourses ?? 0} ${AppLocalizations.of(context)!.course}',
                                                  style: const TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black45),
                                                ),
                                              ]),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Text.rich(
                                              TextSpan(children: [
                                                const WidgetSpan(
                                                  child: Icon(
                                                    CupertinoIcons.book_solid,
                                                    size: 18,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                                const WidgetSpan(
                                                    child:
                                                        SizedBox(width: 8.0)),
                                                TextSpan(
                                                  text:
                                                      '${courseComboDetailController.courseComboData.value?.totalTeachers ?? 0} ${AppLocalizations.of(context)!.teacher}',
                                                  style: const TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black45),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                        GridView.count(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0),
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 16.0,
                                          mainAxisSpacing: 16.0,
                                          shrinkWrap: true,
                                          childAspectRatio: widthScreen / 500.0,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          children: List.generate(
                                            courseComboDetailController
                                                    .courseComboData
                                                    .value
                                                    ?.courses
                                                    ?.length ??
                                                0,
                                            (index) => Center(
                                              child: CourseItem(
                                                widthItem: widthScreen / 2,
                                                courseItem:
                                                    courseComboDetailController
                                                        .courseComboData
                                                        .value
                                                        ?.courses?[index].parseCourse(),
                                                showDiscount: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            Obx(
                              () => 
                              (!(courseComboDetailController.courseComboData.value?.registered ?? false)) 
                                  ? RegisterCourseBottom(courseInfo: courseComboDetailController.courseComboData.value?.parseCourse(),courseType: 'courseCombo')
                                  : const SizedBox(),
                            )
                          ])));
        });
  }

  int getDiscountPercent() {
    double price =
        courseComboDetailController.courseComboData.value?.price ?? 0;
    double salePrice =
        courseComboDetailController.courseComboData.value?.sellingPrice ?? 0;
    if (price > 0) {
      double percent = ((price - salePrice) / price) * 100;
      return percent.ceil();
    }
    return 0;
  }

  void handlePressCart() {
    // Get.to(() => CartPage());
  }
}
