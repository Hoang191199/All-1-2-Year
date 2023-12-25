import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/child_data.dart';
import 'package:mobiedu_kids/domain/entities/list_child_details.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/usecases/review_use_case.dart';
import 'package:mobiedu_kids/presentation/pages/login/login_page.dart';

class MenuReviewController extends GetxController {
  MenuReviewController(this.menuReviewUseCase, this.menuFetchReviewUseCase);
  // static MenuReviewController get to => Get.find<MenuReviewController>();

  final MenuReviewUseCase menuReviewUseCase;
  final MenuFetchReviewUseCase menuFetchReviewUseCase;
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
  void onInit() {
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

  review(String group_name, String date, String day, List<String> note,
      String menu_id, List<String> childId, int childNum) async {
    final response = await menuReviewUseCase.execute(
        Tuple7(group_name, date, day, note, menu_id, childId, childNum));
    if (response.code == 100) {
      Get.off(() => LoginPage());
    }
    responsereviewData.value = response;
    if (response.code == 200) {
      showSnackbar(
          SnackbarType.success, "Thành công", "Cập nhật thông tin thành công!");
    } else {
      showSnackbar(SnackbarType.error, "Lỗi", "Xin thử lại");
    }
  }

  fetch(String group_name, String date, String time) async {
    isLoading(true);
    // try {
    textControllers.value = {};
    check.value = {};
    final response =
        await menuFetchReviewUseCase.execute(Tuple3(group_name, date, time));
    if (response.code == 200) {
      responsefetchData.assignAll(response.data?.listChild ?? []);
      responsefetchData.forEach((app) => textControllers.value[app.child_id!] =
          TextEditingController(text: app.note ?? ""));
      responsefetchData.forEach((app) => check.value[app.child_id!] = false);
    }
    // } catch (e) {
    //   Get.off(() => LoginPage);
    // }
    isLoading(false);
  }

}
