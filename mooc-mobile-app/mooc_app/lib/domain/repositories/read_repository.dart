import 'package:mooc_app/domain/entities/read_all_response.dart';
import '../entities/list_noti.dart';

abstract class ReadRepository {
  Future<ReadAll> fetchReadAll();
  Future<ListNoti> fetchUnread();
}