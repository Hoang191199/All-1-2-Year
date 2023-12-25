import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qltv/domain/entities/borrow.dart';
import 'package:qltv/domain/entities/borrow_paging.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/usecases/borrow_detail_use_case.dart';

class BorrowDetailController extends GetxController {
  BorrowDetailController(this.borrowDetailUseCase);

  BorrowDetailUseCase borrowDetailUseCase;

  late TextEditingController dateTimes;
  late DateTime localDateTime;
  final isLoading = false.obs;
  var responseData = Rx<ResponseDataObject<Borrow>?>(null);
  var dataBorrow = Rx<BorrowPaging<Borrow>>;

  fetchDetail(int id) async {
    isLoading(true);
    await Future.delayed(const Duration(milliseconds: 200));
    final dataResponse = await borrowDetailUseCase.execute(id);
    responseData.value = dataResponse;
    String? dateText = dataResponse.data?.get_date;
    DateTime dateTime = DateTime.parse(dateText!);
    localDateTime = dateTime.toLocal();
    String formattedDate = DateFormat('MM-dd-yyyy').format(localDateTime);
    dateTimes = TextEditingController(text: formattedDate);
    isLoading(false);
  }
}
