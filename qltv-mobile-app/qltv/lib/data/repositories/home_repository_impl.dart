import 'package:qltv/data/providers/network/apis/home_api.dart';
import 'package:qltv/domain/entities/page.dart';
import 'package:qltv/domain/entities/publication.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<ResponseDataObject<Page>> fetchHome() async {
    final response = await HomeAPI.fetchHome().request();
    return ResponseDataObject<Page>.fromJson(response, (data) => Page.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Publication>> getbookDetail(int id) async {
    final response = await HomeAPI.bookDetail(id).request();
    return ResponseDataObject<Publication>.fromJson(response, (data) => Publication.fromJson(data));
  }
}