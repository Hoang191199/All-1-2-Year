import 'package:mooc_app/data/models/search_recommend_model.dart';
import 'package:mooc_app/data/providers/network/apis/search_recommend_api.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/repositories/search_recommend_repository.dart';

class SearchRCMRepositoryImpl extends SearchRCMRepository {
  @override
  Future<Course> fetchRCMSearch() async {
    final response = await SearchRCMAPI.fetchRCMSearch().request();
    // print(response);
      return SearchRecommendModel.fromJson(response);
    throw Error();
  }
}
