import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_scroll_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_review_controller.dart';
import 'package:mooc_app/presentation/controllers/login_controller.dart';
import 'package:mooc_app/presentation/pages/cart/cart_page.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/button_add_to_cart.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/button_register_course.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_description.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_detail_image_video.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_info.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_lesson.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/offer_period.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/price_course.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/register_course_bottom.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/student_rate.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/teacher_info.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/what_learn.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mooc_app/presentation/widgets/circular_loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseDetailPage extends StatelessWidget {
  CourseDetailPage({
    Key? key,
    required this.courseTitle,
    required this.slug,
    required this.id,
  }) : super(key: key);

  final String courseTitle;
  final String slug;
  final int id;

  final courseDetailController = Get.find<CourseDetailController>();
  final courseReviewController = Get.find<CourseReviewController>();
  final courseScrollController = Get.put(CourseDetailScrollController());
  final cartController = Get.find<CartController>();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Obx(() => loginController.isHandleLogging.value
          ? const CupertinoPageScaffold(
              backgroundColor: Colors.white,
              child: Center(
                child: CircularLoadingIndicator(),
              ),
            )
          : GetX(
              init: courseDetailController,
              initState: (state) async {
                try {
                  await courseDetailController.fetchData(id, slug);
                  if (courseDetailController.reponseCourseDetail.value?.error ??
                      false) {
                    if (courseDetailController
                            .reponseCourseDetail.value?.code ==
                        ResponseCode.loginSession) {
                      if (context.mounted) {
                        showLoginSessionDialog(context);
                      }
                    } else {
                      if (context.mounted) {
                        showSnackbar(
                            SnackbarType.error,
                            AppLocalizations.of(context)!.course,
                            AppLocalizations.of(context)!.error);
                      }
                    }
                  } else {
                    if (courseDetailController.courseData.value?.isMapping ??
                        false) {
                      await courseReviewController.fetchData(id);
                    }
                  }
                } catch (error) {
                  showSnackbar(SnackbarType.error, "Error",
                      AppLocalizations.of(context)!.error);
                }
              },
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: CupertinoPageScaffold(
                      navigationBar: CupertinoNavigationBar(
                          middle: Text(
                              // 'Chi tiết khóa học'
                              courseTitle,
                              style: const TextStyle(color: Colors.black),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          trailing: Obx(() => badges.Badge(
                              position: badges.BadgePosition.topEnd(
                                  top: 0.0, end: 0.0),
                              badgeContent: Text(
                                  cartController.numCoursesInCart < 100
                                      ? cartController.numCoursesInCart
                                          .toString()
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
                      child: courseDetailController.isLoading.value
                          ? Container(
                              color: Colors.white,
                              child: const Center(
                                child: CircularLoadingIndicator(),
                              ),
                            )
                          : Scaffold(
                              body: Container(
                                  padding: EdgeInsets.only(
                                      top: (statusBarHeight +
                                          const CupertinoNavigationBar()
                                              .preferredSize
                                              .height)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      courseDetailController.courseData.value
                                                      ?.video_url ==
                                                  null ||
                                              (courseDetailController
                                                      .courseData
                                                      .value
                                                      ?.video_url
                                                      ?.isEmpty ??
                                                  false)
                                          ? courseDetailController
                                                      .reponseCourseDetail
                                                      .value
                                                      ?.error ??
                                                  false
                                              ? Container(
                                                  height: 220.0,
                                                )
                                              : Container()
                                          : CourseDetailImageVideo(
                                              courseInfo: courseDetailController
                                                  .courseData.value),
                                      Expanded(
                                          child: SingleChildScrollView(
                                              controller: courseScrollController
                                                  .scrollController,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  courseDetailController
                                                              .courseData
                                                              .value
                                                              ?.video_url
                                                              ?.isEmpty ??
                                                          false
                                                      ? CourseDetailImageVideo(
                                                          courseInfo:
                                                              courseDetailController
                                                                  .courseData
                                                                  .value)
                                                      : Container(),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0),
                                                      child: Column(
                                                        children: [
                                                          (courseDetailController
                                                                      .courseData
                                                                      .value
                                                                      ?.isMapping ??
                                                                  false)
                                                              ? Container()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                                  child: PriceCourse(
                                                                      price: courseDetailController
                                                                              .courseData
                                                                              .value
                                                                              ?.price
                                                                              .toDouble() ??
                                                                          0.0,
                                                                      sellPrice: courseDetailController
                                                                              .courseData
                                                                              .value
                                                                              ?.sale_price
                                                                              .toDouble() ??
                                                                          0.0,
                                                                      discount:
                                                                          getDiscountPercent(),
                                                                      slug:
                                                                          slug),
                                                                ),
                                                          (courseDetailController
                                                                      .courseData
                                                                      .value
                                                                      ?.isMapping ??
                                                                  false)
                                                              ? Container()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                                  child: const OfferPeriod(
                                                                      dayNumber:
                                                                          1),
                                                                ),
                                                          (courseDetailController
                                                                      .courseData
                                                                      .value
                                                                      ?.isMapping ??
                                                                  false)
                                                              ? Container()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                                  width:
                                                                      widthScreen,
                                                                  child: ButtonRegisterCourse(
                                                                      courseInfo: courseDetailController
                                                                          .courseData
                                                                          .value),
                                                                ),
                                                          ((courseDetailController
                                                                              .courseData
                                                                              .value
                                                                              ?.sale_price ??
                                                                          0.0) >
                                                                      0 &&
                                                                  !(courseDetailController
                                                                          .courseData
                                                                          .value
                                                                          ?.isMapping ??
                                                                      false))
                                                              ? Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                                  width:
                                                                      widthScreen,
                                                                  child: ButtonAddToCart(
                                                                      courseInfo: courseDetailController
                                                                          .courseData
                                                                          .value),
                                                                )
                                                              : Container(),
                                                          CourseInfo(
                                                              courseInfo:
                                                                  courseDetailController
                                                                      .courseData
                                                                      .value),
                                                          WhatLearn(
                                                              courseInfo:
                                                                  courseDetailController
                                                                      .courseData
                                                                      .value),
                                                          CourseDescription(
                                                              courseInfo:
                                                                  courseDetailController
                                                                      .courseData
                                                                      .value),
                                                          TeacherInfo(
                                                              teacherInfo:
                                                                  courseDetailController
                                                                      .courseData
                                                                      .value
                                                                      ?.teacher),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0),
                                                            child: CourseLesson(
                                                                isRegisted: courseDetailController
                                                                        .courseData
                                                                        .value
                                                                        ?.isMapping ??
                                                                    false,
                                                                idCourse: courseDetailController
                                                                        .courseData
                                                                        .value
                                                                        ?.id ??
                                                                    0,
                                                                listLesson:
                                                                    courseDetailController
                                                                        .courseData
                                                                        .value
                                                                        ?.lesson),
                                                          ),
                                                          (courseDetailController
                                                                      .courseData
                                                                      .value
                                                                      ?.isMapping ??
                                                                  false)
                                                              ? courseReviewController
                                                                      .isLoading
                                                                      .value
                                                                  ? Container(
                                                                      color: Colors
                                                                          .white,
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              30.0),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            CircularLoadingIndicator(),
                                                                      ),
                                                                    )
                                                                  : StudentRate(
                                                                      idCourse:
                                                                          courseDetailController.courseData.value?.id ??
                                                                              0,
                                                                      review: courseReviewController
                                                                          .courseReviewData
                                                                          .value
                                                                          ?.review,
                                                                      courseReviews: courseReviewController
                                                                          .courseReviewData
                                                                          .value
                                                                          ?.reviewData,
                                                                      isShowReviewInput: courseReviewController
                                                                              .courseReviewData
                                                                              .value
                                                                              ?.isShowReviewInput ??
                                                                          false,
                                                                    )
                                                              : StudentRate(
                                                                  idCourse: courseDetailController
                                                                          .courseData
                                                                          .value
                                                                          ?.id ??
                                                                      0,
                                                                  review: courseDetailController
                                                                      .courseData
                                                                      .value
                                                                      ?.review,
                                                                  courseReviews:
                                                                      courseDetailController
                                                                          .courseData
                                                                          .value
                                                                          ?.courseReviews,
                                                                  isShowReviewInput:
                                                                      false,
                                                                ),
                                                        ],
                                                      ))
                                                ],
                                              ))),
                                      Obx(
                                        () => (!(courseDetailController
                                                        .courseData
                                                        .value
                                                        ?.isMapping ??
                                                    false) &&
                                                courseScrollController
                                                    .showBottom.value)
                                            ? RegisterCourseBottom(
                                                courseInfo:
                                                    courseDetailController
                                                        .courseData.value)
                                            : const SizedBox(),
                                      )
                                    ],
                                  )),
                            )),
                );
              })),
    );
  }

  Future<bool> onWillPop() async {
    reloadHomeWhenBackFromOther();
    return true;
  }

  int getDiscountPercent() {
    double price = courseDetailController.courseData.value?.price ?? 0;
    double salePrice = courseDetailController.courseData.value?.sale_price ?? 0;
    if (price > 0) {
      double percent = ((price - salePrice) / price) * 100;
      return percent.ceil();
    }
    return 0;
  }

  void handlePressCart() async {
    await cartController.fetchCartData();
    Get.off(() => CartPage(courseTitle: courseTitle, slug: slug, id: id));
  }
}
