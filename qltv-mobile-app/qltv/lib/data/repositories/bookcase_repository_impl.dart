import 'package:qltv/data/providers/network/apis/bookcase_api.dart';
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/domain/entities/bookmark.dart';
import 'package:qltv/domain/entities/highlight.dart';
import 'package:qltv/domain/entities/response_data_array_object.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/bookcase_repository.dart';

class BookcaseRepositoryImpl extends BookcaseRepository {

  @override
  Future<ResponseDataArrayObject<Bookcase>> getListBookcases(int current, int pageSize, String q, String object_type, String q_order, List<int> q_read) async {
    final response = await BookcaseAPI.getListBookcases(current, pageSize, q, object_type, q_order, q_read).request();
    return ResponseDataArrayObject<Bookcase>.fromJson(response, (data) => Bookcase.fromJson(data));
  }
  
  @override
  Future<ResponseDataArrayObject<Bookcase>> getBookcasesLastseen() async {
    final response = await BookcaseAPI.getBookcasesLastseen().request();
    return ResponseDataArrayObject<Bookcase>.fromJson(response, (data) => Bookcase.fromJson(data));
  }

  @override
  Future<ResponseNoData> sentProgressRead(int item_id, int progress, String chapter, int words_per_page, String font_family, double font_size_multiplier, int page, int inner_page) async {
    final response = await BookcaseAPI.sentProgressRead(item_id, progress, chapter, words_per_page, font_family, font_size_multiplier, page, inner_page).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataArrayObject<Bookmark>> getListBookmarks(int item_id) async {
    final response = await BookcaseAPI.getListBookmarks(item_id).request();
    return ResponseDataArrayObject<Bookmark>.fromJson(response, (data) => Bookmark.fromJson(data));
  }

  @override
  Future<ResponseNoData> addBookmark(int item_id, int page, int inner_page, String content) async {
    final response = await BookcaseAPI.addBookmark(item_id, page, inner_page, content).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> deleteBookmark(int item_id) async {
    final response = await BookcaseAPI.deleteBookmark(item_id).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataArrayObject<Highlight>> getListHighlights(int item_id) async {
    final response = await BookcaseAPI.getListHighlights(item_id).request();
    return ResponseDataArrayObject<Highlight>.fromJson(response, (data) => Highlight.fromJson(data));
  }

  @override
  Future<ResponseNoData> addHighlight(int item_id, String title, String highlightText, String description, String color, int page, int startNodeIndex, int endNodeIndex, int startOffset, int endOffset) async {
    final response = await BookcaseAPI.addHighlight(item_id, title, highlightText, description, color, page, startNodeIndex, endNodeIndex, startOffset, endOffset).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> updateHighlight(int id, String title, String highlightText, String description, String color, int page, int startNodeIndex, int endNodeIndex, int startOffset, int endOffset) async {
    final response = await BookcaseAPI.updateHighlight(id, title, highlightText, description, color, page, startNodeIndex, endNodeIndex, startOffset, endOffset).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> deleteHighlight(int item_id) async {
    final response = await BookcaseAPI.deleteHighlight(item_id).request();
    return ResponseNoData.fromJson(response);
  }
  
}