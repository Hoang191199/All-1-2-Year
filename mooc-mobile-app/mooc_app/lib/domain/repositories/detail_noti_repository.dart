import 'package:mooc_app/domain/entities/detail_noti.dart';

abstract class DetailNotiRepository {
  Future<DetailNoti> fetchNoti(String id);
}
