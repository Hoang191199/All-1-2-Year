import 'package:mooc_app/domain/entities/category_response.dart';

abstract class CategoryRepository {
  Future<CategoryResponse> fetchCategory(int page, int perpage);
}
