import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/rest/rest_data.dart';
import 'package:mobiedu_kids/domain/usecases/rest_use_case.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/rest/rest_page.dart';

class RestController extends GetxController {
  RestController(this.fetch, this.register);

  final responseRest = Rx<ResponseDataObject<RestData>?>(null);
  final isLoading = false.obs;
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now();
  DateTime dateNow = DateTime.now();
  dynamic colorDateNow;
  late DateTime firstDayOfMonth;
  late DateTime lastDayOfMonth;
  final note = TextEditingController();
  final groupNote = ''.obs;
  final checkNote = <bool>[].obs;
  int selectedChildIndex = -1;

  RestUseCase fetch;
  RestRegisterUseCase register;

  @override
  void onInit() {
    firstDayOfMonth = DateTime(dateNow.year, dateNow.month, 1);
    lastDayOfMonth = DateTime(dateNow.year, dateNow.month + 1, 0);
    checkNote.value = List.generate(listNote.length, (_) => false);
    super.onInit();
  }

  fetchData() async {
    isLoading(true);
    final response = await fetch.execute(Tuple2(convertDateTimeToString(firstDayOfMonth),convertDateTimeToString(lastDayOfMonth)));
    responseRest.value = response;
    responseRest.value?.data?.attendance?.forEach((item) {
      if (item.attendance_date == convertDateTimeToString(dateNow)) {
        colorDateNow = checkColor(item.status ?? '0', item.is_checked ?? '0', item.feedback ?? '1');
      }
    });
    isLoading(false);
  }

  void toggleCheck(int index) {
    for (var i = 0; i < checkNote.length; i++) {
      checkNote[i] = (i == index);
      selectedChildIndex = index;
      if (index >= 0 && index < listNote.length) {
        note.text = listNote[index].title;
      }
    }
  }

  List<ListNote> listNote = [
    ListNote(title: 'Con bị ốm', check: false),
    ListNote(title: 'Gia đình có việc riêng', check: false),
    ListNote(title: 'Về quê', check: false),
  ];

  actionRegister() async {
    final response = await register.execute();
    if (response.code == 200) {
      showSnackbar(SnackbarType.success, "Thành công", "Gửi đơn xin nghỉ thành công!");
      await fetchData();
      note.text = '';
      checkNote.value = List.generate(listNote.length, (_) => false);
      firstDate = DateTime.now();
      lastDate = DateTime.now();
    }else{
      showSnackbar(SnackbarType.error, "Thất bại", "Gửi đơn xin nghỉ thật bại!");
    }
  }
}

class ListNote {
  String title;
  bool check;
  ListNote({required this.title, required this.check});
}
