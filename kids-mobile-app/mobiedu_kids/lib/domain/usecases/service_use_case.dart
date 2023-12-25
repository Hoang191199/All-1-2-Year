import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/entities/service/history_data.dart';
import 'package:mobiedu_kids/domain/entities/service/history_service_parent.dart';
import 'package:mobiedu_kids/domain/entities/service/list_usage.dart';
import 'package:mobiedu_kids/domain/entities/service/services_countbased.dart';
import 'package:mobiedu_kids/domain/repositories/service_repository.dart';

class ServiceUseCase extends NoParamUseCase<ResponseDataObject<ListUsage>> {
  ServiceUseCase(this.serviceRepository);

  final ServiceRepository serviceRepository;

  @override
  Future<ResponseDataObject<ListUsage>> execute() {
    return serviceRepository.fetchData();
  }
}

class UpdateServiceUseCase extends NoParamUseCase<ResponseNoData> {
  UpdateServiceUseCase(this.updateRepository);

  final ServiceRepository updateRepository;

  @override
  Future<ResponseNoData> execute() {
    return updateRepository.update();
  }
}

class HistoryUseCase extends NoParamUseCase<ResponseDataObject<HistoryData>> {
  HistoryUseCase(this.historyRepository);

  final ServiceRepository historyRepository;

  @override
  Future<ResponseDataObject<HistoryData>> execute() {
    return historyRepository.history();
  }
}

class ServiceParentUseCase extends NoParamUseCase<ResponseDataObject<ServicesCountbased>> {
  ServiceParentUseCase(this.serviceParentRepository);

  final ServiceRepository serviceParentRepository;

  @override
  Future<ResponseDataObject<ServicesCountbased>> execute() {
    return serviceParentRepository.serviceParent();
  }
}

class RegisterServiceUseCase extends NoParamUseCase<ResponseNoData> {
  RegisterServiceUseCase(this.registerRepository);

  final ServiceRepository registerRepository;

  @override
  Future<ResponseNoData> execute() {
    return registerRepository.register();
  }
}

class HistoryServiceParentUseCase extends NoParamUseCase<ResponseDataObject<HistoryServiceParent>> {
  HistoryServiceParentUseCase(this.historyServiceParentRepository);

  final ServiceRepository historyServiceParentRepository;

  @override
  Future<ResponseDataObject<HistoryServiceParent>> execute() {
    return historyServiceParentRepository.historyParent();
  }
}
