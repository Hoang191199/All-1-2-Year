import '../../domain/entities/mid_array_data.dart';
import '../../domain/entities/noti_data.dart';
import '../../domain/entities/response_data_object.dart';
import '../../domain/repositories/noti_repository.dart';
import '../providers/network/apis/notification_api.dart';

class NotiRepositoryImpl extends NotiRepository {
  @override
  Future<ResponseDataObject<MidArrayData<NotiData>>> fetchNoti(
      int page, int pageSize) async {
    final response = await NotiAPI.fetchNoti(page, pageSize).request();
    return ResponseDataObject<MidArrayData<NotiData>>.fromJson(
        response,
        (data) =>
            MidArrayData<NotiData>.fromJson(data, (d) => NotiData.fromJson(d)));
  }
}
