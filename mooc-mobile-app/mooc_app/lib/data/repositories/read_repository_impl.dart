import 'package:mooc_app/domain/entities/list_noti.dart';
import '../../domain/entities/read_all_response.dart';
import '../../domain/repositories/read_repository.dart';
import '../models/list_noti_model.dart';
import '../models/read_all_model.dart';
import '../providers/network/apis/read_all_noti_api.dart';

class ReadRepositoryImpl extends ReadRepository {
  @override
  Future<ReadAll> fetchReadAll() async {
    final response = await ReadAPI.fetchReadAll().request();
    print(response);
    return ReadAllModel.fromJson(response);
  }
  @override
  Future<ListNoti> fetchUnread() async {
    final response = await ReadAPI.fetchUnread().request();
    print(response);
    return ListNotiModel.fromJson(response);
  }
}
