import 'dart:typed_data';

import 'package:mobiedu_kids/domain/entities/news_feed/data_home_page.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_news_feed.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_search_news_feed.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_show_page_group.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_group.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/response_post.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';

abstract class NewsFeedRepository {
  Future<ResponseDataObject<PageGroup>> getPageGroupJoined();

  Future<ResponseDataObject<DataNewsFeed>> getNewsFeed(int page);

  Future<ResponseDataObject<DataShowPageGroup>> showPage(String username, int? page, String view);

  Future<ResponsePost> getPost(String postId, int page);

  Future<ResponseNoData> createComment(String action, String id, String message, Uint8List file);

  Future<ResponseDataObject<DataSearchNewsFeed>> search(String queryStr);

  Future<ResponseDataObject<DataSearchNewsFeed>> searchDetail(String queryStr, String typeQuery, int page, String? id);

  Future<ResponseNoData> contactSchool(String schoolId, String name, String phone, String content);

  Future<ResponseDataObject<DataShowPageGroup>> showGroup(String username, int? page, String view);

  Future<ResponseDataObject<DataHomePage>> homePage(String username, int? page, String view);

  Future<ResponseDataObject<DataNewsFeed>> getSavedPosts(int page);

  Future<ResponseNoData> createReview(String typeRate, String schoolId, int numberRate, String content);
}