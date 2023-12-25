import 'package:mobiedu_kids/domain/entities/contact/contact.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';

abstract class ContactRepository {
  Future<ResponseDataObject<ContactData>> fetchData();
}
