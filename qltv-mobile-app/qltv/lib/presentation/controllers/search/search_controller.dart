import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qltv/app/config/app_common.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/search.dart';
import 'package:qltv/domain/entities/search_paging.dart';
import 'package:qltv/domain/usecases/add_to_bookcase_use_case.dart';
import 'package:qltv/domain/usecases/interactives_use_case.dart';
import 'package:qltv/domain/usecases/register_publication.dart';
import 'package:qltv/domain/usecases/search_user_case.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';

class SearchController extends GetxController {
  SearchController(this.searchUseCase, this.registerPublicationUseCase, this.addToBookCase, this.interactives);

  final SearchUseCase searchUseCase;
  final RegisterPublicationUseCase registerPublicationUseCase;
  final AddToBookCaseUseCase addToBookCase;
  final InteractivesUseCase interactives;

  final indexLabelFocus = 0.obs;
  final labelFocus = 'title'.obs;
  final searchType = BookcaseType.publications.obs;
  final isLoading = false.obs;
  final quantity = 1.obs;
  final getDate = DateTime.now().add(const Duration(days: 1)).obs;
  var isLoadMore = false;
  int current = 1;
  int pageSize = 9;
  var responseData = Rx<ResponseDataObject<SearchPaging<Search>>?>(null);
  var searchData = RxList<Search?>([]);
  var searchPagingData = RxInt(0);
  var paging = Rx<SearchPaging<Search>?>(null);
  final auth = Get.find<LoginController>();

  late TextEditingController searchInputController;
  late TextEditingController pickDate;

  @override
  void onInit() {
    searchInputController = TextEditingController(text: '');
    pickDate = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(getDate.value));
    super.onInit();
  }

  changeSearchType(String type) {
    searchType.value = type;
    indexLabelFocus.value = 0;
    if (searchInputController.text != '') {
      fetchData('title');
    } else {
      fetchData('');
    }
  }

  changeIndexLabelFocus(int index) {
    indexLabelFocus.value = index;
    switch (index) {
      case 0:
        return fetchData("title");
      case 1:
        return fetchData("chude");
      case 2:
        return fetchData("author");
      case 3:
        return fetchData("model");
      case 4:
        return fetchData("subject");
      case 5:
        return fetchData("publication_year");
      case 6:
        return fetchData("isbn");
      default:
        return fetchData("title");
    }
  }

  fetchData(String titleLabel) async {
    isLoading(true);
    current = 1;
    final response = await searchUseCase.execute(Tuple5(searchType.value,
        titleLabel, searchInputController.text, current, pageSize));
    responseData.value = response;
    searchData.assignAll(response.data?.data ?? []);
    responseData.value = response;
    searchPagingData.value = response.data?.total ?? 0;
    paging.value = response.data;
    isLoading(false);
  }

  loadMore() async {
    final total = searchPagingData.value;
    if (total / pageSize <= current) return;
    if (isLoadMore) return;
    isLoadMore = true;
    current += 1;
    final dataList = await searchUseCase.execute(Tuple5(searchType.value,
        labelFocus.value, searchInputController.text, current, pageSize));
    searchData.addAll(dataList.data?.data ?? []);
    paging.value?.total = dataList.data?.total;
    isLoadMore = false;
  }

  register(
    int? idItem,
    String? type,
    BuildContext context,
  ) async {
    final response = await registerPublicationUseCase.execute(Tuple4(quantity.value, idItem, pickDate.text, type));
    if (response.code == 401) {
      auth.logout();
      showSnackbar(SnackbarType.notice, "log-out".tr, "session-time-out".tr);
      Get.back();
    } else if (response.error != null && response.error == false) {
      showSnackbar(
          SnackbarType.success, "success".tr, "register-bookcase-success".tr);
      Navigator.pop(context);
      pickDate.text = DateFormat('dd/MM/yyyy').format(getDate.value);
      quantity.value = 1;
    } else {
      showSnackbar(
          SnackbarType.error, "register-bookcase".tr, response.message ?? "date-constraint".tr);
    }
  }

  add(
    int idItem,
    BuildContext context,
  ) async {
    final response = await addToBookCase.execute(idItem);
    if (response.code == 401) {
      auth.logout();
      showSnackbar(SnackbarType.notice, "log-out".tr, "session-time-out".tr);
      Get.back();
    } else if (response.error != null && response.error == false) {
      showSnackbar(
          SnackbarType.success, "success".tr, "add-to-bookcase-success".tr);
    } else {
      showSnackbar(SnackbarType.error, "failure".tr, response.message ?? 'add-to-bookcase-failure'.tr);
    }
  }

  seen(
    int idItem,
  ) async {
    final response = await interactives.execute(idItem);
    if (response.code == 401) {
      auth.logout();
      showSnackbar(SnackbarType.notice, "log-out".tr, "session-time-out".tr);
      Get.back();
    }
  }
}
