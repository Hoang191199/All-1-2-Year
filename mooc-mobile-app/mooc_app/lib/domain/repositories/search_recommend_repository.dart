import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/search.dart';

abstract class SearchRCMRepository {
  Future<Course> fetchRCMSearch();
}