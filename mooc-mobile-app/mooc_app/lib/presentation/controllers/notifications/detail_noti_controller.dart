import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/detail_noti.dart';

import '../../../domain/usecases/detail_noti_use_case.dart';

class DetailNotiController extends GetxController {
  DetailNotiController(this.detailNotiUseCase);

  final DetailNotiUseCase detailNotiUseCase;
  var isLoadMore = false;
  final isLoading = false.obs;
  var detailNotiData = Rx<DetailNoti?>(null);

  fetchDetailData(String id) async {
    isLoading(true);
    detailNotiData.value = null;
    final data = await detailNotiUseCase.execute(id);
    detailNotiData.value = data;
    isLoading(false);
  }
}
