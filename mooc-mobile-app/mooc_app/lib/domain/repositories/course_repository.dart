import 'package:mooc_app/domain/entities/complete_lesson_response_data.dart';
import 'package:mooc_app/domain/entities/coupon_code_response_data.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/course_paging.dart';
import 'package:mooc_app/domain/entities/course_review.dart';
import 'package:mooc_app/domain/entities/paid_course_details.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/entities/response_data_array_object.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';

abstract class CourseRepository {
  Future<CoursePaging> fetchCoursesByKeyword(String keyword, int page, int pageSize);
  Future<CoursePaging> fetchCoursesByCategory(String category, int page, int pageSize);
  Future<CoursePaging> fetchCoursesIsSale(int page, int pageSize);
  Future<ResponseDataObject<Course>> getCourseFullByIdSlug(int idCourse, String slug);
  Future<CoursePaging> fetchCoursesRecommend(int page, int pageSize);
  Future<ResponseData> addFreeCourse(int idCourse);
  Future<ResponseData> addFreePackage(int idPackage);
  Future<ResponseData> activeCourse(String activeCode);
  Future<ResponseDataObject<CompleteLessonResponseData>> completeLesson(int idLesson, int idCourse, int viewPercent);
  Future<ResponseData> checkoutCourses(String fullname, String phone, String email, String paymentType, String address, List<int> idCourses, int idPackage, String couponCode);
  Future<ResponseData> validateCheckout(String dataValidateCheckout);
  Future<ResponseDataObject<CouponCodeResponseData>> applyCouponCode(String paymentType, String address, List<int> idCourses, int idPackage, String couponCode);
  Future<ResponseDataObject<CourseReview>> getCourseReviewList(int idCourse);
  Future<ResponseData> sendCourseReview(int idCourse, int rating, String comment);
  Future<ResponseDataArrayObject<Course>> fetchCoursesByIds(List<int> idCourse);
  Future<ResponseDataArrayObject<PaidCourseDetails>> fetchLearningCoursesList(int page, int pageSize);
}