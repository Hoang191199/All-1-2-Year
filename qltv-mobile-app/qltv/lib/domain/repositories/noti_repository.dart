import 'package:qltv/domain/entities/noti_data.dart';

import '../entities/mid_array_data.dart';
import '../entities/response_data_object.dart';

abstract class NotiRepository {
  Future<ResponseDataObject<MidArrayData<NotiData>>> fetchNoti(int page,int pageSize);
}