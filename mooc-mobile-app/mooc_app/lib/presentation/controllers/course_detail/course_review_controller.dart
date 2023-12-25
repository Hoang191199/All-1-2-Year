import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/course_review.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/usecases/course_review_list_use_case.dart';
import 'package:mooc_app/domain/usecases/course_review_use_case.dart';

class CourseReviewController extends GetxController {
  CourseReviewController(
    this.courseReviewListUseCase,
    this.courseReviewUseCase
  );

  final CourseReviewListUseCase courseReviewListUseCase;
  final CourseReviewUseCase courseReviewUseCase;

  final reviewInputController = TextEditingController();

  final isLoading = false.obs;
  var reponseCourseReviewList = Rx<ResponseDataObject<CourseReview>?>(null);
  var courseReviewData = Rx<CourseReview?>(null);
  final starFillNumber = 0.obs;
  var responseSend = Rx<ResponseData?>(null);
  
  fetchData(int idCourse) async {
    isLoading(true);
    await Future.delayed(const Duration(milliseconds: 200));
    final dataResponse = await courseReviewListUseCase.execute(idCourse);
    reponseCourseReviewList.value = dataResponse;
    courseReviewData.value = dataResponse.data;
    isLoading(false);
  }

  setStarFillNumber(int numStar) {
    starFillNumber.value = numStar;
  }

  sendCourseReview(int idCourse, int rating, String comment) async {
    isLoading(true);
    final response = await courseReviewUseCase.execute(Tuple3(idCourse, rating, comment));
    responseSend.value = response;
    isLoading(false);
  }
}