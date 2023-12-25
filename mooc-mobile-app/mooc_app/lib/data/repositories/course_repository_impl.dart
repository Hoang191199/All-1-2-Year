import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/data/providers/network/apis/course_api.dart';
import 'package:mooc_app/domain/entities/complete_lesson_response_data.dart';
import 'package:mooc_app/domain/entities/coupon_code_response_data.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/course_paging.dart';
import 'package:mooc_app/domain/entities/course_review.dart';
import 'package:mooc_app/domain/entities/paid_course_details.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/entities/response_data_array_object.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class CourseRepositoryImpl extends CourseRepository {
  @override
  Future<CoursePaging> fetchCoursesByKeyword(String keyword, int page, int pageSize) async {
    final response = await CourseAPI.fetchCoursesByKeyword(keyword, page, pageSize).request();
    return CoursePaging.fromJson(response);
  }

  @override
  Future<CoursePaging> fetchCoursesByCategory(String category, int page, int pageSize) async {
    final response = await CourseAPI.fetchCoursesByCategory(category, page, pageSize).request();
    return CoursePaging.fromJson(response);
  }

  @override
  Future<CoursePaging> fetchCoursesIsSale(int page, int pageSize) async {
    final response = await CourseAPI.fetchCoursesIsSale(page, pageSize).request();
    return CoursePaging.fromJson(response);
  }

  @override
  Future<ResponseDataObject<Course>> getCourseFullByIdSlug(int idCourse, String slug) async {
    final response = await CourseAPI.getCourseFullByIdSlug(idCourse, slug).request();
    return ResponseDataObject<Course>.fromJson(response, (data) => Course.fromJson(data));
  }
  
  @override
  Future<CoursePaging> fetchCoursesRecommend(int page, int pageSize) async {
    final response = await CourseAPI.fetchCoursesRecommend(page, pageSize).request();
    return CoursePaging.fromJson(response);
  }

  @override
  Future<ResponseData> addFreeCourse(int idCourse) async {
    final response = await CourseAPI.addFreeCourse(idCourse).request();
    return ResponseData.fromJson(response, DataType.typeInt);
  }

  @override
  Future<ResponseData> addFreePackage(int idPackage) async {
    final response = await CourseAPI.addFreePackage(idPackage).request();
    return ResponseData.fromJson(response, DataType.typeInt);
  }
  
  @override
  Future<ResponseData> activeCourse(String activeCode) async {
    final response = await CourseAPI.activeCourse(activeCode).request();
    return ResponseData.fromJson(response, DataType.typeInt);
  }

  @override
  Future<ResponseDataObject<CompleteLessonResponseData>> completeLesson(int idLesson, int idCourse, int viewPercent) async {
    final response = await CourseAPI.completeLesson(idLesson, idCourse, viewPercent).request();
    return ResponseDataObject<CompleteLessonResponseData>.fromJson(response, (data) => CompleteLessonResponseData.fromJson(data));
  }

  @override
  Future<ResponseData> checkoutCourses(String fullname, String phone, String email, String paymentType, String address, List<int> idCourses, int idPackage, String couponCode) async {
    final response = await CourseAPI.checkoutCourses(fullname, phone, email, paymentType, address, idCourses, idPackage, couponCode).request();
    return ResponseData.fromJson(response, DataType.typeString);
  }

  @override
  Future<ResponseData> validateCheckout(String dataValidateCheckout) async {
    final response = await CourseAPI.validateCheckout(dataValidateCheckout).request();
    return ResponseData.fromJson(response, DataType.typeString);
  }

  @override
  Future<ResponseDataObject<CouponCodeResponseData>> applyCouponCode(String paymentType, String address, List<int> idCourses, int idPackage, String couponCode) async {
    final response = await CourseAPI.applyCouponCode(paymentType, address, idCourses, idPackage, couponCode).request();
    return ResponseDataObject<CouponCodeResponseData>.fromJson(response, (data) => CouponCodeResponseData.fromJson(data));
  }

  @override
  Future<ResponseDataObject<CourseReview>> getCourseReviewList(int idCourse) async {
    final response = await CourseAPI.getCourseReviewList(idCourse).request();
    return ResponseDataObject<CourseReview>.fromJson(response, (data) => CourseReview.fromJson(data));
  }

  @override
  Future<ResponseData> sendCourseReview(int idCourse, int rating, String comment) async {
    final response = await CourseAPI.sendCourseReview(idCourse, rating, comment).request();
    return ResponseData.fromJson(response, DataType.typeInt);
  }

  @override
  Future<ResponseDataArrayObject<Course>> fetchCoursesByIds(List<int> idCourse) async {
    final response = await CourseAPI.fetchCoursesByIds(idCourse).request();
    return ResponseDataArrayObject<Course>.fromJson(response, (data) => Course.fromJson(data));
  }

  @override
  Future<ResponseDataArrayObject<PaidCourseDetails>> fetchLearningCoursesList(int page, int pageSize) async {
    final response = await CourseAPI.fetchLearningCoursesList(page, pageSize).request();
    return ResponseDataArrayObject<PaidCourseDetails>.fromJson(response, (data) => PaidCourseDetails.fromJson(data));
  }
}
