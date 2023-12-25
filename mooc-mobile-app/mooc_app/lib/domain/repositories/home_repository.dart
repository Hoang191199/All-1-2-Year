import 'package:mooc_app/domain/entities/home.dart';

abstract class HomeRepository {
  Future<Home> fetchHome();
}