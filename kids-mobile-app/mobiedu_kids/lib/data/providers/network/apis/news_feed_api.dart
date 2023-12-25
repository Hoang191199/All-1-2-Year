import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum NewsFeedApiType { getPageGroupJoined, getNewsFeed, showPage, showGroup, homePage, getPost, getSavedPosts, createComment, search, searchDetail, contactSchool, createReview }

class NewsFeedAPI implements APIRequestRepresentable {

  final store = Get.find<LocalStorageService>();

  final NewsFeedApiType type;
  int? page;
  String? action;
  String? id;
  String? username;
  String? message;
  Uint8List? file;
  String? queryStr;
  String? typeQuery;
  String? view;
  String? schoolId;
  String? name;
  String? phone;
  String? content;
  String? typeRate;
  int? numberRate;

  NewsFeedAPI._({
    required this.type,
    this.page,
    this.action,
    this.id,
    this.username,
    this.message,
    this.file,
    this.queryStr,
    this.typeQuery,
    this.view,
    this.schoolId,
    this.name,
    this.phone,
    this.content,
    this.typeRate,
    this.numberRate,
  });

  NewsFeedAPI.getPageGroupJoined()
    : this._(
      type: NewsFeedApiType.getPageGroupJoined,
    );
  
  NewsFeedAPI.getNewsFeed(int page)
    : this._(
      type: NewsFeedApiType.getNewsFeed,
      page: page,
    );

  NewsFeedAPI.showPage(String username, int? page, String view)
    : this._(
      type: NewsFeedApiType.showPage,
      username: username,
      page: page,
      view: view,
    );

  NewsFeedAPI.showGroup(String username, int? page, String view)
    : this._(
      type: NewsFeedApiType.showGroup,
      username: username,
      page: page,
      view: view,
    );

  NewsFeedAPI.homePage(String username, int? page, String view)
    : this._(
      type: NewsFeedApiType.homePage,
      username: username,
      page: page,
      view: view,
    );

  NewsFeedAPI.getPost(String id, int page)
    : this._(
      type: NewsFeedApiType.getPost,
      id: id,
      page: page,
    );

  NewsFeedAPI.getSavedPosts(int page)
    : this._(
      type: NewsFeedApiType.getSavedPosts,
      page: page,
    );

  NewsFeedAPI.createComment(String action, String id, String? message, Uint8List? file)
    : this._(
      type: NewsFeedApiType.createComment,
      action: action,
      id: id,
      message: message,
      file: file,
    );

  NewsFeedAPI.search(String queryStr)
    : this._(
      type: NewsFeedApiType.search,
      queryStr: queryStr,
    );

  NewsFeedAPI.searchDetail(String queryStr, String typeQuery, int page, String? id)
    : this._(
      type: NewsFeedApiType.searchDetail,
      queryStr: queryStr,
      typeQuery: typeQuery,
      page: page,
      id: id,
    );

  NewsFeedAPI.contactSchool(String schoolId, String name, String phone, String content)
    : this._(
      type: NewsFeedApiType.contactSchool,
      schoolId: schoolId,
      name: name,
      phone: phone,
      content: content,
    );

  NewsFeedAPI.createReview(String typeRate, String schoolId, int numberRate, String content)
    : this._(
      type: NewsFeedApiType.createReview,
      typeRate: typeRate,
      schoolId: schoolId,
      numberRate: numberRate,
      content: content,
    );

  @override
  String get endpoint => APIEndpoint.endpoint;
  
  @override
  String get path {
    switch (type) {
      case NewsFeedApiType.getPageGroupJoined:
        return '/getPageGroupJoined';
      case NewsFeedApiType.getNewsFeed:
        return '/newsFeed';
      case NewsFeedApiType.showPage:
        return '/showPage';
      case NewsFeedApiType.showGroup:
        return '/showGroup';
      case NewsFeedApiType.homePage:
        return '/homePage';
      case NewsFeedApiType.getPost:
        return '/getPost';
      case NewsFeedApiType.getSavedPosts:
        return '/getSavedPosts';
      case NewsFeedApiType.createComment:
        return '/createComment';
      case NewsFeedApiType.search:
        return '/search';
      case NewsFeedApiType.searchDetail:
        return '/searchDetail';
      case NewsFeedApiType.contactSchool:
        return '/contactSchool';
      case NewsFeedApiType.createReview:
        return '/createReview';
      default: 
        return '';
    }
  }

  @override
  String get url {
    switch (type) {
      default:
        return endpoint + path;
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      default:
        return HTTPMethod.post;
    }
  }

   @override
  Map<String, String> get headers {
    return {};
  }

  @override
  Map<String, String>? get query {
    switch (type) {
      default:
        return {};
    }
  }

  @override
  FormData get form {
    final userToken = store.userFromStorage?.user_token;
    final userId = store.userFromStorage?.user_id;
    switch (type) {
      case NewsFeedApiType.getPageGroupJoined:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
        });
      case NewsFeedApiType.getNewsFeed:
      case NewsFeedApiType.getSavedPosts:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'page': '$page',
        });
      case NewsFeedApiType.showPage:
      case NewsFeedApiType.showGroup:
      case NewsFeedApiType.homePage:
        var data = {
          'user_token': userToken,
          'user_id': userId,
          'username': username,
          'view': view,
        };
        if (page != null) {
          data['page'] = '$page';
        }
        return FormData(data);
      case NewsFeedApiType.getPost:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'post_id': id,
          'page': '$page',
        });
      case NewsFeedApiType.createComment:
        var data = {
          'user_token': userToken,
          'user_id': userId,
          'handle': action,
          'id': id,
          'message': message,
          'photo': (file != null && (file?.isNotEmpty ?? false)) ? MultipartFile(file, filename: 'image.jpg') : null
        };
        return FormData(data);
      case NewsFeedApiType.search:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'query': queryStr,
        });
      case NewsFeedApiType.searchDetail:
        var data = {
          'user_token': userToken,
          'user_id': userId,
          'query': queryStr,
          'type': typeQuery,
          'page': '$page',
        };
        if (id != null) {
          data['id'] = id;
        }
        return FormData(data);
      case NewsFeedApiType.contactSchool:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'school_id': schoolId,
          'name': name,
          'phone': phone,
          'content': content,
        });
      case NewsFeedApiType.createReview:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'type': typeRate,
          'school_id[0]': schoolId,
          'rating[0]': '$numberRate',
          'comment[0]': content,
        });
    }
  }

  @override
  get body => form;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}