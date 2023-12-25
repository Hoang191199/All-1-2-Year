import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/event_details.dart';
import 'package:mobiedu_kids/domain/entities/event_school_details.dart';
import 'package:mobiedu_kids/domain/entities/events_child_details.dart';
import 'package:mobiedu_kids/domain/entities/events_details.dart';
import 'package:mobiedu_kids/domain/entities/participant_child_details.dart';
import 'package:mobiedu_kids/domain/usecases/event_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_binding.dart';
import 'package:mobiedu_kids/presentation/pages/manager/event/event_page.dart';

class EventController extends GetxController {
  EventController(
      this.getEventUseCase,
      this.getChildEventUseCase,
      this.detailEventUseCase,
      this.getSchoolEventUseCase,
      this.detailSchoolEventUseCase,
      this.createSchoolEventUseCase,
      this.editSchoolEventUseCase,
      this.deleteSchoolEventUseCase,
      this.fetchRegisterUseCase,
      this.saveRegisterUseCase,
      this.saveChildRegisterUseCase);
  // static MenuController get to => Get.find<MenuController>();
  final store = Get.find<LocalStorageService>();

  final GetEventUseCase getEventUseCase;
  final GetChildEventUseCase getChildEventUseCase;
  final DetailEventUseCase detailEventUseCase;
  final GetSchoolEventUseCase getSchoolEventUseCase;
  final DetailSchoolEventUseCase detailSchoolEventUseCase;
  final CreateSchoolEventUseCase createSchoolEventUseCase;
  final EditSchoolEventUseCase editSchoolEventUseCase;
  final DeleteSchoolEventUseCase deleteSchoolEventUseCase;
  final FetchRegisterUseCase fetchRegisterUseCase;
  final SaveRegisterUseCase saveRegisterUseCase;
  final SaveChildRegisterUseCase saveChildRegisterUseCase;

  final isLoading = false.obs;
  final isLoadingDetail = false.obs;
  final isLoadingRegister = false.obs;
  var events = RxList<EventsDetails>([]);
  var eventsSchool = RxList<EventsSchoolDetails>([]);
  var eventsChild = RxList<EventsChildDetails>([]);
  var event_details = Rx<EventDetails?>(null);
  var checkChild = Rx<Map<String, bool>>({});
  var checkParent = Rx<Map<String, bool>>({});
  final checkChildInvi = false.obs;
  final checkParentInvi = false.obs;
  var list = RxList<ParticipantChild>([]);
  final arrlen = 0.obs;
  final arrlenSchool = 0.obs;
  final page = 0.obs;
  final chooseChild = Rx<List<String>>([]);
  final chooseParent = Rx<List<String>>([]);

  @override
  void onInit() async {
    super.onInit();
  }

  savelistAttend(String event_id) async {
    chooseChild.value = [];
    chooseParent.value = [];
    var listchild = checkChild.value.keys.toList();
    var listparent = checkParent.value.keys.toList();
    for (var i = 0; i < listchild.length; i++) {
      if (checkChild.value[listchild[i]] == true) {
        chooseChild.value.add(listchild[i]);
      }
    }
    for (var j = 0; j < listparent.length; j++) {
      if (checkParent.value[listparent[j]] == true) {
        chooseParent.value.add(listparent[j]);
      }
    }
    var res = await saveRegisterUseCase.execute(Tuple6(
        store.getGroupname,
        event_id,
        chooseChild.value,
        chooseChild.value.length,
        chooseParent.value,
        chooseParent.value.length));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Thành công", "Đăng ký thành công");
      Get.delete<EventController>();
      EventBinding().dependencies();
      Get.off(() => EventPage());
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", "Yêu cầu thử lại");
    }
  }

  fetch(int page) async {
    isLoading(true);
    // try {
    var res = await getEventUseCase.execute(Tuple2(page, store.getGroupname));
    arrlen.value = res.data?.events?.length ?? 0;
    events.addAll(res.data?.events ?? []);
    // } catch (e) {
    //   Get.off(() => LoginPage());
    // }
    isLoading(false);
  }

  fetchChild(int page, String child_id) async {
    isLoading(true);
    // try {
    var res = await getChildEventUseCase.execute(Tuple2(page, child_id));
    arrlen.value = res.data?.events?.length ?? 0;
    eventsChild.addAll(res.data?.events ?? []);

    isLoading(false);
  }

  detail(String event_id) async {
    isLoadingDetail(true);
    // try {
    var res =
        await detailEventUseCase.execute(Tuple2(store.getGroupname, event_id));
    event_details.value = res.data?.event;
    // } catch (e) {
    //   Get.off(() => LoginPage());
    // }
    isLoadingDetail(false);
  }

  register(String event_id) async {
    isLoadingRegister(true);
    // try {
    checkChild.value = {};
    checkParent.value = {};
    var res = await fetchRegisterUseCase
        .execute(Tuple2(store.getGroupname, event_id));
    if (res.code == 200) {
      list.assignAll(res.data?.participant ?? []);
      list.forEach((app) {
        if (app.event_id == event_id) {
          checkChild.value[app.child_id ?? ""] = true;
        } else {
          checkChild.value[app.child_id ?? ""] = false;
        }
      });
      list.forEach((app) => app.parent?.forEach((a) {
            if (a.event_id == event_id) {
              checkParent.value[a.user_id ?? ""] = true;
            } else {
              checkParent.value[a.user_id ?? ""] = false;
            }
          }));
      // } catch (e) {
      //   Get.off(() => LoginPage());
      // }
    }
    isLoadingRegister(false);
  }

  registerChild(String child_id, String event_id, String participant_child,
      String participant_parent) async {
    isLoadingRegister(true);
    final res = await saveChildRegisterUseCase.execute(
        Tuple4(child_id, event_id, participant_child, participant_parent));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Thành công", "Đăng ký thành công");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", "Yêu cầu thử lại");
    }
    isLoadingRegister(false);
  }

  fetchSchool(int page) async {
    isLoading(true);
    // try {
    var res =
        await getSchoolEventUseCase.execute(Tuple2(page, store.getPagename));
    arrlen.value = res.data?.events?.length ?? 0;
    eventsSchool.addAll(res.data?.events ?? []);
    // } catch (e) {
    //   Get.off(() => LoginPage());
    // }
    isLoading(false);
  }
}
