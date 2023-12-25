import 'dart:io';

import 'package:get/get.dart';
import 'package:qltv/data/providers/network/api_endpoint.dart';
import 'package:qltv/data/providers/network/api_provider.dart';
import 'package:qltv/data/providers/network/api_request_representable.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';

enum BookcaseApiType { listBookcases, bookcasesLastseen, progressRead, listBookmarks, addBookmark, deleteBookmark, listHighlights, addHighlight, updateHighlight, deleteHighlight }

class BookcaseAPI implements APIRequestRepresentable {

  final loginController = Get.find<LoginController>();

  final BookcaseApiType type;
  int? current;
  int? pageSize;
  String? q;
  String? object_type;
  String? q_order;
  List<int>? q_read;
  int? item_id;
  int? progress;
  String? chapter;
  int? words_per_page;
  String? font_family;
  double? font_size_multiplier;
  int? page;
  int? inner_page;
  String? title;
  String? highlightText;
  String? description;
  String? color;
  int? startNodeIndex;
  int? endNodeIndex;
  int? startOffset;
  int? endOffset;
  String? content;

  BookcaseAPI._({
    required this.type,
    this.current,
    this.pageSize,
    this.q,
    this.object_type,
    this.q_order,
    this.q_read,
    this.item_id,
    this.progress,
    this.chapter,
    this.words_per_page,
    this.font_family,
    this.font_size_multiplier,
    this.page,
    this.inner_page,
    this.title,
    this.highlightText,
    this.description,
    this.color,
    this.startNodeIndex,
    this.endNodeIndex,
    this.startOffset,
    this.endOffset,
    this.content,
  });

  BookcaseAPI.getListBookcases(int current, int pageSize, String q, String object_type, String q_order, List<int> q_read)
    : this._(
      type: BookcaseApiType.listBookcases,
      current: current,
      q: q,
      pageSize: pageSize,
      object_type: object_type,
      q_order: q_order,
      q_read: q_read,
    );

  BookcaseAPI.getBookcasesLastseen()
    : this._(
      type: BookcaseApiType.bookcasesLastseen,
    );

  BookcaseAPI.sentProgressRead(int item_id, int progress, String chapter, int words_per_page, String font_family, double font_size_multiplier, int page, int inner_page)
    : this._(
      type: BookcaseApiType.progressRead,
      item_id: item_id,
      progress: progress,
      chapter: chapter,
      words_per_page: words_per_page,
      font_family: font_family,
      font_size_multiplier: font_size_multiplier,
      page: page,
      inner_page: inner_page,
    );

  BookcaseAPI.getListBookmarks(int item_id)
    : this._(
      type: BookcaseApiType.listBookmarks,
      item_id: item_id,
    );

  BookcaseAPI.addBookmark(int item_id, int page, int inner_page, String content)
    : this._(
      type: BookcaseApiType.addBookmark,
      item_id: item_id,
      page: page,
      inner_page: inner_page,
      content: content,
    );

  BookcaseAPI.deleteBookmark(int item_id)
    : this._(
      type: BookcaseApiType.deleteBookmark,
      item_id: item_id,
    );

  BookcaseAPI.getListHighlights(int item_id)
    : this._(
      type: BookcaseApiType.listHighlights,
      item_id: item_id,
    );

  BookcaseAPI.addHighlight(int item_id, String title, String highlightText, String description, String color, int page, int startNodeIndex, int endNodeIndex, int startOffset, int endOffset)
    : this._(
      type: BookcaseApiType.addHighlight,
      item_id: item_id,
      title: title,
      highlightText: highlightText,
      description: description,
      color: color,
      page: page,
      startNodeIndex: startNodeIndex,
      endNodeIndex: endNodeIndex,
      startOffset: startOffset,
      endOffset: endOffset,
    );

  BookcaseAPI.updateHighlight(int item_id, String title, String highlightText, String description, String color, int page, int startNodeIndex, int endNodeIndex, int startOffset, int endOffset)
    : this._(
      type: BookcaseApiType.updateHighlight,
      item_id: item_id,
      title: title,
      highlightText: highlightText,
      description: description,
      color: color,
      page: page,
      startNodeIndex: startNodeIndex,
      endNodeIndex: endNodeIndex,
      startOffset: startOffset,
      endOffset: endOffset,
    );

  BookcaseAPI.deleteHighlight(int item_id)
    : this._(
      type: BookcaseApiType.deleteHighlight,
      item_id: item_id,
    );

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path {
    final siteId = loginController.userLogin?.default_site_id;
    switch (type) {
      case BookcaseApiType.listBookcases:
        return '/$siteId/bookcase';
      case BookcaseApiType.bookcasesLastseen:
        return '/$siteId/bookcase/lastseen';
      case BookcaseApiType.progressRead:
        return '/$siteId/bookcase/progress_read/$item_id';
      case BookcaseApiType.listBookmarks:
        return '/$siteId/interactives/list';
      case BookcaseApiType.addBookmark:
        return '/$siteId/interactives';
      case BookcaseApiType.updateHighlight:
        return '/$siteId/highlight';
      case BookcaseApiType.deleteBookmark:
        return '/$siteId/interactives/$item_id';
      case BookcaseApiType.listHighlights:
        return '/$siteId/interactives/list';
      case BookcaseApiType.addHighlight:
        return '/$siteId/interactives';
      case BookcaseApiType.deleteHighlight:
        return '/$siteId/interactives/$item_id';
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
      case BookcaseApiType.progressRead:
      case BookcaseApiType.addBookmark:
      case BookcaseApiType.addHighlight:
        return HTTPMethod.post;
      case BookcaseApiType.updateHighlight:
        return HTTPMethod.put;
      case BookcaseApiType.deleteBookmark:
      case BookcaseApiType.deleteHighlight:
        return HTTPMethod.delete;
      default:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers {
    String accessToken = loginController.accessToken ?? '';
    if (accessToken.isNotEmpty) {
      return {HttpHeaders.authorizationHeader: 'Bearer $accessToken'};
    }
    return {};
  }

  @override
  Map<String, String>? get query {
    switch (type) {
      case BookcaseApiType.listBookcases:
        var params = {'current': '$current', 'pageSize': '$pageSize', 'q': '$q', 'object_type': '$object_type', 'q_order': '$q_order'};
        if (q_read?.length != 3) {
          params['q_read'] = '$q_read';
        }
        return params;
      case BookcaseApiType.listBookmarks:
        final userId = loginController.userLogin?.id;
        return {'type': 'bookmark', 'user_id': '$userId', 'item_id': '$item_id'};
      case BookcaseApiType.listHighlights:
        final userId = loginController.userLogin?.id;
        return {'type': 'highlight', 'user_id': '$userId', 'item_id': '$item_id'};
      case BookcaseApiType.progressRead:
      case BookcaseApiType.addBookmark:
      case BookcaseApiType.deleteBookmark:
      case BookcaseApiType.addHighlight:
      case BookcaseApiType.updateHighlight:
      case BookcaseApiType.deleteHighlight:
        return null;
      default:
        return {};
    }
  }

  @override
  get body {
    switch (type) {
      case BookcaseApiType.progressRead:
        return {'item_id': item_id, 'progress': progress, 'chapter': chapter, 'words_per_page': words_per_page, 'font_family': font_family, 'font_size_multiplier': font_size_multiplier, 'page': page, 'inner_page': inner_page};
      case BookcaseApiType.addBookmark:
        return {'item_id': item_id, 'type': 'bookmark', 'metadata': {'page': page, 'inner_page': inner_page, 'content': content}};
      case BookcaseApiType.addHighlight:
        return {'item_id': item_id, 'type': 'highlight', 'metadata': {'title': title, 'highlightText': highlightText, 'description': description, 'color': color, 'page': page, 'startNodeIndex': startNodeIndex, 'endNodeIndex': endNodeIndex, 'startOffset': startOffset, 'endOffset': endOffset}};
      case BookcaseApiType.updateHighlight:
        return {'id': item_id, 'metadata': {'title': title, 'highlightText': highlightText, 'description': description, 'color': color, 'page': page, 'startNodeIndex': startNodeIndex, 'endNodeIndex': endNodeIndex, 'startOffset': startOffset, 'endOffset': endOffset}};
      default:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}