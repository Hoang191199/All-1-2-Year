import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/usecases/connect_noti_usecase.dart';


class ConnectNotiController extends GetxController {
  ConnectNotiController(this.connectNotiUseCase);

  final ConnectNotiUseCase connectNotiUseCase;

  final isLoading = false.obs;
  var responseData = Rx<ResponseData?>(null);

  fetchData(String fmcToken) async {
    isLoading(true);
    final data = await connectNotiUseCase.execute(fmcToken);
    responseData.value = data;
    isLoading(false);
  }
}
