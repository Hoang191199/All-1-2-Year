
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_colors.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/domain/entities/review.dart';
import 'package:mooc_app/domain/entities/review_data.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_review_controller.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/rate_view.dart';

class StudentRate extends StatefulWidget {
  StudentRate({
    super.key,
    required this.idCourse,
    this.review,
    this.courseReviews,
    required this.isShowReviewInput,
  });

  final int idCourse;
  final Review? review;
  final List<ReviewData>? courseReviews;
  final bool isShowReviewInput;

  final courseReviewController = Get.find<CourseReviewController>();

  @override
  State<StudentRate> createState() => _StudentRateState();
}

class _StudentRateState extends State<StudentRate> {
  int page = 1;
  int pageSize = 10;
  List<ReviewData>? courseReviewsPaging = [];
  
  @override
  void initState() {
    setState(() {
      courseReviewsPaging = (widget.courseReviews?.length ?? 0) > (page * pageSize) ? widget.courseReviews?.sublist(0, page * pageSize) : widget.courseReviews;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isShowReviewInput 
          ? Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Đánh giá khóa học', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
                Container(
                  width: 230.0,
                  margin: const EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: starRateCourse(widget.courseReviewController.starFillNumber.value),
                    )
                  ),
                ),
                Obx(
                  () => widget.courseReviewController.starFillNumber.value > 0
                    ? Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            maxLines: 4,
                            controller: widget.courseReviewController.reviewInputController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45),
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              hintText: 'Nhập nội dung đánh giá (tối thiểu 20 ký tự)',
                              hintStyle: TextStyle(color: Colors.black38),
                              contentPadding: EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45),
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            cursorColor: Colors.black,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  handlePressClearRateReview();
                                },
                                child: Text(
                                  'Hủy'.toUpperCase(), 
                                  style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.red)
                                ),
                              ),
                              const SizedBox(width: 40.0),
                              GestureDetector(
                                onTap: () {
                                  handlePressSendRateReview(context);
                                },
                                child: Text(
                                  'Gửi đánh giá'.toUpperCase(), 
                                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: AppColors.primaryBlue)
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                    : Container()
                )
              ],
            ),
          )
          : Container(),
        Container(
          margin: const EdgeInsets.only(top: 30.0),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Đánh giá của học viên', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Text(
                      (widget.review?.star ?? 0.0).toString(), 
                      style: const TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.black)
                    ),
                    const SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: getListStarViewOfFive(widget.review?.star ?? 0.0),
                        ),
                        Text(
                          '${widget.review?.total ?? 0} đánh giá', 
                          style: const TextStyle(fontSize: 14.0, color: Colors.black)
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: RateView(reviewRate: widget.review?.reviewRate)
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30.0),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Nhận xét của học viên', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),
        courseReviewsPaging?.isNotEmpty ?? false 
          ? Column(
            children: [
              ListView.separated(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: courseReviewsPaging?.length ?? 0,
                separatorBuilder: (context, index) => const Divider(color: Colors.black12, thickness: 1.0), 
                itemBuilder: (context, index) => Row(
                  children: [
                    Container(
                      child: (courseReviewsPaging?[index].avatarUrl?.isNotEmpty ?? false) || (courseReviewsPaging?[index].avatar?.isNotEmpty ?? false)
                        ? CachedNetworkImage(
                          imageUrl: courseReviewsPaging?[index].avatarUrl ?? courseReviewsPaging?[index].avatar ?? '',
                          imageBuilder: (context, imageProvider) => CircleAvatar(
                            radius: 22.0,
                            backgroundImage: imageProvider,
                          ),
                          progressIndicatorBuilder: (context, url, downloadProgress) => const SizedBox(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        )
                        : Container(
                          width: 44.0,
                          height: 44.0,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle
                          ),
                          child: Center(
                            child: Text(
                              getCharacterAvatar(courseReviewsPaging?[index].fullname ?? '').toUpperCase(), 
                              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white)
                            ),
                          ),
                        ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(courseReviewsPaging?[index].fullname ?? '', style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black)),
                            const SizedBox(height: 4.0),
                            Row(children: getListStarViewOfFive(courseReviewsPaging?[index].rating ?? 0.0)),
                            const SizedBox(height: 4.0),
                            Text(courseReviewsPaging?[index].comment ?? '', style: const TextStyle(fontSize: 15.0, color: Colors.black))
                          ],
                        ),
                      )
                    )
                  ],
                ), 
              ),
              (courseReviewsPaging?.length ?? 0) < (widget.courseReviews?.length ?? 0)
                ? GestureDetector(
                  onTap: () {
                    handlePressLoadMore();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0 + bottomPadding),
                    child: const Text(
                      'Xem thêm',
                      style: TextStyle(fontSize: 14.0, color: Colors.black54, decoration: TextDecoration.underline),
                    ),
                  ),
                )
                : Container()
            ],
          )
          : Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0 + bottomPadding),
            child: const Center(
              child: Text('Chưa có nhận xét của học viên!', style: TextStyle(fontSize: 14.0, color: Colors.black)),
            ),
          )
      ],
    );
  }

  void handlePressLoadMore() {
    setState(() {
      page += 1;
      courseReviewsPaging = (widget.courseReviews?.length ?? 0) > (page * pageSize) ? widget.courseReviews?.sublist(0, page * pageSize) : widget.courseReviews;
    });
  }

  void handlePressClearRateReview() {
    widget.courseReviewController.setStarFillNumber(0);
    widget.courseReviewController.reviewInputController.clear();
  }

  void handlePressSendRateReview(BuildContext context) async {
    try {
      await widget.courseReviewController.sendCourseReview(widget.idCourse, widget.courseReviewController.starFillNumber.value, widget.courseReviewController.reviewInputController.text);
      if (!(widget.courseReviewController.responseSend.value?.error ?? false)) {
        showSnackbar(SnackbarType.success, "Khóa học", "Gửi đánh giá thành công");
        widget.courseReviewController.fetchData(widget.idCourse);
      } else {
        if (widget.courseReviewController.responseSend.value?.code == ResponseCode.loginSession) {
          if (context.mounted) {
            showLoginSessionDialog(context);
          }
        } else {
          showSnackbar(SnackbarType.error, "Khóa học", widget.courseReviewController.responseSend.value?.message ?? "Gửi đánh giá không thành công");
        }
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Error", "Có lỗi xảy ra, vui lòng thử lại");
    }
  }

  List<Widget> starRateCourse(int starFillNumber) {
    List<Widget> starList = [];
    for(int i = 1; i <= 5; i++) {
      if (i <= starFillNumber) {
        starList.add(starRateItem(i, true));
      } else {
        starList.add(starRateItem(i, false));
      }
    }
    return starList;
  }

  Widget starRateItem(int index, bool fill) {
    return GestureDetector(
      onTap: () {
        widget.courseReviewController.setStarFillNumber(index);
      },
      child: Icon(fill ? CupertinoIcons.star_fill : CupertinoIcons.star, color: AppColors.starYellow, size: 30)
    );
  }
}