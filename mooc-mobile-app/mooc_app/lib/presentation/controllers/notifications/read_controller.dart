import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/usecases/list_unread_use_case.dart';

import '../../../domain/entities/list_noti.dart';
import '../../../domain/entities/read_all_response.dart';
import '../../../domain/usecases/read_all_use_case.dart';

class ReadController extends GetxController {
  ReadController(this.readAllMoocUseCase, this.unreadUseCase);
  final ReadAllUseCase readAllMoocUseCase;
  final UnreadUseCase unreadUseCase;
  final isLoading = false.obs;
  var res = Rx<ReadAll?>(null);
  var res2 = Rx<ListNoti?>(null);
  final unread = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    listUnread();
  }

  readAll() async {
    isLoading(true);
    final response = await readAllMoocUseCase.execute();
    res.value = response;
    isLoading(false);
  }

  listUnread() async{
    isLoading(true);
    final response = await unreadUseCase.execute();
    res2.value = response;
    unread.value = res2.value?.notifications?.unread ?? 0;
    isLoading(false);
  }
}
