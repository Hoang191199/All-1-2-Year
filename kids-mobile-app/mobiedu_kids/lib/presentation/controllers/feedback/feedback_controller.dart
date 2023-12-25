import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/usecases/feedback_use_case.dart';

class FeedbackController extends GetxController {
  FeedbackController(this.fbCreateUseCase);

  final FbCreateUseCase fbCreateUseCase;
  final isLoading = false.obs;
  final isIncognito = false.obs;
  late TextEditingController content;

  @override
  void onInit() async {
    content = TextEditingController(text: "");
    super.onInit();
  }

  create(String incognito, String child_id, String content) async {
    isLoading(true);
    final res =
        await fbCreateUseCase.execute(Tuple3(incognito, child_id, content));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Tạo thành công", res.message ?? "");
    } else {
      showSnackbar(SnackbarType.error, "Thử lại", res.message ?? "");
    }
    isLoading(false);
  }
}
