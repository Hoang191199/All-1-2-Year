import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qltv/app/config/app_common.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/domain/entities/borrow.dart';
import 'package:qltv/domain/entities/borrow_paging.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/usecases/borrow_add_use_case.dart';
import 'package:qltv/domain/usecases/borrow_delete_user_case.dart';
import 'package:qltv/domain/usecases/borrow_update_use_case.dart';
import 'package:qltv/domain/usecases/borrow_use_case.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_binding.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_detail_controller.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';

class BorrowController extends GetxController {
  BorrowController(this.borrowUseCase, this.borrowAddUseCase,
      this.borrowDeleteUseCase, this.borrowUpdateUseCase);

  final auth = Get.find<LoginController>();
  late TextEditingController title;
  late TextEditingController date;
  late TextEditingController titleBook;
  late TextEditingController author;
  late TextEditingController note;
  final isAdd = false.obs;

  final BorrowUseCase borrowUseCase;
  final BorrowAddUseCase borrowAddUseCase;
  final BorrowDeleteUseCase borrowDeleteUseCase;
  final BorrowUpdateUseCase borrowUpdateUseCase;

  int currentPage = 0;
  int pageSize = 12;
  var isLoadMore = false;
  final option = "".obs;
  final isLoading = false.obs;
  final validateTitleBook = "".obs;
  final validateAuthor = "".obs;
  var responseData = Rx<ResponseDataObject<BorrowPaging<Borrow>>?>(null);
  var borrowData = RxList<Borrow?>([]);
  var borrowPagingData = RxInt(0);
  var responseDataAdd = Rx<ResponseNoData?>(null);
  var paging = Rx<BorrowPaging<Borrow>?>(null);
  @override
  void onInit() {
    title = TextEditingController();
    date = TextEditingController();
    titleBook = TextEditingController();
    author = TextEditingController();
    note = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    title.dispose();
    date.dispose();
    titleBook.dispose();
    author.dispose();
    note.dispose();
  }

  fetchDataBorrow(String? keywords, int? status) async {
    isLoading(true);
    currentPage = 1;
    final responseBorrow = await borrowUseCase
        .execute(Tuple4(currentPage, pageSize, keywords, status));
    borrowData.assignAll(responseBorrow.data?.data ?? []);
    responseData.value = responseBorrow;
    borrowPagingData.value = responseBorrow.data?.total ?? 0;
    paging.value = responseBorrow.data;
    isLoading(false);
  }

  loadMore(String? keywords, int? status) async {
    final total = borrowPagingData.value;
    if (total / pageSize <= currentPage) return;
    if (isLoadMore) return;
    isLoadMore = true;
    currentPage += 1;
    if (status == -2) {
      status = null;
    }
    final borrowList = await borrowUseCase
        .execute(Tuple4(currentPage, pageSize, keywords, status));
    borrowData.addAll(borrowList.data?.data ?? []);
    paging.value?.total = borrowList.data?.total;
    isLoadMore = false;
  }

  addBorrow(
    String? title,
    String date,
    String titleBook,
    String author,
    String? note,
    BuildContext context,
  ) async {
    if (date == '') {
      date = (DateTime.now()).toString();
      DateTime dateTime = DateTime.parse(date);
      String dateFormat = DateFormat('dd/MM/yyyy').format(dateTime);
      date = dateFormat;
    } else {
      DateTime dateTime = DateTime.parse(date);
      String dateFormat = DateFormat('dd/MM/yyyy').format(dateTime);
      date = dateFormat;
    }
    if (titleBook == '' || author == '') {
      if (titleBook == '') {
        validateTitleBook.value = 'please-enter-title-book'.tr;
      }
      if (author == '') {
        validateAuthor.value = 'please-enter-author'.tr;
      }
    } else {
      final responseBorrow = await borrowAddUseCase
          .execute(Tuple5(title, date, titleBook, author, note));
      if (responseBorrow.code == 401) {
        auth.logout();
        showSnackbar(SnackbarType.notice, "log-out".tr, "session-time-out".tr);
        Get.back();
      } else if (responseBorrow.error != null &&
          responseBorrow.error == false) {
        Get.delete<BorrowController>();
        Get.back();
        BorrowBinding().dependencies();
        final borrowPage = Get.find<BorrowController>();
        borrowPage.fetchDataBorrow('', null);
        showSnackbar(
            SnackbarType.success, "success".tr, "add-document-success".tr);
      } else {
        showSnackbar(
            SnackbarType.error, "failure".tr, "add-document-failure".tr);
      }
    }
  }

  updateBorrow(
    int id,
    String? title,
    // String date,
    String titleBook,
    String author,
    String? note,
    BuildContext context,
  ) async {
    if (titleBook == '') {
      showAlertDialog(context, 'info'.tr, 'please-enter-title-book'.tr);
    } else if (author == '') {
      showAlertDialog(context, 'info'.tr, 'please-enter-author'.tr);
    } else {
      final responseBorrow = await borrowUpdateUseCase
          .execute(Tuple6(id, title, date.text, titleBook, author, note));
      if (responseBorrow.code == 401) {
        auth.logout();
        showSnackbar(SnackbarType.notice, "log-out".tr, "session-time-out".tr);
        Get.back();
      } else if (responseBorrow.error != null &&
          responseBorrow.error == false) {
        Get.delete<BorrowController>();
        Get.delete<BorrowDetailController>();
        Get.back();
        BorrowBinding().dependencies();
        final borrowPage = Get.find<BorrowController>();
        borrowPage.fetchDataBorrow('', null);
        showSnackbar(
            SnackbarType.success, "success".tr, "edit-document-success".tr);
      } else {
        showSnackbar(
            SnackbarType.error, "failure".tr, "edit-document-failure".tr);
      }
    }
  }

  delete(int id) async {
    final responseDeleteBorrow = await borrowDeleteUseCase.execute(id);
    if (responseDeleteBorrow.code == 401) {
      auth.logout();
      showSnackbar(SnackbarType.notice, "log-out".tr, "session-time-out".tr);
      Get.back();
    } else if (responseDeleteBorrow.error != null &&
        responseDeleteBorrow.error == false) {
      BorrowBinding().dependencies();
      final borrowPage = Get.find<BorrowController>();
      borrowPage.fetchDataBorrow('', null);
      showSnackbar(
          SnackbarType.success, "success".tr, "delete-document-success".tr);
    } else {
      showSnackbar(
          SnackbarType.error, "failure".tr, "delete-document-failure".tr);
    }
  }
}
