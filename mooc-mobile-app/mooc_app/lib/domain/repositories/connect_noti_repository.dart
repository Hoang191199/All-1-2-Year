import 'package:mooc_app/domain/entities/response_data.dart';

abstract class ConnectNotiRepository {
  Future<ResponseData> fetchConnectNoti(String fmcToken);
}
