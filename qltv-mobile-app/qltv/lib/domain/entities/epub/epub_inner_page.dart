import 'package:qltv/domain/entities/epub/epub_inner_navigation.dart';

class EpubInnerPage extends EpubInnerNavigation {
  EpubInnerPage(this.page);

  final int page;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'page',
    'page': page,
  };

  static EpubInnerPage fromJson(Map<String, dynamic> json) {
    return EpubInnerPage(json['page'] as int);
  }

  @override
  List<Object?> get props => [page];
}