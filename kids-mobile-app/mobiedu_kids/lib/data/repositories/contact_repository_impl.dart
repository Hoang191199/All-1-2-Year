import 'package:mobiedu_kids/data/providers/network/apis/contact_api.dart';
import 'package:mobiedu_kids/domain/entities/contact/contact.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl extends ContactRepository {

  @override
  Future<ResponseDataObject<ContactData>> fetchData() async {
    final response = await ContactAPI.fetchData().request();
    return ResponseDataObject<ContactData>.fromJson(response, (data) => ContactData.fromJson(data));
  }
}