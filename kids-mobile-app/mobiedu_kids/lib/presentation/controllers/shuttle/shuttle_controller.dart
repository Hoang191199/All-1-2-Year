import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/assign_in_shuttle.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/classes_in_shuttle.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/data_student.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/day_in_assign_shuttle.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/history.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/list_child.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/list_data_add_child.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/shuttle.dart';
import 'package:mobiedu_kids/domain/usecases/shuttle/shuttle_use_case.dart';
import 'package:table_calendar/table_calendar.dart';

class ShuttleController extends GetxController {
  ShuttleController(this.shuttle, this.pickup, this.save, this.cancel,
      this.listClass, this.listChild, this.addChild, this.assgin, this.history);
  var responseShuttle = Rx<ResponseDataObject<Shuttle>?>(null);
  var responseListClass = Rx<ResponseDataObject<ClassesInShuttle>?>(null);
  var responseListChild = Rx<ResponseDataObject<ListChild>?>(null);
  var responseListAssign = Rx<ResponseDataObject<AssignInShuttle>?>(null);
  var responseHistory = Rx<ResponseDataObject<History>?>(null);
  final isLoading = false.obs;
  final isLoadingPickUp = false.obs;
  final isLoadingSavePickUp = false.obs;
  final isLoadingListClass = false.obs;
  final isLoadingListChild = false.obs;
  final isLoadingAddChild = false.obs;
  final isLoadingListAssign = false.obs;
  final isLoadingHistory = false.obs;
  // final isList = RxList<ObjectDataShuttle>([]);
  final isShow = <RxBool>[].obs;
  RxMap<int, TimeOfDay?> selectedTimes = <int, TimeOfDay?>{}.obs;
  List<List<String>> selectedServices = [];
  List<List<String>> serviceIds = [];
  List<List<String>> selectedPrice = [];
  List<List<String>> price = [];
  int toltal = 0;
  final nameClassIndex = 0.obs;
  final nameClass = ''.obs;
  final classId = ''.obs;
  final pickup_id = ''.obs;
  final pickup_class_id = ''.obs;
  final checkAll = true.obs;
  final isCheckedBox = <bool>[].obs;
  final isDataChecked = false.obs;
  final descriptionCheckbox = <TextEditingController>[].obs;
  ListDataAddChild dataStudent = ListDataAddChild(list: []);
  final textEditingControllers = <TextEditingController>[].obs;
  final DateTime now = DateTime.now();
  late DateTime focusedDay;
  late DateTime firstDayOfMonth;
  late DateTime lastDayOfMonth;
  late String firstDayOfMonthString;
  late String lastDayOfMonthString;
  final doneDate = RxList<DateTime>([]);
  final assignDate = RxList<DateTime>([]);
  var isDateNow = false;
  final listStudent = <DataStudent>[].obs;
  final listStudentWithClass = <DataStudent>[].obs;

  final ShuttleUserCase shuttle;
  final PickUpUserCase pickup;
  final SavePickUpUserCase save;
  final CancelPickUpUserCase cancel;
  final ListClassUserCase listClass;
  final ListChildUserCase listChild;
  final AddChildUserCase addChild;
  final AssignUserCase assgin;
  final HistoryUserCase history;

  @override
  void onInit() {
    firstDayOfMonth = DateTime(now.year, now.month, 1);
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    firstDayOfMonthString = convertDateTimeToString(firstDayOfMonth);
    lastDayOfMonthString = convertDateTimeToString(lastDayOfMonth);
    focusedDay = DateTime.now();

    super.onInit();
  }

  fetchData() async {
    isLoading(true);
    try {
      final response = await shuttle.execute();
      responseShuttle.value = response;
      pickup_id.value = responseShuttle.value?.data?.pickup_id ?? '0';
      pickup_class_id.value = responseShuttle.value?.data?.pickup_class_id ?? '0';

      final studentTemp = <DataStudent>[];
      listStudent.value = [];
      response.data?.late_pickup?.forEach((element) {
        studentTemp.add(element.parseToData());
      });
      listStudent.addAll(studentTemp);

      initializeShow(response.data?.late_pickup?.length ?? 0);
    } catch (error) {
      responseShuttle.value = null;
    }
    isLoading(false);
  }

  pickUp(int pickup_id, int child_id, BuildContext context) async {
    isLoadingPickUp(true);
    try {
      final response = await pickup.execute(Tuple2(pickup_id, child_id));
      if (response.code == 200) {
        await fetchData();
        showSnackbar(SnackbarType.success, "Thành công", "Trả học sinh thành công!");
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Trả học sinh thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Trả học sinh thất bại!");
    }
    isLoadingPickUp(false);
  }

  savePickup(
      int pickup_id,
      int child_id,
      String? late_pickup_free,
      int? total_amount,
      String? pickup_at,
      int? stt,
      List<String>? service,
      String type,
      String status,
      BuildContext context) async {
    isLoadingSavePickUp(true);
    try {
      if(type == "Trả"){
        if (pickup_at == "") {
          var now = DateTime.now();
          var formatter = DateFormat.Hm();
          pickup_at = formatter.format(now);
        }
      }else{
        if(pickup_at == ""){
          pickup_at = "";
        }
      }
      
      final response = await save.execute(Tuple9(pickup_id, child_id, late_pickup_free, total_amount, pickup_at, listStudent[stt ?? 0].description?.text, service, stt, status));
      if (response.code == 200) {
        await fetchData();
        showSnackbar(SnackbarType.success, "Thành công","Lưu thông tin học sinh thành công!");
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Lưu thông tin học sinh thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Lưu thông tin học sinh thất bại!");
    }
    isLoadingSavePickUp(false);
  }

  cancelPickup(int pickupId, int childId, BuildContext context) async {
    isLoadingPickUp(true);
    try {
      final response = await cancel.execute(Tuple2(pickupId, childId));
      if (response.code == 200) {
        await fetchData();
        showSnackbar(SnackbarType.success, "Thành công", "Hủy thành công!");
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Hủy thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Hủy thất bại!");
    }
    isLoadingPickUp(false);
  }

  void initializeShow(int length) {
    isShow.value = List.generate(length, (_) => false).map((_) => false.obs).toList();
    selectedServices = List.generate(length, (_) => []);
    selectedPrice = List.generate(length, (_) => []);
  }

  void toggleShow(int index) {
    isShow[index].value = !isShow[index].value;
  }

  setSelectedTime(TimeOfDay time, int index) {
    selectedTimes[index] = time;
  }

  void toggleService(int stt, String serviceId, String price, bool isChecked) {
    final services = selectedServices[stt];
    final toltals = selectedPrice[stt];
    if (isChecked) {
      if (!services.contains(serviceId)) {
        services.add(serviceId);
        toltals.add(price);
      }
    } else {
      services.remove(serviceId);
      toltals.remove(price);
    }
    if (toltals.isNotEmpty) {
      toltal = toltals.map((item) => int.parse(item)).reduce((value, element) => value + element);
    } else {
      toltal = 0;
    }
  }

  listclass() async {
    isLoadingListClass(true);
    try {
      final response = await listClass.execute();
      responseListClass.value = response;
    } catch (error) {
      responseListClass.value = null;
    }

    isLoadingListClass(false);
  }

  listchild() async {
    isLoadingListChild(true);
    try {
      final response = await listChild.execute();
      responseListChild.value = response;
      final listChilds = response.data?.list_child;
      List<DataStudent> listDataStudent = [];
      listChilds?.forEach((element) {
        var dataStudent = DataStudent(
          child_id: element.child_id,
          description: TextEditingController(text: element.description),
          check: listStudent.where((student1) => student1.child_id == element.child_id).isNotEmpty,
          student: element,
          exist: element.pickup_class_id
        );
        listDataStudent.add(dataStudent);
      });
      listStudentWithClass.value = listDataStudent;
      
      for (var item in listStudentWithClass) {
        if(item.exist == null || responseShuttle.value?.data?.pickup_class_id == item.exist){
          if (item.check  == false) {
            checkAll.value = false;
            break;
          }
        }else{
          checkAll.value = true;
        }
      }   
    } catch (error) {
      responseListChild.value = null;
    }
    isLoadingListChild(false);
  }

  checkAllData(bool value) {
    if (value == true) {
      for (var element in listStudentWithClass) {
        if(element.exist == null || responseShuttle.value?.data?.pickup_class_id == element.exist){
          element.check = true;
        }
      }
    } else {
      for (var element in listStudentWithClass) {
        if(element.exist == null || responseShuttle.value?.data?.pickup_class_id == element.exist){
        element.check = false;
        }
      }
    }
  }

  addchild() async {
    isLoadingAddChild(true);
    if(listStudentWithClass.where((data) => data.check == true).isNotEmpty == true){
      try {
        final response = await addChild.execute();
        if (response.code == 200) {
          await fetchData();
          Get.back();
          nameClassIndex.value = 0;
          showSnackbar(SnackbarType.success, "Thành công", "Thêm học sinh thành công!");
        } else {
          showSnackbar(SnackbarType.error, "Thất bại", "Thêm học sinh thất bại!");
        }
      } catch (error) {
        showSnackbar(SnackbarType.error, "Thất bại", "Thêm học sinh thất bại!");
      }
    }else{
       showSnackbar(SnackbarType.error, "Thất bại", "Vui lòng chọn học sinh!");
    }
    isLoadingAddChild(false);
  }

  assign() async {
    isLoadingListAssign(true);
    try {
      final response = await assgin.execute();
      responseListAssign.value = response;
    } catch (error) {
      responseListAssign.value = null;
    }

    isLoadingListAssign(false);
  }

  int calculateLength(DayInAssignShuttle? day) {
    int count = 0;
    if (day != null) {
      if (day.hai != null) count += 1;
      if (day.ba != null) count += 1;
      if (day.bon != null) count += 1;
      if (day.nam != null) count += 1;
      if (day.sau != null) count += 1;
      if (day.bay != null) count += 1;
      if (day.cn != null) count += 1;
    }
    return count;
  }

  historyClass() async {
    isLoadingHistory(true);
    try {
      final response = await history.execute();
      responseHistory.value = response;
        // for (var i = 0 ; i < responseHistory.value!.data!.class_history!.length; i++) {
        //   DateTime pickupTime = DateFormat('yyyy-MM-dd').parse(responseHistory.value?.data?.class_history?[i].assign_time ?? '2023-06-01');
        //   assignDate.add(pickupTime);
        // }
        // for (var i = 0 ; i < responseHistory.value!.data!.class_history!.length; i++) {
        //   if(responseHistory.value?.data?.class_history?[i].action == 1){
        //     DateTime pickupTime = DateFormat('yyyy-MM-dd').parse(responseHistory.value?.data?.class_history?[i].assign_time ?? '2023-06-01');
        //     doneDate.add(pickupTime);
        //   }
        // }
        if (response.data?.class_history?.isNotEmpty ?? false) {
          for (var i = 0 ; i < (response.data?.class_history?.length ?? 0); i++) {
            DateTime pickupTime = DateFormat('yyyy-MM-dd').parse(response.data?.class_history?[i].assign_time ?? '2023-06-01');
            assignDate.add(pickupTime);
            if (response.data?.class_history?[i].action == 1) {
              doneDate.add(pickupTime);
            }
          }
        }
        for (var i = 0; i < assignDate.length; i++) {
          if (isSameDay(assignDate[i], now)) {
            isDateNow = true;
            break;
          }
        }
    } catch (error) {
      responseHistory.value = null;
    }
    isLoadingHistory(false);
  }
}
