import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/domain/entities/list_children.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/prescription_repository.dart';

class ShowChildActiveUserCase extends NoParamUseCase<ResponseDataObject<ListChildren>> {
  ShowChildActiveUserCase(this.showChildActiveRepository);

  final PrescriptionRepository showChildActiveRepository;

  @override
  Future<ResponseDataObject<ListChildren>> execute() {
    return showChildActiveRepository.showChildActive();
  }
}
