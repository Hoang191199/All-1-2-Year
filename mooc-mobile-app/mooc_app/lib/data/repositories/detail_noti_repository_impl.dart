import 'package:mooc_app/domain/entities/detail_noti.dart';

import '../../domain/entities/list_noti.dart';
import '../../domain/repositories/detail_noti_repository.dart';
import '../models/detail_noti_model.dart';
import '../providers/network/apis/detail_noti_api.dart';

class DetailNotiRepositoryImpl extends DetailNotiRepository {
  @override
  Future<DetailNoti> fetchNoti(String id) async {
    final response = await DetailNotiAPI.fetchNoti(id).request();
    print(response);
    return DetailNotiModel.fromJson(response);
  }
}
