import 'package:get/get.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/data_tuitions.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions_item.dart';
import 'package:mobiedu_kids/domain/usecases/tuitions/tuitions_use_case.dart';

class TuitionsParentController extends GetxController {
  TuitionsParentController(this.tuitions, this.detail);
  var responseTuitions = Rx<ResponseDataObject<Tuitions>?>(null);
  var responseTuitionsItem = Rx<ResponseDataObject<TuitionItems>?>(null);
  var tuitionsData = RxList<DataTuitions?>([]);
  final isLoading = false.obs;
  final isLoadingDetail = false.obs;
  final isLoadMore = false.obs;
  int page = 0;

  final TuitionsParentUseCase tuitions;
  final TuitionsParentDetailUseCase detail;

  fetchData() async {
    isLoading(true);
    final response = await tuitions.execute(page);
    responseTuitions.value = response;
    tuitionsData.assignAll(response.data?.tuitions ?? []);
    isLoading(false);
  }

  loadMore() async {
    if (isLoadMore.value) return;
    isLoadMore(true);
    page += 1;
    final response = await tuitions.execute(page);
    responseTuitions.value = response;
    if (response.code == 200) {
      tuitionsData.addAll(response.data?.tuitions ?? []);
    } else {
      page -= 1;
    }
    isLoadMore(false);
  }

  getDetail(int id) async {
    isLoadingDetail(true);
    final responseDetail = await detail.execute(id);
    responseTuitionsItem.value = responseDetail;
    isLoadingDetail(false);
  }
}
