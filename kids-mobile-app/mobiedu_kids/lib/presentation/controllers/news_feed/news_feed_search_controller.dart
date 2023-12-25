import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_search_news_feed.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/group_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/user.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/news_feed_search_detail_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/news_feed_search_use_case.dart';

import '../../../domain/entities/response_data_object.dart';

class NewsFeedSearchController extends GetxController {
  NewsFeedSearchController(
    this.newsFeedSearchUseCase,
    this.newsFeedSearchDetailUseCase,
  );

  final NewsFeedSearchUseCase newsFeedSearchUseCase;
  final NewsFeedSearchDetailUseCase newsFeedSearchDetailUseCase;

  final isLoadingSearchNewsFeed = false.obs;
  final isLoadingSearchDetail = false.obs;
  final isLoadMore = false.obs;
  final isSearch = false.obs;
  final canLoadMore = true.obs;
  var searchTextEditingController = TextEditingController(text: '');
  var searchDetailTextEditingController = TextEditingController(text: '');
  var responseSearchNewsFeed = Rx<ResponseDataObject<DataSearchNewsFeed>?>(null);
  var searchPostData = RxList<PostNews>([]);
  var searchUserData = RxList<User>([]);
  var searchPageData = RxList<PageJoin>([]);
  var searchGroupData = RxList<GroupJoin>([]);

  var searchDetailPostData = RxList<PostNews>([]);
  var searchDetailUserData = RxList<User>([]);
  var searchDetailPageData = RxList<PageJoin>([]);
  var searchDetailGroupData = RxList<GroupJoin>([]);
  int page = 0;

  searchNewsFeed(String queryStr) async {
    isSearch(true);
    isLoadingSearchNewsFeed(true);
    searchPostData.value = [];
    searchUserData.value = [];
    searchPageData.value = [];
    searchGroupData.value = [];
    canLoadMore(true);
    final response = await newsFeedSearchUseCase.execute(queryStr);
    responseSearchNewsFeed.value = response;
    searchPostData.assignAll(response.data?.posts ?? []);
    searchUserData.assignAll(response.data?.users ?? []);
    searchPageData.assignAll(response.data?.pages ?? []);
    searchGroupData.assignAll(response.data?.groups ?? []);
    isLoadingSearchNewsFeed(false);
  }

  searchDetailNewsFeed(String queryStr, String typeQuery, String? id) async {
    isLoadingSearchDetail(true);
    page = 0;
    searchDetailPostData.value = [];
    searchDetailUserData.value = [];
    searchDetailPageData.value = [];
    searchDetailGroupData.value = [];
    final response = await newsFeedSearchDetailUseCase.execute(Tuple4(queryStr, typeQuery, page, id));
    responseSearchNewsFeed.value = response;
    searchDetailPostData.assignAll(response.data?.posts ?? []);
    searchDetailUserData.assignAll(response.data?.users ?? []);
    searchDetailPageData.assignAll(response.data?.pages ?? []);
    searchDetailGroupData.assignAll(response.data?.groups ?? []);
    isLoadingSearchDetail(false);
  }

  searchDetailNewsFeedMore(String queryStr, String typeQuery, String? id) async {
    if (isLoadMore.value) return;
    isLoadMore(true);
    page += 1;
    final response = await newsFeedSearchDetailUseCase.execute(Tuple4(queryStr, typeQuery, page, id));
    responseSearchNewsFeed.value = response;
    if (response.code == 200) {
      canLoadMore(true);
      if (
        (response.data?.posts?.isNotEmpty ?? false) 
        || (response.data?.groups?.isNotEmpty ?? false)
        || (response.data?.pages?.isNotEmpty ?? false)
        || (response.data?.users?.isNotEmpty ?? false)
      ) {
        searchDetailPostData.addAll(response.data?.posts ?? []);
        searchDetailUserData.addAll(response.data?.users ?? []);
        searchDetailPageData.addAll(response.data?.pages ?? []);
        searchDetailGroupData.addAll(response.data?.groups ?? []);
      } else {
        canLoadMore(false);
      }
    } else {
      page -= 1;
      canLoadMore(false);
    }
    isLoadMore(false);
  }
}