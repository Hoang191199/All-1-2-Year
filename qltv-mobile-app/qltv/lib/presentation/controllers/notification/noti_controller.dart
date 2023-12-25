import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:qltv/domain/entities/noti_data.dart';
import '../../../domain/entities/mid_array_data.dart';
import '../../../domain/entities/response_data_object.dart';
import '../../../domain/usecases/noti_use_case.dart';

class NotiController extends GetxController {
  NotiController(this.notiUseCase);

  final NotiUseCase notiUseCase;
  int currentPage = 1;
  int pageSize = 12;
  final isLoading = false.obs;
  var isLoadMore = false;
  var responseData = RxList<NotiData>([]);
  var res = Rx<ResponseDataObject<MidArrayData>?>(null);
  final error = false.obs;
  final code = 0.obs;

  fetchData() async {
    isLoading(true);
    currentPage = 1;
    responseData.value = [];
    final response = await notiUseCase.execute(Tuple2(currentPage, pageSize));
    code.value = response.code ?? 0;
    error.value = response.error ?? true;
    responseData.addAll(response.data?.data ?? []);
    res.value = response;
    isLoading(false);
  }

  loadMore() async {
    final total = res.value?.data?.total ?? 0;
    if (total / pageSize <= currentPage) return;
    if (isLoadMore) return;
    isLoadMore = true;
    currentPage += 1;
    final response2 = await notiUseCase.execute(Tuple2(currentPage, pageSize));
    responseData.addAll(response2.data?.data ?? []);
    isLoadMore = false;
  }

}