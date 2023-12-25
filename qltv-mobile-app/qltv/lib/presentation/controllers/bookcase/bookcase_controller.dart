import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/domain/entities/response_data_array_object.dart';
import 'package:qltv/domain/usecases/bookcase_lastseen_use_case.dart';
import 'package:qltv/domain/usecases/bookcase_use_case.dart';

class BookcaseController extends GetxController {
  BookcaseController(
    this.bookcaseUseCase,
    this.bookcaseLastseenUseCase,
  );

  final BookcaseUseCase bookcaseUseCase;
  final BookcaseLastseenUseCase bookcaseLastseenUseCase;
  
  final bookcaseType = BookcaseType.digital_publications.obs;
  final bookcaseViewType = BookcaseViewType.grid.obs;
  final bookcaseSortType = BookcaseSortType.title.obs;
  final bookcaseFilterType = [BookcaseFilterType.notRead, BookcaseFilterType.reading, BookcaseFilterType.readCompleted].obs;
  final isLoading = false.obs;
  final isLoadingLastseen = false.obs;
  var isLoadMore = false;
  int current = 1;
  int pageSize = 9;
  var responseData = Rx<ResponseDataArrayObject<Bookcase>?>(null);
  var bookcasesData = RxList<Bookcase?>([]);
  var responseDataLastseen = Rx<ResponseDataArrayObject<Bookcase>?>(null);
  var bookcasesDataLastseen = RxList<Bookcase?>([]);

  late TextEditingController searchInputController;

  @override
  void onInit() {
    searchInputController = TextEditingController(text: '');
    super.onInit();
  }

  changeBookcaseType(String type) {
    bookcaseType.value = type;
    fetchData();
  }

  changeBookcaseViewType(String view) {
    bookcaseViewType.value = view;
  }

  changeBookcaseSortType(String type) {
    bookcaseSortType.value = type;
  }

  changeBookcaseFilterType(int type) {
    if (bookcaseFilterType.contains(type)) {
      bookcaseFilterType.removeWhere((item) => item == type);
    } else {
      bookcaseFilterType.add(type);
    }
  }

  fetchData() async {
    isLoading(true);
    current = 1;
    bookcasesData.value = [];
    final response = await bookcaseUseCase.execute(Tuple6(current, pageSize, searchInputController.text, bookcaseType.value, bookcaseSortType.value, bookcaseFilterType.value));
    responseData.value = response;
    bookcasesData.assignAll(response.data?.data ?? []);
    isLoading(false);
  }

  loadMore() async {
    final total = responseData.value?.data?.total ?? 0;
    if (total / pageSize <= current) return;
    if (isLoadMore) return;
    isLoadMore = true;
    current += 1;
    final response = await bookcaseUseCase.execute(Tuple6(current, pageSize, searchInputController.text, bookcaseType.value, bookcaseSortType.value, bookcaseFilterType.value));
    bookcasesData.addAll(response.data?.data ?? []);
    responseData.value?.data?.total = response.data?.total;
    isLoadMore = false;
  }

  fetchDataLastseen() async {
    isLoadingLastseen(true);
    bookcasesDataLastseen.value = [];
    final response = await bookcaseLastseenUseCase.execute();
    responseDataLastseen.value = response;
    bookcasesDataLastseen.assignAll(response.data?.data ?? []);
    isLoadingLastseen(false);
  }
}