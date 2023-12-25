import 'package:get/get.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/data_tuitions.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuition_childs.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions_item.dart';
import 'package:mobiedu_kids/domain/usecases/tuitions/tuitions_detail_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/tuitions/tuitions_item_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/tuitions/tuitions_use_case.dart';

class TuitionsController extends GetxController {
  TuitionsController(this.tuitions, this.tuitionsDetails, this.tuitionsItems);
  var responseTuitions = Rx<ResponseDataObject<Tuitions>?>(null);
  var responseTuitionsDetail = Rx<ResponseDataObject<TuitionChilds>?>(null);
  var responseTuitionsItem = Rx<ResponseDataObject<TuitionItems>?>(null);
  var tuitionsData = RxList<DataTuitions?>([]);
  final isLoading = false.obs;
  final isLoadingDetail= false.obs;
  final isLoadingItem = false.obs;
  final isLoadMore = false.obs;
  int page = 0;

  final TuitionsUserCase tuitions;
  final TuitionsDetailUserCase tuitionsDetails;
  final TuitionsItemUserCase tuitionsItems;

  responsetuitions() async {
    isLoading(true);
    final response = await tuitions.execute(page);
    responseTuitions.value = response;
    tuitionsData.assignAll(response.data?.tuitions ?? []);
    isLoading(false);
  }

  tuitionsDetail(int tuitions_id) async{
    isLoadingDetail(true);
    final responseDetail = await tuitionsDetails.execute(tuitions_id);
    responseTuitionsDetail.value = responseDetail;
    isLoadingDetail(false);
  }

  tuitionsItem(int tuition_child_id) async {
    isLoadingItem(true);
    final responseItem = await tuitionsItems.execute(tuition_child_id);
    responseTuitionsItem.value = responseItem;
    isLoadingItem(false);
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
}