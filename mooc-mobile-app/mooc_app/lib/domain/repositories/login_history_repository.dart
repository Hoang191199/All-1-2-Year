import 'package:mooc_app/domain/entities/login_history.dart';

abstract class LoginHistoryRepository {
  Future<LoginHistory> fetchLoginfo(int page);
}