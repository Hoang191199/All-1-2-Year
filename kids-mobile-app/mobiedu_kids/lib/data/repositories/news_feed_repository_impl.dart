import 'dart:typed_data';

import 'package:mobiedu_kids/data/providers/network/apis/news_feed_api.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_home_page.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_news_feed.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_search_news_feed.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_show_page_group.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_group.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/response_post.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/news_feed_repository.dart';

class NewsFeedRepositoryImpl extends NewsFeedRepository {

  @override
  Future<ResponseDataObject<PageGroup>> getPageGroupJoined() async {
    final response = await NewsFeedAPI.getPageGroupJoined().request();
    return ResponseDataObject<PageGroup>.fromJson(response, (data) => PageGroup.fromJson(data));
  }

  @override
  Future<ResponseDataObject<DataNewsFeed>> getNewsFeed(int page) async {
    final response = await NewsFeedAPI.getNewsFeed(page).request();
    return ResponseDataObject<DataNewsFeed>.fromJson(response, (data) => DataNewsFeed.fromJson(data));
  }

  @override
  Future<ResponseDataObject<DataShowPageGroup>> showPage(String username, int? page, String view) async {
    final response = await NewsFeedAPI.showPage(username, page, view).request();
    return ResponseDataObject<DataShowPageGroup>.fromJson(response, (data) => DataShowPageGroup.fromJson(data));
  }

  @override
  Future<ResponsePost> getPost(String postId, int page) async {
    final response = await NewsFeedAPI.getPost(postId, page).request();
    return ResponsePost.fromJson(response);
  }

  @override
  Future<ResponseNoData> createComment(String action, String id, String message, Uint8List file) async {
    final response = await NewsFeedAPI.createComment(action, id, message, file).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<DataSearchNewsFeed>> search(String queryStr) async {
    final response = await NewsFeedAPI.search(queryStr).request();
    return ResponseDataObject<DataSearchNewsFeed>.fromJson(response, (data) => DataSearchNewsFeed.fromJson(data));
  }

  @override
  Future<ResponseDataObject<DataSearchNewsFeed>> searchDetail(String queryStr, String typeQuery, int page, String? id) async {
    final response = await NewsFeedAPI.searchDetail(queryStr, typeQuery, page, id).request();
    return ResponseDataObject<DataSearchNewsFeed>.fromJson(response, (data) => DataSearchNewsFeed.fromJson(data));
  }

  @override
  Future<ResponseNoData> contactSchool(String schoolId, String name, String phone, String content) async {
    final response = await NewsFeedAPI.contactSchool(schoolId, name, phone, content).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<DataShowPageGroup>> showGroup(String username, int? page, String view) async {
    final response = await NewsFeedAPI.showGroup(username, page, view).request();
    return ResponseDataObject<DataShowPageGroup>.fromJson(response, (data) => DataShowPageGroup.fromJson(data));
  }

  @override
  Future<ResponseDataObject<DataHomePage>> homePage(String username, int? page, String view) async {
    final response = await NewsFeedAPI.homePage(username, page, view).request();
    return ResponseDataObject<DataHomePage>.fromJson(response, (data) => DataHomePage.fromJson(data));
  }

  @override
  Future<ResponseDataObject<DataNewsFeed>> getSavedPosts(int page) async {
    final response = await NewsFeedAPI.getSavedPosts(page).request();
    return ResponseDataObject<DataNewsFeed>.fromJson(response, (data) => DataNewsFeed.fromJson(data));
  }

  @override
  Future<ResponseNoData> createReview(String typeRate, String schoolId, int numberRate, String content) async {
    final response = await NewsFeedAPI.createReview(typeRate, schoolId, numberRate, content).request();
    return ResponseNoData.fromJson(response);
  }
  
}