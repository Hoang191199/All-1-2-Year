import 'package:mooc_app/domain/entities/search.dart';

abstract class SearchRepository {
  Future<Search> fetchSearch(String? keyword);
}
