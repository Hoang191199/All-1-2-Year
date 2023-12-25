import 'package:mooc_app/data/models/list_noti_mooc_model.dart';
import 'package:mooc_app/data/providers/network/apis/list_noti_mooc_api.dart';
import 'package:mooc_app/domain/entities/list_noti_mooc.dart';
import 'package:mooc_app/domain/repositories/list_noti_mooc_repository.dart';

class ListNotiMoocRepositoryImpl extends ListNotiMoocRepository {
  @override
  Future<ListNotiMooc> fetchNoti(int page, int per_page) async {
    final response = await ListNotiMoocAPI.fetchNoti(page, per_page).request();
    print(response);
    return ListNotiMoocModel.fromJson(response);
  }
}
