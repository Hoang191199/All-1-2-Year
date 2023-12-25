import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/service/history_data.dart';
import 'package:mobiedu_kids/domain/entities/service/item_child.dart';
import 'package:mobiedu_kids/domain/entities/service/list_usage.dart';
import 'package:mobiedu_kids/domain/usecases/service_use_case.dart';

class ServiceController extends GetxController {
  ServiceController(this.service, this.updated, this.history);
  final responseService = Rx<ResponseDataObject<ListUsage>?>(null);
  final responseHistory = Rx<ResponseDataObject<HistoryData>?>(null);
  final isLoading = false.obs;
  final isLoadingUpdate = false.obs;
  final isLoadingHistory = false.obs;
  late DateTime dateUsing;
  late DateTime dateHistory;
  final listItemChild = <ItemChild>[].obs;
  final tabs = 'using-service'.obs;
  final isShow = <RxBool>[].obs;

  final ServiceUseCase service;
  final UpdateServiceUseCase updated;
  final HistoryUseCase history;

  @override
  void onInit() {
    dateUsing = DateTime.now();
    dateHistory = DateTime.now();

    super.onInit();
  }

  fetchData() async {
    isLoading(true);

    final response = await service.execute();
    responseService.value = response;
    final itemchildTemp = <ItemChild>[];
    listItemChild.value = [];

    response.data?.list_usage?.forEach((element) {
      itemchildTemp.add(element.parseToItemChild());
    });
    listItemChild.addAll(itemchildTemp);

    isLoading(false);
  }

  updateService() async {
    isLoadingUpdate(true);

    try {
      final response = await updated.execute();
      if (response.code == 200) {
        showSnackbar(SnackbarType.success, "Thành công", "Cập nhật thông tin thành công!");
        await fetchData();
        await historyService();
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Cập nhật thông tin thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Cập nhật thông tin thất bại!");
    }

    isLoadingUpdate(false);
  }

  historyService() async {
    isLoadingHistory(true);

    try {
      final response = await history.execute();
      responseHistory.value = response;
    } catch (error) {
      responseHistory.value = null;
    }

    isLoadingHistory(false);
  }

  toggleShow(int index) {
    isShow[index].value = !isShow[index].value;
  }
}
