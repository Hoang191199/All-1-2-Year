import 'package:mooc_app/domain/entities/login_history.dart';
import '../../domain/repositories/login_history_repository.dart';
import '../models/login_history_model.dart';
import '../providers/network/apis/login_history_api.dart';

class LoginHistoryRepositoryImpl extends LoginHistoryRepository {
  @override
  Future<LoginHistory> fetchLoginfo(page) async {
    final response = await LoginHistoryAPI.fetchLoginfo(page).request();
    print(response);
    return LoginHistoryModel.fromJson(response);
  }
}
