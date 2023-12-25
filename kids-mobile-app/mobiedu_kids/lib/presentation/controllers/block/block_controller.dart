import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/members_info.dart';
import 'package:mobiedu_kids/domain/usecases/block_use_case.dart';

class BlockController extends GetxController {
  BlockController(
    this.listBlockUseCase,
    this.unblockUseCase,
  );

  ListBlockUseCase listBlockUseCase;
  UnblockUseCase unblockUseCase;
  var listBlockUser = RxList<MembersInfo>([]);
  final isLoading = false.obs;
  final isDetailLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  list(int page) async {
    isLoading(true);
    final res = await listBlockUseCase.execute(page);
    if (res.code == 200) {
      listBlockUser.assignAll(res.data?.blocks ?? []);
    }
    isLoading(false);
  }

  unblock(String friend_id) async {
    isDetailLoading(true);
    final res = await unblockUseCase.execute(friend_id);
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Bỏ chặn thành công", res.message ?? "");
    } else {
      showSnackbar(
          SnackbarType.error, "Bỏ chặn không thành công", res.message ?? "");
    }
    isDetailLoading(false);
  }
}
