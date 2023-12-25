
import 'package:qltv/domain/entities/borrow.dart';
import 'package:qltv/domain/entities/borrow_paging.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/response_no_date.dart';

abstract class BorrowRepository {
  Future<ResponseDataObject<BorrowPaging<Borrow>>> fetchBorrow(int page, int pageSize, String? keywords, int? status);
  Future<ResponseDataObject<Borrow>> getBorrowDetail(int id);
  Future<ResponseNoData> deleteBorrow(int id);
  Future<ResponseNoData> updateBorrow(int id, String title, String date, String titleBook, String author, String note);
  Future<ResponseNoData> add(String title, String date, String titleBook, String author, String note);
}
