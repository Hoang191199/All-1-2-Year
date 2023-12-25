import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/pages/init/init_page.dart';

import '../../domain/entities/login_info.dart';
import '../../domain/entities/paging_mooc.dart';
import 'history/login_history_controller.dart';

class ScrollingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ScrollingController({required this.page, required this.height});
  int page;
  double height;
  late ScrollController? scrollController;
  late ScrollController? scrollController2;
  var paging = Rx<PagingMooc?>(null);
  var loginData = Rx<List<LogInfo>>([]);
  final loginfo = Get.find<LoginHistoryController>();
  final isInitialized = false.obs;
  RxBool showButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollInitilization();
    scrollExtend();
  }

  scrollInitilization() {
    scrollController = ScrollController();
    if(scrollController!.hasClients) {
      if (scrollController!.position.pixels >= 150.0) {
        showButton.value = true;
      }
      else {
        showButton.value = false;
      }
    }
  }

  scrollExtend() async{
    scrollController2 = ScrollController();
    scrollController2?.addListener((){_scrollmanager();});
    await loginfo.fetchData(page);
    paging.value = loginfo.paging.value;
    loginData.value.addAll(loginfo.loginData.value);
    print("done");
    isInitialized(true);
  }

  _scrollmanager() async {
    if(page < loginfo.paging.value!.last_page) {
      if (scrollController2!.position.extentAfter < height) {
        await loginfo.fetchData(page + 1);
        paging.value = loginfo.paging.value;
        loginData.value.addAll(loginfo.loginData.value);
        page = page + 1;
      }
    }
  }
}
