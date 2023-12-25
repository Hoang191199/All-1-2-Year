
import 'package:qltv/data/providers/network/apis/borrow_api.dart';
import 'package:qltv/domain/entities/borrow_paging.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/borrow.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/borrow_repository.dart';

class BorrowRepositoryImpl extends BorrowRepository {
  @override
  Future<ResponseDataObject<BorrowPaging<Borrow>>>fetchBorrow(int page, int pageSize, String? keywords, int? status) async {
    final response = await BorrowAPI.fetchBorrow(page, pageSize, keywords, status).request();
    return ResponseDataObject<BorrowPaging<Borrow>>.fromJson(response, (data) => BorrowPaging<Borrow>.fromJson(data, (d) => Borrow.fromJson(d)));
  }

  @override
  Future<ResponseDataObject<Borrow>> getBorrowDetail(int id) async {
    final response = await BorrowAPI.getBorrowDetail(id).request();
    return ResponseDataObject<Borrow>.fromJson(response, (data) => Borrow.fromJson(data));
  }

  @override
  Future<ResponseNoData> add(String title, String date, String titleBook, String author, String note) async {
    final response = await BorrowAPI.addBorrow(title, date, titleBook, author, note).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> deleteBorrow(int id) async {
    final response = await BorrowAPI.deleteBorrow(id).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> updateBorrow(int id, String title, String date, String titleBook, String author, String note) async {
    final response = await BorrowAPI.updateBorrow( id,  title,  date,  titleBook,  author,  note).request();
    return ResponseNoData.fromJson(response);
  }


}