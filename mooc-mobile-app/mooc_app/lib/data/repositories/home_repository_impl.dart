import 'package:mooc_app/data/providers/network/apis/home_api.dart';
import 'package:mooc_app/domain/entities/home.dart';
import 'package:mooc_app/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<Home> fetchHome() async {
    final response = await HomeAPI.fetchHome().request();
    return Home.fromJson(response);
  }
  
}