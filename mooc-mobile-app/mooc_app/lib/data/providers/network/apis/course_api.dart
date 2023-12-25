import 'dart:io';

import 'package:get/get.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';

enum CourseType { filterKeyword, filterCategory, filterIdSlugFull, recommend, saleOff, addFreeCourse, addFreePackage, activeCourse, completeLesson, checkoutCourses, validateCheckout, applyCouponCode, courseReviewList, sendCourseReview, filterIds, learningCourses }

class CourseAPI implements APIRequestRepresentable {
  final CourseType type;
  int? idCourse;
  String? keyword;
  String? category;
  String? slug;
  int? page;
  int? pageSize;
  String? activeCode;
  int? idLesson;
  int? viewPercent;
  String? fullname;
  String? phone;
  String? email;
  String? paymentType;
  String? address;
  List<int>? idCourses;
  int? idPackage;
  String? couponCode;
  String? dataValidateCheckout;
  int? rating;
  String? comment;

  CourseAPI._({
    required this.type,
    this.idCourse,
    this.keyword,
    this.category,
    this.slug,
    this.page,
    this.pageSize,
    this.activeCode,
    this.idLesson,
    this.viewPercent,
    this.fullname,
    this.phone,
    this.email,
    this.paymentType,
    this.address,
    this.idCourses,
    this.idPackage,
    this.couponCode,
    this.dataValidateCheckout,
    this.rating,
    this.comment,
  });

  CourseAPI.fetchCoursesByKeyword(String keyword, int page, int pageSize)
      : this._(
            type: CourseType.filterKeyword,
            keyword: keyword,
            page: page,
            pageSize: pageSize);

  CourseAPI.fetchCoursesByCategory(String category, int page, int pageSize)
      : this._(
            type: CourseType.filterCategory,
            category: category,
            page: page,
            pageSize: pageSize);

  CourseAPI.fetchCoursesIsSale(int page, int pageSize)
      : this._(
            type: CourseType.saleOff,
            page: page,
            pageSize: pageSize);
  
  CourseAPI.getCourseFullByIdSlug(int idCourse, String slug)
      : this._(type: CourseType.filterIdSlugFull, idCourse: idCourse, slug: slug);

  CourseAPI.fetchCoursesRecommend(int page, int pageSize)
      : this._(
            type: CourseType.recommend, 
            page: page,
            pageSize: pageSize);

  CourseAPI.addFreeCourse(int idCourse)
      : this._(
            type: CourseType.addFreeCourse, 
            idCourse: idCourse);

  CourseAPI.addFreePackage(int idPackage)
      : this._(
            type: CourseType.addFreePackage, 
            idPackage: idPackage);

  CourseAPI.activeCourse(String activeCode)
      : this._(
            type: CourseType.activeCourse, 
            activeCode: activeCode);

  CourseAPI.completeLesson(int idLesson, int idCourse, int viewPercent)
      : this._(
            type: CourseType.completeLesson, 
            idLesson: idLesson,
            idCourse: idCourse,
            viewPercent: viewPercent);

  CourseAPI.checkoutCourses(String fullname, String phone, String email, String paymentType, String address, List<int> idCourses, int idPackage, String couponCode)
      : this._(
            type: CourseType.checkoutCourses, 
            fullname: fullname,
            phone: phone,
            email: email,
            paymentType: paymentType,
            address: address,
            idCourses: idCourses,
            idPackage: idPackage,
            couponCode: couponCode);
  
  CourseAPI.validateCheckout(String dataValidateCheckout)
      : this._(type: CourseType.validateCheckout,
            dataValidateCheckout: dataValidateCheckout);

  CourseAPI.applyCouponCode(String paymentType, String address, List<int> idCourses, int idPackage, String couponCode)
      : this._(
            type: CourseType.applyCouponCode,
            paymentType: paymentType,
            address: address,
            idCourses: idCourses,
            idPackage: idPackage,
            couponCode: couponCode);
  
  CourseAPI.getCourseReviewList(int idCourse)
      : this._(type: CourseType.courseReviewList, idCourse: idCourse);

  CourseAPI.sendCourseReview(int idCourse, int rating, String comment)
      : this._(
            type: CourseType.sendCourseReview, 
            idCourse: idCourse,
            rating: rating,
            comment: comment);

  CourseAPI.fetchCoursesByIds(List<int> idCourses)
      : this._(type: CourseType.filterIds,
            idCourses: idCourses);

  CourseAPI.fetchLearningCoursesList(int page, int pageSize)
      : this._(
            type: CourseType.learningCourses,
            page: page,
            pageSize: pageSize);

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path {
    switch (type) {
      case CourseType.filterKeyword:
        return "/course/restapi/course/list";
      case CourseType.filterCategory:
        return "/course/restapi/course/list";
      case CourseType.saleOff:
        return "/course/restapi/course/list";
      case CourseType.filterIdSlugFull:
        return "/course/restapi/course/ListLesson";
      case CourseType.recommend:
        return "/course/restapi/course/ListRecommend";
      case CourseType.addFreeCourse:
        return "/course/restapi/course/addfreecourse";
      case CourseType.addFreePackage:
        return "/course/restapi/coursepackage/addfreepackage";
      case CourseType.activeCourse:
        return "/course/ActiveCode/ActiveCode";
      case CourseType.completeLesson:
        return "/course/course/completelesson";
      case CourseType.checkoutCourses:
        return "/course/restapi/order/mooccheckout";
      case CourseType.validateCheckout:
        return "/course/restapi/order/validatecheckout";
      case CourseType.applyCouponCode:
        return "/course/restapi/order/applycouponcode";
      case CourseType.courseReviewList:
        return "/course/course/getreviewcourse";
      case CourseType.sendCourseReview:
        return "/course/coursereview/sendreview";
      case CourseType.filterIds:
        return "/course/restapi/course/ListCoursesByIds";
      case CourseType.learningCourses:
        return "/course/course/liststudent";
    }
  }

  @override
  String get url {
    switch (type) {
      case CourseType.filterIds:
      var paramStr = '';
        if (idCourses?.isNotEmpty ?? false) {
          for (var i = 0; i < (idCourses?.length ?? 0); i++) {
            if (i == 0) {
              paramStr += '?ids=${idCourses?[i]}';
            } else {
              paramStr += '&ids=${idCourses?[i]}';
            }
          }
        }
        return endpoint + path + paramStr;
      default:
        return endpoint + path;
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case CourseType.addFreeCourse:
      case CourseType.addFreePackage:
      case CourseType.activeCourse:
      case CourseType.completeLesson:
      case CourseType.checkoutCourses:
      case CourseType.applyCouponCode:
      case CourseType.sendCourseReview:
        return HTTPMethod.post;
      default:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers {
    final authController = Get.find<AuthController>();
    String token = authController.token ?? '';
    print({'token', token});
    switch (type) {
      case CourseType.filterIdSlugFull:
      case CourseType.addFreeCourse:
      case CourseType.addFreePackage:
      case CourseType.activeCourse:
      case CourseType.completeLesson:
      case CourseType.checkoutCourses:
      case CourseType.validateCheckout:
      case CourseType.applyCouponCode:
      case CourseType.courseReviewList:
      case CourseType.sendCourseReview:
      case CourseType.learningCourses:
        if (token.isNotEmpty) {
          return {HttpHeaders.authorizationHeader: 'Bearer $token'};
        }
        return {};
      default:
        return {};
    }
  }

  @override
  Map<String, String>? get query {
    switch (type) {
      case CourseType.filterKeyword:
        return {"keyword": keyword ?? "", "page": "$page", "limit": "$pageSize"};
      case CourseType.filterCategory:
        return {"category": category ?? "", "page": "$page", "limit": "$pageSize"};
      case CourseType.saleOff:
        return {"isSale": "true", "page": "$page", "limit": "$pageSize"};
      case CourseType.filterIdSlugFull:
        return {"id": "$idCourse", "slug": '$slug'};
      case CourseType.recommend:
        return {"page": "$page", "limit": "$pageSize"};
      case CourseType.validateCheckout:
        return {"data": '$dataValidateCheckout'};
      case CourseType.courseReviewList:
        return {"idCourse": '$idCourse'};
      case CourseType.learningCourses:
        return {"page": "$page", "per_page": "$pageSize"};
      case CourseType.filterIds:
      case CourseType.addFreeCourse:
      case CourseType.addFreePackage:
      case CourseType.activeCourse:
      case CourseType.completeLesson:
      case CourseType.checkoutCourses:
      case CourseType.applyCouponCode:
      case CourseType.sendCourseReview:
        return null;
    }
  }

  @override
  get body {
    switch (type) {
      case CourseType.addFreeCourse:
        return {"id": idCourse};
      case CourseType.addFreePackage:
        return {"id": idPackage};
      case CourseType.activeCourse:
        return {"activeCode": activeCode};
      case CourseType.completeLesson:
        return {"idLesson": idLesson, "idCourse": idCourse, "viewPercent": viewPercent};
      case CourseType.checkoutCourses:
        return {"fullname": fullname, "phone": phone, "email": email, "paymentType": paymentType, "address": address, "idCourses": idCourses, "idPackage": idPackage, "couponCode": couponCode};
      case CourseType.applyCouponCode:
        return {"paymentType": paymentType, "address": address, "idCourses": idCourses, "idPackage": idPackage, "couponCode": couponCode, "isTestPayment": true};
      case CourseType.sendCourseReview:
        return {"idCourse": idCourse, "rating": rating, "comment": comment};
      default:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
