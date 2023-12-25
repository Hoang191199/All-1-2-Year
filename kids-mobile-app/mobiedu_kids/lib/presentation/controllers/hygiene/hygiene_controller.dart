import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/attendance/hygiene_temp.dart';
import 'package:mobiedu_kids/domain/entities/attendance/listChild.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/usecases/attendance_use_case.dart';

class HygieneController extends GetxController {
  HygieneController(this.getHygiene, this.updateHygiene);

  final responseHygiene = Rx<ResponseDataObject<ListChild>?>(null);
  final isLoading = false.obs;
  final isLoadingupdate = false.obs;
  final listHygieneTemp = <HygieneTemp>[].obs;
  final checkAll = false.obs;
  final numberUsing = 0.obs;
  late TextEditingController noteAll;
  final selectedStudent = ''.obs;
  final validateSelectedStudent = ''.obs;
  final valiteUsePoo = ''.obs;
  final selectedComment = <String>[].obs;
  final checkComment = <bool>[].obs;

  final HygieneUserCase getHygiene;
  final UpdateHygieneUserCase updateHygiene;

  @override
  void onInit() {
    noteAll = TextEditingController();
    initializeData();
    super.onInit();
  }

  fetchData() async {
    isLoading(true);

    final response = await getHygiene.execute();
    responseHygiene.value = response;
    final hygieneTemp = <HygieneTemp>[];
    listHygieneTemp.value = [];

    response.data?.listChild?.forEach((element) {
      hygieneTemp.add(element.parseToHygieneTemp());
    });
    listHygieneTemp.addAll(hygieneTemp);

    isLoading(false);
  }

  checkAllData(bool value) {
    if (value == true) {
      for (var element in listHygieneTemp) {
        element.check = true;
      }
    } else {
      for (var element in listHygieneTemp) {
        element.check = false;
      }
    }
  }

  showCheckAll(bool value) {
    var legthData = listHygieneTemp.where((element) => element.check == true).length;
    if(legthData == listHygieneTemp.length){
      checkAll.value = true;
    }
  }

  increaseUsing(String number, int index) {
    var data = int.parse(number);
    if(data < 99){
      data++;
      listHygieneTemp[index].metadata = data.toString();
    }
  }

  decreaseUsing(String number, int index) {
    var data = int.parse(number);
    if (data != 0) {
      data--;
    }
    listHygieneTemp[index].metadata = data.toString();
  }

  increaseUsingAll() {
    numberUsing.value++;
  }

  decreaseUsingAll() {
    if (numberUsing.value != 0) {
      numberUsing.value--;
    }
  }

  listName(){
    var checkedElements = listHygieneTemp.where((element) => element.check == true).toList();
    var nameStudent = checkedElements.map((element) => element.student?.child_name).join(', ');
    selectedStudent.value = nameStudent;
    validateSelectedStudent.value = '';
  }

  addDataToStudent() async {
    var hygieneTemp = List<HygieneTemp>.from(listHygieneTemp);
    if(selectedStudent.value != ""){
      if(numberUsing.value < 99){
        var checkedElements = listHygieneTemp.where((element) => element.check == true).toList();
        for (var element in checkedElements) {
          element.note = noteAll;
          element.metadata = numberUsing.value.toString();
        }
        listHygieneTemp.value = hygieneTemp;
        Get.back();
        await updateData();
        numberUsing.value = 0;
        noteAll = TextEditingController();
        validateSelectedStudent.value = '';
        checkAll.value = false;
         valiteUsePoo.value = '';
      }else{
        valiteUsePoo.value = 'Số lần sử dụng không quá 99 lần';
      }
    }else{
      validateSelectedStudent.value = 'Vui lòng chọn học sinh';
    }
  }

  updateData() async {
    isLoadingupdate(true);
    try {
      final response = await updateHygiene.execute();
      if (response.code == 200) {
        showSnackbar(SnackbarType.success, "Thành công", "Cập nhật thông tin thành công!");
        checkComment.value = List.generate(commentFormHygiene.length, (_) => false);
        selectedComment.value = List.generate(commentFormHygiene.length, (_) => '');
        await fetchData();
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Cập nhật thông tin thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Cập nhật thông tin thất bại!");
    }
    isLoadingupdate(false);
  }

  
  List<String> commentFormHygiene = [
    'Bé hôm nay đã đi vệ sinh 3 lần',
    'Bé đã biết gọi cô khi cần đi vệ sinh'
  ];

  void initializeData() {
    selectedComment.value = List.generate(commentFormHygiene.length, (_) => '');
    checkComment.value = List.generate(commentFormHygiene.length, (_) => false);
  }

  toggleComment(int index, String comment) {
    if (checkComment[index] == false) {
      checkComment[index] = true;
      selectedComment[index] = comment;
    } else {
      checkComment[index] = false;
      selectedComment[index] = '';
    }
    updateNoteAll();
  }

  void updateNoteAll() {
    noteAll.text = selectedComment.join('\n');
  }
}
