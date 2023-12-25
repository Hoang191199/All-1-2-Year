import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/child_data.dart';
import 'package:mobiedu_kids/domain/entities/list_child_details.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/usecases/review_use_case.dart';

class ScheduleReviewController extends GetxController {
  ScheduleReviewController(
      this.scheduleReviewUseCase, this.scheduleFetchReviewUseCase);
  // static ScheduleReviewController get to =>
  //     Get.find<ScheduleReviewController>();

  final ScheduleReviewUseCase scheduleReviewUseCase;
  final ScheduleFetchReviewUseCase scheduleFetchReviewUseCase;
  final store = Get.find<LocalStorageService>();
  var responsereviewData = Rx<ResponseDataArrayObject<Object>?>(null);
  var responsefetchData = RxList<ListChildDetails>([]);
  final isLoading = false.obs;
  var textControllers = Rx<Map<String, TextEditingController>>({});
  late TextEditingController quickTextController;
  var check = Rx<Map<String, bool>>({});
  final chooseChild = Rx<List<ChildData>>([]);
  final remainChild = Rx<List<ChildData>>([]);

  @override
  void onInit() async {
    // await fetch(
    //     store.getGroupname, DateFormat('dd/MM/yyyy').format(DateTime.now()));
    quickTextController = TextEditingController(text: "");
    super.onInit();
  }

  listName() {
    chooseChild.value = [];
    remainChild.value = [];
    var listkey = textControllers.value.keys.toList();
    var listcheckvalue = check.value.values.toList();
    var listcheckkey = check.value.keys.toList();
    if (listkey.isNotEmpty &&
        listcheckvalue.isNotEmpty &&
        listcheckkey.isNotEmpty) {
      if (listkey.length == listcheckkey.length &&
          listcheckvalue.length == listcheckkey.length) {
        for (var i = 0; i < listcheckkey.length; i++) {
          if (listcheckvalue[i] == true) {
            chooseChild.value.add(
                ChildData(child_id: listcheckkey[i], child_name: listkey[i]));
          } else {
            remainChild.value.add(
                ChildData(child_id: listcheckkey[i], child_name: listkey[i]));
          }
        }
      } else {}
    } else {
      chooseChild.value = [];
      remainChild.value = [];
    }
  }

  review(String group_name, String date, List<String> note, String schedule_id,
      List<String> childId, int childNum) async {
    // try {
    final response = await scheduleReviewUseCase.execute(
        Tuple6(group_name, date, note, schedule_id, childId, childNum));
    responsereviewData.value = response;
    if (response.code == 200) {
      showSnackbar(
          SnackbarType.success, "Thành công", "Cập nhật thông tin thành công");
    } else {
      showSnackbar(SnackbarType.error, "Lỗi", response.message ?? "");
    }
  }

  fetch(String group_name, String date) async {
    isLoading(true);
    textControllers.value = {};
    check.value = {};
    final response =
        await scheduleFetchReviewUseCase.execute(Tuple2(group_name, date));
    if (response.code == 200) {
      responsefetchData.assignAll(response.data?.listChild ?? []);
      if (responsefetchData.isNotEmpty) {
        responsefetchData.forEach((app) =>
            textControllers.value[app.child_id!] =
                TextEditingController(text: app.note ?? ""));
        responsefetchData.forEach((app) => check.value[app.child_id!] = false);
      }
    }
    isLoading(false);
  }

}
