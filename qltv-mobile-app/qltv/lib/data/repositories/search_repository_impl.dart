
import 'package:qltv/data/providers/network/apis/search_api.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/entities/search.dart';
import 'package:qltv/domain/entities/search_paging.dart';
import 'package:qltv/domain/repositories/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {

  @override
  Future<ResponseDataObject<SearchPaging<Search>>>fetch(String? object_type,String? titleLabel, String? keyword, int? page, int? pageSize) async {
    final response = await SearchAPI.fetch(object_type,titleLabel, keyword, page, pageSize).request();
    return ResponseDataObject<SearchPaging<Search>>.fromJson(response, (data) => SearchPaging<Search>.fromJson(data, (d) => Search.fromJson(d)));
  }

  @override
  Future<ResponseNoData> register(int? quantity, int? item_id, String? receipt_date,  String? type) async {
    final response = await SearchAPI.register(quantity, item_id, receipt_date, type).request();
    return ResponseNoData.fromJson(response);
  }

    @override
  Future<ResponseNoData> add(int item_id) async {
    final response = await SearchAPI.add(item_id).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> seen(int item_id) async {
    final response = await SearchAPI.seen(item_id).request();
    return ResponseNoData.fromJson(response);
  }
}