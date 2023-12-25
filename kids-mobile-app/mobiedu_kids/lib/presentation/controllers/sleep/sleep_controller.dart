import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/attendance/hygiene_temp.dart';
import 'package:mobiedu_kids/domain/entities/attendance/listChild.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/usecases/attendance_use_case.dart';

class SleepController extends GetxController {
  SleepController(this.getSleep, this.updateSleep);

  final responseSleep = Rx<ResponseDataObject<ListChild>?>(null);
  final isLoading = false.obs;
  final listSleepTemp = <HygieneTemp>[].obs;
  final checkAll = false.obs;
  final isLoadingupdate = false.obs;
  final selectedStudent = ''.obs;
  final validateStudent = ''.obs;
  final begin = const TimeOfDay(hour: 11, minute: 30).obs ;
  final end = const TimeOfDay(hour: 14, minute: 00).obs;
  late TextEditingController noteAll;
  final time = ''.obs;
  final selectedStudentCheckbox = <bool>[].obs;
  final selectedComment = <String>[].obs;
  final checkComment = <bool>[].obs;


  final SleepUserCase getSleep;
  final UpdateSleepUserCase updateSleep;

  @override
  void onInit() {
    noteAll = TextEditingController();
    initializeData();
    super.onInit();
  }

  fetchData() async {
    isLoading(true);

    final response = await getSleep.execute();
    responseSleep.value = response;
    final sleepTemp = <HygieneTemp>[];
    listSleepTemp.value = [];
    response.data?.listChild?.forEach((element) {
      sleepTemp.add(element.parseToHygieneTemp());
    });
    listSleepTemp.addAll(sleepTemp);

    isLoading(false);
  }

  checkAllData(bool value) {
    if (value == true) {
      for (var element in listSleepTemp) {
        element.check = true;
      }
    } else {
      for (var element in listSleepTemp) {
        element.check = false;
      }
    }
  }

  showCheckAll(bool value) {
    var legthData = listSleepTemp.where((element) => element.check == true).length;
    if(legthData == listSleepTemp.length){
      checkAll.value = true;
    }
  }

  updateData() async {
    isLoadingupdate(true);
    try {
      final response = await updateSleep.execute();
      if (response.code == 200) {
        showSnackbar(SnackbarType.success, "Thành công", "Cập nhật thông tin thành công!");
        begin.value = const TimeOfDay(hour: 11, minute: 30);
        end.value = const TimeOfDay(hour: 14, minute: 00);
        checkComment.value = List.generate(commentFormSleep.length, (_) => false);
        selectedComment.value = List.generate(commentFormSleep.length, (_) => '');
        await fetchData();
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Cập nhật thông tin thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Cập nhật thông tin thất bại!");
    }
    checkAll.value = false;
    isLoadingupdate(false);
  }

  listName(){
    var checkedElements = listSleepTemp.where((element) => element.check == true).toList();
    var nameStudent = checkedElements.map((element) => element.student?.child_name).join(', ');
    selectedStudent.value = nameStudent;
    validateStudent.value = '';
  }

  addDataToStudent() async {
    var sleepTemp = List<HygieneTemp>.from(listSleepTemp);
    if(selectedStudent.value != ""){
      var checkedElements = listSleepTemp.where((element) => element.check == true).toList();
      for (var element in checkedElements) {
        element.note = noteAll;
        element.metadata = time.value;
      }
      listSleepTemp.value = sleepTemp;
      Get.back();
      await updateData();
      time.value = '';
      noteAll = TextEditingController();
      validateStudent.value = '';
      checkAll.value = false;
    }else{
      validateStudent.value = 'Vui lòng chọn học sinh';
    }
  }

  List<String> commentFormSleep = [
    'Bé hôm nay đã ngủ rất ngoan! Bố mẹ hãy nhớ khen bé khi bé về nhà nhé!',
    'Bé đã biết tự gấp gọn chăn màn và cất đi sau khi ngủ dậy! Bố mẹ hãy nhắc bé học tập thêm ở nhà nhé!'
  ];

  void initializeData() {
    selectedComment.value = List.generate(commentFormSleep.length, (_) => '');
    checkComment.value = List.generate(commentFormSleep.length, (_) => false);
  }

  toggleComment(int index, String comment) {
    if(checkComment[index] == false) {
      checkComment[index] = true;
      selectedComment[index] = comment;
    }else{
      checkComment[index] = false;
      selectedComment[index] = '';
    }
    updateNoteAll();
  }

  void updateNoteAll() {
    noteAll.text = selectedComment.join('\n');
  }

}
