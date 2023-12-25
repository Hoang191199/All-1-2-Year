
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/entities/search.dart';
import 'package:qltv/domain/entities/search_paging.dart';

abstract class SearchRepository {
  Future<ResponseDataObject<SearchPaging<Search>>> fetch(String? object_type,String? titleLabel, String? keyword, int? page, int? pageSize );
  Future<ResponseNoData> register(int? quantity, int? item_id, String? receipt_date,  String? type);
  Future<ResponseNoData> add(int item_id);
  Future<ResponseNoData> seen(int item_id);
}
