import 'dart:async';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class GetXNetworkManager extends GetxController {
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  int connectionType = 0;
  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();
  final isInitialized = false.obs;
  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription;
  @override
  void onInit() async {
    super.onInit();
    Future getConnect = getConnectionType();
    await Future.wait([getConnect]);
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
    isInitialized.value = true;
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> getConnectionType() async {
    ConnectivityResult connectivityResult = ConnectivityResult.none;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectivityResult);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        update();
        break;
      case ConnectivityResult.none:
        connectionType = 0;
        update();
        break;
      default:
        Get.snackbar('Lỗi kết nối', 'Không thể lấy được trạng thái kết nối');
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
