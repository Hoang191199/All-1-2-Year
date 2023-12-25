import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/child_data.dart';
import 'package:mobiedu_kids/domain/entities/image_data.dart';
import 'package:mobiedu_kids/domain/entities/list_child_daily_details.dart';
import 'package:mobiedu_kids/domain/entities/list_child_monthly_details.dart';
import 'package:mobiedu_kids/domain/entities/template.dart';
import 'package:mobiedu_kids/domain/usecases/review_use_case.dart';

class RemarkController extends GetxController {
  RemarkController(
      this.dailyFetchUseCase,
      this.dailyReviewUseCase,
      this.monthlyFetchUseCase,
      this.monthlyReviewUseCase,
      this.uploadUseCase,
      this.fetchTemplateUseCase);

  DailyFetchUseCase dailyFetchUseCase;
  DailyReviewUseCase dailyReviewUseCase;
  MonthlyFetchUseCase monthlyFetchUseCase;
  MonthlyReviewUseCase monthlyReviewUseCase;
  UploadUseCase uploadUseCase;
  FetchTemplateUseCase fetchTemplateUseCase;
  var dateNow = Rx<DateTime>(DateTime.now());
  final numberId = 0.obs;
  final thisId = "".obs;
  var indexDateBegin = 0.obs;
  final applyAll = false.obs;
  final templateUse = false.obs;
  late TextEditingController quickDailyTextController;
  late TextEditingController quickDailyTitleTextController;
  late TextEditingController quickMonthlyTextController;
  late TextEditingController quickMonthlyTitleTextController;
  final listDailyChild = RxList<ListChildDailyDetails>([]);
  final listMonthlyChild = RxList<ListChildMonthlyDetails>([]);
  var textControllersDaily = Rx<Map<String, TextEditingController>>({});
  var textControllersMonthly = Rx<Map<String, TextEditingController>>({});
  var imageInfoDaily = Rx<Map<String, ImageData>>(<String, ImageData>{});
  var quickImageInfoMonthly = Rx<ImageData?>(null);
  var quickImageInfoDaily = Rx<ImageData?>(null);
  var checkDaily = Rx<Map<String, bool>>({});
  var listTemplate = RxList<Template?>([]);
  final isLoading = false.obs;
  final isweekLoading = false.obs;
  final chooseChild = Rx<List<ChildData>>([]);
  final remainChild = Rx<List<ChildData>>([]);
  final listMonthlyImage = RxList<ImageData>([]);
  var isNotifiedDaily = false.obs;
  var isNotifiedMonthly = false.obs;

  @override
  void onInit() async {
    if (DateFormat('EEEE').format(DateTime.now()) == "Monday") {
      indexDateBegin.value = 0;
    } else if (DateFormat('EEEE').format(DateTime.now()) == "Tuesday") {
      indexDateBegin.value = 1;
    } else if (DateFormat('EEEE').format(DateTime.now()) == "Wednesday") {
      indexDateBegin.value = 2;
    } else if (DateFormat('EEEE').format(DateTime.now()) == "Thursday") {
      indexDateBegin.value = 3;
    } else if (DateFormat('EEEE').format(DateTime.now()) == "Friday") {
      indexDateBegin.value = 4;
    } else if (DateFormat('EEEE').format(DateTime.now()) == "Saturday") {
      indexDateBegin.value = 5;
    } else {
      indexDateBegin.value = 6;
    }
    quickDailyTextController = TextEditingController(text: "");
    quickDailyTitleTextController = TextEditingController(text: "");
    quickMonthlyTextController = TextEditingController(text: "");
    quickMonthlyTitleTextController = TextEditingController(text: "");
    super.onInit();
  }

  fetchDaily(String groupname, String date) async {
    isLoading.value = true;
    checkDaily.value = {};
    textControllersDaily.value = {};
    final resDaily = await dailyFetchUseCase.execute(Tuple2(groupname, date));
    if (resDaily.code == 200) {
      listDailyChild.assignAll(resDaily.data?.listChild ?? []);
      listDailyChild.forEach((app) => checkDaily.value[app.child_id!] = false);
      listDailyChild.forEach((app) =>
          textControllersDaily.value[app.child_id!] =
              TextEditingController(text: app.content ?? ""));
    }
    isLoading.value = false;
  }

  fetchMonthly(String groupname, String date, String date_end) async {
    isweekLoading.value = true;
    final resMonthly =
        await monthlyFetchUseCase.execute(Tuple3(groupname, date, date_end));
    if (resMonthly.code == 200) {
      listMonthlyChild.assignAll(resMonthly.data?.listChild ?? []);
    }
    isweekLoading.value = false;
  }

  listName() {
    chooseChild.value = [];
    remainChild.value = [];
    var listkey = textControllersDaily.value.keys.toList();
    var listcheckvalue = checkDaily.value.values.toList();
    var listcheckkey = checkDaily.value.keys.toList();
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

  reviewDaily(
      String groupname,
      String date,
      List<String?> note,
      List<String?> note_title,
      List<String?> childId,
      List<String?> source,
      List<String?> filename,
      int childNum,
      int isNotified) async {
    final res = await dailyReviewUseCase.execute(Tuple9(groupname, date, note,
        note_title, childId, source, filename, childNum, isNotified));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Thành công", "Cập nhật thông tin thành công!");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }

  reviewMonthly(
      String groupname,
      String date,
      String date_end,
      List<String?> note,
      List<String?> note_title,
      List<String?> childId,
      List<String?> source,
      List<String?> filename,
      int childNum,
      String metadata,
      int isNotified) async {
    final res = await monthlyReviewUseCase.execute(Tuple11(
        groupname,
        date,
        date_end,
        note,
        note_title,
        childId,
        source,
        filename,
        childNum,
        metadata,
        isNotified));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Thành công", "Cập nhật thông tin thành công!");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }

  fetchTemplate(String group_name, String mode) async {
    final res = await fetchTemplateUseCase.execute(Tuple2(group_name, mode));
    if (res.code == 200) {
      listTemplate.assignAll(res.data ?? []);
    }
  }
}
