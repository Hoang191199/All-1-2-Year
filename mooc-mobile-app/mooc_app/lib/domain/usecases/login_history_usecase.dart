import '../../app/core/usecases/pram_usecase.dart';
import '../entities/login_history.dart';
import '../repositories/login_history_repository.dart';

class LoginHistoryUseCase extends ParamUseCase<LoginHistory, int> {
  LoginHistoryUseCase(this.loginHistroyRepository);

  final LoginHistoryRepository loginHistroyRepository;

  @override
  Future<LoginHistory> execute(params) {
    return loginHistroyRepository.fetchLoginfo(params);
  }
}
