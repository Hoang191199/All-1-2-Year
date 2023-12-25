import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/domain/entities/activity.dart';
import 'package:mobiedu_kids/domain/entities/schedule_history_details.dart';
import 'package:mobiedu_kids/domain/entities/schedule_more_details.dart';
import 'package:mobiedu_kids/domain/usecases/schedule_use_case.dart';

class ScheduleController extends GetxController {
  ScheduleController(
      this.getScheduleUseCase,
      this.getScheduleChildUseCase,
      this.viewScheduleUseCase,
      this.detailScheduleUseCase,
      this.viewScheduleChildUseCase,
      this.detailScheduleChildUseCase,
      this.schoolListScheduleUseCase,
      this.schoolDetailScheduleUseCase);
  static ScheduleController get to => Get.find<ScheduleController>();

  final GetScheduleUseCase getScheduleUseCase;
  final GetScheduleChildUseCase getScheduleChildUseCase;
  final ViewScheduleUseCase viewScheduleUseCase;
  final DetailScheduleUseCase detailScheduleUseCase;
  final ViewScheduleChildUseCase viewScheduleChildUseCase;
  final DetailScheduleChildUseCase detailScheduleChildUseCase;
  final SchoolListScheduleUseCase schoolListScheduleUseCase;
  final SchoolDetailScheduleUseCase schoolDetailScheduleUseCase;

  var data = RxList<Activity?>([]);
  var historySchedule = RxList<ScheduleHistoryDetails>([]);
  var detailSchedule = Rx<ScheduleMoreDetails?>(null);
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
    final res = await getScheduleUseCase.execute(groupname);
    if (res.code == 200) {
      data.assignAll(res.data?.schedule_class?.details ?? []);
      is_saturday.value = res.data?.schedule_class?.is_saturday;
      id.value = res.data?.schedule_class?.schedule_id;
    }
    isLoading(false);
  }

  fetchChild(String child_id) async {
    isLoading(true);
    final res = await getScheduleChildUseCase.execute(child_id);
    if (res.code == 200) {
      data.assignAll(res.data?.schedule_child?.details ?? []);
      is_saturday.value = res.data?.schedule_child?.is_saturday;
      id.value = res.data?.schedule_child?.schedule_id;
    }
    isLoading(false);
  }

  history(int page, String groupname) async {
    ishistoryLoading(true);
    final res = await viewScheduleUseCase.execute(Tuple2(page, groupname));
    if (res.code == 200) {
      historySchedule.assignAll(res.data?.schedule_history ?? []);
    }
    ishistoryLoading(false);
  }

  historyChild(int page, String child_id) async {
    ishistoryLoading(true);
    final res = await viewScheduleChildUseCase.execute(Tuple2(page, child_id));
    if (res.code == 200) {
      historySchedule.assignAll(res.data?.schedule_history ?? []);
    }
    ishistoryLoading(false);
  }

  detail(String groupname, String schedule_id) async {
    isdetailLoading(true);
    final res = await detailScheduleUseCase.execute(Tuple2(groupname, schedule_id));
    if (res.code == 200) {
      detailSchedule.value = res.data?.schedule_detail;
      is_saturday_detail.value = res.data?.schedule_detail?.is_saturday;
    }
    isdetailLoading(false);
  }

  detailChild(String child_id, String schedule_id) async {
    isdetailLoading(true);
    final res =
        await detailScheduleChildUseCase.execute(Tuple2(child_id, schedule_id));
    if (res.code == 200) {
      detailSchedule.value = res.data?.schedule_detail;
      is_saturday_detail.value = res.data?.schedule_detail?.is_saturday;
    }
    isdetailLoading(false);
  }
}
