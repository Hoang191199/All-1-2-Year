import 'package:mooc_app/data/providers/network/apis/connect_noti_api.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/repositories/connect_noti_repository.dart';

import '../../app/config/app_constants.dart';

class ConnectNotiRepositoryImpl extends ConnectNotiRepository {
  @override
  Future<ResponseData> fetchConnectNoti(String fmcToken) async {
    final response = await ConnectNotiAPI.fetchConnectNoti(fmcToken).request();
    return ResponseData.fromJson(response, DataType.typeString);
  }
}
