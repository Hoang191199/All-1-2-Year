import 'package:mooc_app/domain/entities/list_noti_mooc.dart';

abstract class ListNotiMoocRepository {
  Future<ListNotiMooc> fetchNoti(int page, int per_page);
}
