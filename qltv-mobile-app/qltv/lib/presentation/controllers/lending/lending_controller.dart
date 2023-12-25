import 'package:get/get.dart';
import 'package:qltv/domain/entities/lend_mid_data.dart';
import '../../../domain/entities/lend_details.dart';
import '../../../domain/entities/mid_array_data.dart';
import '../../../domain/entities/response_data_object.dart';
import '../../../domain/usecases/lending_use_case.dart';

class LendingController extends GetxController {
  LendingController(this.lendingUseCase);

  final LendingUseCase lendingUseCase;
  int currentPage = 1;
  int pageSize = 12;
  final isLoading = false.obs;
  var isLoadMore = false;
  var responseData = RxList<LendDetails>([]);
  var responseNonFlatData = RxList<LendingMidData>([]);
  var res = Rx<ResponseDataObject<MidArrayData>?>(null);
  final error = false.obs;
  final code = 0.obs;

  fetchData() async {
    isLoading(true);
    currentPage = 1;
    responseData.value = [];
    final response = await lendingUseCase.execute();
    code.value = response.code ?? 0;
    error.value = response.error ?? true;
    responseNonFlatData.addAll(response.data?.data ?? []);
    var num = Iterable<int>.generate(responseNonFlatData.length).toList();
    for (var i in num) {
      responseData.addAll(response.data?.data?[i].items ?? []);
    }
    if (responseData.length >= 2) {
      responseData.sort((a, b) {
        return a.receipt_date!.compareTo(b.receipt_date!);
      });
    }
    res.value = response;
    isLoading(false);
  }
}
