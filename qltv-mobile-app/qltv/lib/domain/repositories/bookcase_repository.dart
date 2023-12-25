import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/domain/entities/bookmark.dart';
import 'package:qltv/domain/entities/highlight.dart';
import 'package:qltv/domain/entities/response_data_array_object.dart';
import 'package:qltv/domain/entities/response_no_date.dart';

abstract class BookcaseRepository {
  Future<ResponseDataArrayObject<Bookcase>> getListBookcases(int current, int pageSize, String q, String object_type, String q_order, List<int> q_read);

  Future<ResponseDataArrayObject<Bookcase>> getBookcasesLastseen();

  Future<ResponseNoData> sentProgressRead(int item_id, int progress, String chapter, int words_per_page, String font_family, double font_size_multiplier, int page, int inner_page);

  Future<ResponseDataArrayObject<Bookmark>> getListBookmarks(int item_id);

  Future<ResponseNoData> addBookmark(int item_id, int page, int inner_page, String content);

  Future<ResponseNoData> deleteBookmark(int item_id);

  Future<ResponseDataArrayObject<Highlight>> getListHighlights(int item_id);

  Future<ResponseNoData> addHighlight(int item_id, String title, String highlightText, String description, String color, int page, int startNodeIndex, int endNodeIndex, int startOffset, int endOffset);

  Future<ResponseNoData> updateHighlight(int id, String title, String highlightText, String description, String color, int page, int startNodeIndex, int endNodeIndex, int startOffset, int endOffset);

  Future<ResponseNoData> deleteHighlight(int item_id);
}