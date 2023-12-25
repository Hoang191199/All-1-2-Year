import 'package:mobiedu_kids/domain/entities/news_feed/group_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_join.dart';

class PageGroup {
  PageGroup({
    this.pages,
    this.groups,
  });

  List<PageJoin>? pages;
  List<GroupJoin>? groups;

  factory PageGroup.fromJson(Map<String, dynamic>? json) {
    return PageGroup(
      pages: json?["pages"] == [] ? [] : List<PageJoin>.from(json?["pages"].map((x) => PageJoin.fromJson(x))),
      groups: json?["groups"] == [] ? [] : List<GroupJoin>.from(json?["groups"].map((x) => GroupJoin.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'pages': pages,
    'groups': groups,
  };
}