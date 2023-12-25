import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/domain/entities/contact/contact.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/contact_repository.dart';

class ContactUseCase extends NoParamUseCase<ResponseDataObject<ContactData>> {
  ContactUseCase(this.contactUserRepository);

  final ContactRepository contactUserRepository;

  @override
  Future<ResponseDataObject<ContactData>> execute() {
    return contactUserRepository.fetchData();
  }
}
