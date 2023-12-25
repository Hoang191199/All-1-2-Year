import '../entities/blog.dart';
import '../entities/blog_details.dart';

abstract class BlogRepository {
  Future<Blog> fetchBlog(int page);
  Future<BlogDetails> fetchBlogDetails(String slug);
}