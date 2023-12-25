import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/domain/entities/meal.dart';
import 'package:mobiedu_kids/domain/entities/meal_detail.dart';
import 'package:mobiedu_kids/domain/entities/menu_history_details.dart';
import 'package:mobiedu_kids/domain/usecases/menu_use_case.dart';

class MenuController extends GetxController {
  MenuController(
      this.getMenuUseCase,
      this.getMenuChildUseCase,
      this.historyMenuUseCase,
      this.detailMenuUseCase,
      this.historyMenuChildUseCase,
      this.detailMenuChildUseCase,
      this.schoolListMenuUseCase,
      this.schoolDetailMenuUseCase);
  static MenuController get to => Get.find<MenuController>();

  final GetMenuUseCase getMenuUseCase;
  final GetMenuChildUseCase getMenuChildUseCase;
  final HistoryMenuUseCase historyMenuUseCase;
  final DetailMenuUseCase detailMenuUseCase;
  final HistoryMenuChildUseCase historyMenuChildUseCase;
  final DetailMenuChildUseCase detailMenuChildUseCase;
  final SchoolListMenuUseCase schoolListMenuUseCase;
  final SchoolDetailMenuUseCase schoolDetailMenuUseCase;

  var data = RxList<Meal?>([]);
  var historyMenu = RxList<MenuHistoryDetails>([]);
  var detailMenu = Rx<MealDetails?>(null);
  var id = Rx<String?>("");
  var is_saturday = Rx<String?>("");
  var is_saturday_detail = Rx<String?>("");
  var indexDate = 0.obs;
  var indexDateDetail = 0.obs;
  var indexDateNow = 0.obs;
  final isLoading = false.obs;
  final ishistoryLoading = false.obs;
  final isdetailLoading = false.obs;

  @override
  void onInit() async {
    if (DateFormat('EEEE').format(DateTime.now()) == "Monday") {
      indexDate.value = 0;
      indexDateNow.value = 0;
    } else if (DateFormat('EEEE').format(DateTime.now()) == "Tuesday") {
      indexDate.value = 1;
      indexDateNow.value = 1;
    } else if (DateFormat('EEEE').format(DateTime.now()) == "Wednesday") {
      indexDate.value = 2;
      indexDateNow.value = 2;
    } else if (DateFormat('EEEE').format(DateTime.now()) == "Thursday") {
      indexDate.value = 3;
      indexDateNow.value = 3;
    } else if (DateFormat('EEEE').format(DateTime.now()) == "Friday") {
      indexDate.value = 4;
      indexDateNow.value = 4;
    } else {
      indexDate.value = 5;
      indexDateNow.value = 5;
    }
    super.onInit();
  }

  fetch(String groupname) async {
    isLoading(true);
    final res = await getMenuUseCase.execute(groupname);
    if (res.code == 200) {
      data.assignAll(res.data?.menu_class?.details ?? []);
      is_saturday.value = res.data?.menu_class?.is_saturday;
      id.value = res.data?.menu_class?.menu_id;
    }
    isLoading(false);
  }

  fetchChild(String groupname) async {
    isLoading(true);
    final res = await getMenuChildUseCase.execute(groupname);
    if (res.code == 200) {
      data.assignAll(res.data?.menu_child?.details ?? []);
      is_saturday.value = res.data?.menu_child?.is_saturday;
      id.value = res.data?.menu_child?.menu_id;
    }
    isLoading(false);
  }

  history(int page, String groupname) async {
    ishistoryLoading(true);
    final res = await historyMenuUseCase.execute(Tuple2(page, groupname));
    if (res.code == 200) {
      historyMenu.assignAll(res.data?.menu_history ?? []);
    }
    ishistoryLoading(false);
  }

  historyChild(int page, String child_id) async {
    ishistoryLoading(true);
    final res = await historyMenuChildUseCase.execute(Tuple2(page, child_id));
    if (res.code == 200) {
      historyMenu.assignAll(res.data?.menu_history ?? []);
    }
    ishistoryLoading(false);
  }

  detail(String groupname, String menu_id) async {
    isdetailLoading(true);
    final res = await detailMenuUseCase.execute(Tuple2(groupname, menu_id));
    if (res.code == 200) {
      detailMenu.value = res.data?.menu_detail;
      is_saturday_detail.value = res.data?.menu_detail?.is_saturday;
    }
    isdetailLoading(false);
  }

  detailChild(String child_id, String menu_id) async {
    isdetailLoading(true);
    final res = await detailMenuChildUseCase.execute(Tuple2(child_id, menu_id));
    if (res.code == 200) {
      detailMenu.value = res.data?.menu_detail;
      is_saturday_detail.value = res.data?.menu_detail?.is_saturday;
    }
    isdetailLoading(false);
  }
}
