import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/service/history_service_parent.dart';
import 'package:mobiedu_kids/domain/entities/service/item_child_service.dart';
import 'package:mobiedu_kids/domain/entities/service/services_countbased.dart';
import 'package:mobiedu_kids/domain/usecases/service_use_case.dart';

class ServiceParentController extends GetxController {
  ServiceParentController(this.fetch, this.register, this.history);
  final responseService = Rx<ResponseDataObject<ServicesCountbased>?>(null);
  final responseHistory = Rx<ResponseDataObject<HistoryServiceParent>?>(null);
  final isLoading = false.obs;
  final isLoadingRegister = false.obs;
  final isLoadingHistory = false.obs;
  late DateTime dateUsing;
  late DateTime dateHistory;
  late DateTime initDate;
  final tabs = 'using-service'.obs;
  final listItemSerivce = <ItemChildService>[].obs;
  DateTime firstDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime lastDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  ServiceParentUseCase fetch;
  RegisterServiceUseCase register;
  HistoryServiceParentUseCase history;

  @override
  void onInit() {
    dateUsing = DateTime.now();
    dateHistory = DateTime.now();
    initDate = DateTime.now();

    super.onInit();
  }

  fetchData() async {
    isLoading(true);

    final response = await fetch.execute();
    responseService.value = response;
    final itemServiceTemp = <ItemChildService>[];
    listItemSerivce.value = [];

    response.data?.services_countbased?.forEach((element) {
      itemServiceTemp.add(element.parseToItemChildService());
    });
    listItemSerivce.addAll(itemServiceTemp);

    isLoading(false);
  }

  registerService() async {
    isLoadingRegister(true);
    try {
      final response = await register.execute();
      if (response.code == 200) {
        showSnackbar(SnackbarType.success, "Thành công", "Đăng ký dịch vụ thành công!");
        await fetchData();
        await getHistory();
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Đăng ký dịch vụ thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Đăng ký dịch vụ thất bại!");
    }
    isLoading(false);
  }

  getHistory() async {
    isLoadingHistory(true);

    final response = await history.execute();
    responseHistory.value = response;

    isLoadingHistory(false);
  }
}
