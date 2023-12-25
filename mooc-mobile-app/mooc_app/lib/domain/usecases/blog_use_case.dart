import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/blog_info.dart';

import '../entities/blog.dart';
import '../repositories/blog_repository.dart';

class BlogUseCase extends ParamUseCase<Blog, int> {
  BlogUseCase(this.blogRepository);

  final BlogRepository blogRepository;

  @override
  Future<Blog> execute(params) {
    return blogRepository.fetchBlog(params);
  }
}