import 'package:mooc_app/data/models/search_course_model.dart';
import 'package:mooc_app/data/providers/network/apis/search_course_api.dart';
import 'package:mooc_app/domain/entities/search.dart';
import 'package:mooc_app/domain/repositories/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  @override
  Future<Search> fetchSearch(String? keyword) async {
    final response = await SearchAPI.fetchSearch(keyword).request();
    // print(response);
    return SearchCourseModel.fromJson(response);
  }
}
