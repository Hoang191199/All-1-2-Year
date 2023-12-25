import 'package:qltv/domain/entities/epub/epub_navigation_doc_author.dart';
import 'package:qltv/domain/entities/epub/epub_navigation_doc_title.dart';
import 'package:qltv/domain/entities/epub/epub_navigation_head.dart';
import 'package:qltv/domain/entities/epub/epub_navigation_list.dart';
import 'package:qltv/domain/entities/epub/epub_navigation_map.dart';
import 'package:qltv/domain/entities/epub/epub_navigation_page_list.dart';

class EpubNavigation {
  EpubNavigation({
    this.head,
    this.docTitle,
    this.docAuthors,
    this.navMap,
    this.pageList,
    this.navLists,
  });

  EpubNavigationHead? head;
  EpubNavigationDocTitle? docTitle;
  List<EpubNavigationDocAuthor>? docAuthors;
  EpubNavigationMap? navMap;
  EpubNavigationPageList? pageList;
  List<EpubNavigationList>? navLists;
}