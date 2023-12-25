import '../../app/core/usecases/no_param_usecase.dart';
import '../entities/list_noti.dart';
import '../repositories/read_repository.dart';

class UnreadUseCase extends NoParamUseCase<ListNoti> {
  UnreadUseCase(this.unreadRepository);

  final ReadRepository  unreadRepository;

  @override
  Future<ListNoti> execute() {
    return unreadRepository.fetchUnread();
  }
}
