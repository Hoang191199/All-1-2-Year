import 'dart:io';

import 'package:get/get.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';

enum CourseComboType {
  courseCombo,
  filterKeyword,
  courseDetail,
  filterSlugFull
}

class CourseCombo implements APIRequestRepresentable {
  final CourseComboType type;
  int? idCourse;
  String? keyword;
  int? page;
  int? pageSize;
  String? slug;
  int? id;
  String? name;

  CourseCombo._({
    required this.type,
    this.idCourse,
    this.keyword,
    this.page,
    this.pageSize,
    this.slug,
    this.id,
    this.name
  });

  CourseCombo.fetchCoursesCombo(int page, int pageSize)
      : this._(
          type: CourseComboType.courseCombo,
          page: page,
          pageSize: pageSize,
        );
  CourseCombo.fetchCourseComboByKeyword(String keyword, int page, int pageSize)
      : this._(
            type: CourseComboType.filterKeyword,
            name: keyword,
            page: page,
            pageSize: pageSize);
  CourseCombo.getCourseComboDetail(int id, String slug)
      : this._(type: CourseComboType.courseDetail, id: id, slug: slug);
  CourseCombo.getCourseComboFullBySlug(String slug)
      : this._(type: CourseComboType.filterSlugFull, slug: slug);

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path {
    switch (type) {
      case CourseComboType.courseCombo:
        return "/course/restapi/coursepackage/list";
      case CourseComboType.filterKeyword:
        return "/course/restapi/coursepackage/list";
      case CourseComboType.filterSlugFull:
        return "/course/restapi/course/ListLesson";
      case CourseComboType.courseDetail:
        return "/course/restapi/coursepackage/get";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    switch (type) {
      default:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers {
    final authController = Get.find<AuthController>();
    String token = authController.token ?? '';
    switch (type) {
      case CourseComboType.courseCombo:
      case CourseComboType.filterKeyword:
      case CourseComboType.filterSlugFull:
      case CourseComboType.courseDetail:
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
      case CourseComboType.courseCombo:
        return {"page": "$page", "limit": "10"};
      case CourseComboType.filterSlugFull:
        return {"slug": '$slug'};
      case CourseComboType.courseDetail:
        return {"id": "$id", "slug": '$slug'};
      case CourseComboType.filterKeyword:
        return {
          "name": name ?? "",
          "page": "$page",
          "limit": "$pageSize"
        };
    }
  }

  @override
  get body {
    switch (type) {
      default:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
