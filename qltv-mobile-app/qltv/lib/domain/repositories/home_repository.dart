import 'package:qltv/domain/entities/page.dart';
import 'package:qltv/domain/entities/publication.dart';
import 'package:qltv/domain/entities/response_data_object.dart';

abstract class HomeRepository {
  Future<ResponseDataObject<Page>> fetchHome();
  Future<ResponseDataObject<Publication>> getbookDetail(int id);
}
