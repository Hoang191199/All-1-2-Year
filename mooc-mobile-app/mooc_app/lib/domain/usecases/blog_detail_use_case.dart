import 'package:mooc_app/app/core/usecases/pram_usecase.dart';

import '../entities/blog_details.dart';
import '../repositories/blog_repository.dart';

class BlogDetailUseCase extends ParamUseCase<BlogDetails, String> {
  BlogDetailUseCase(this.blogRepository);

  final BlogRepository blogRepository;

  @override
  Future<BlogDetails> execute(params) {
    return blogRepository.fetchBlogDetails(params);
  }
}