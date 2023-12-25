import 'package:mooc_app/data/providers/network/apis/category_api.dart';
import 'package:mooc_app/domain/entities/category_response.dart';
import 'package:mooc_app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  @override
  Future<CategoryResponse> fetchCategory(int page, int perpage) async {
    final response = await CategoryAPI.fetchCategory(page, perpage).request();
    print(response);
    return CategoryResponse.fromJson(response);
  }
}
