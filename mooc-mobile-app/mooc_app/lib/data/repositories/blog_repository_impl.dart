import '../../domain/entities/blog.dart';
import '../../domain/entities/blog_details.dart';
import '../../domain/repositories/blog_repository.dart';
import '../models/blog_detail_model.dart';
import '../models/blog_model.dart';
import '../providers/network/apis/blog_api.dart';

class BlogRepositoryImpl extends BlogRepository {
  @override
  Future<Blog> fetchBlog(int page) async {
    final response = await BlogAPI.fetchBlog(page).request();
    print(response);
    return BlogModel.fromJson(response);
  }
  @override
  Future<BlogDetails> fetchBlogDetails(String slug) async {
    final response = await BlogAPI.fetchBlogDetails(slug).request();
    print(response);
    return BlogDetailModel.fromJson(response);
  }
}
