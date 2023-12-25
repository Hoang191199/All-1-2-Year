import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:qltv/domain/entities/bookmark.dart';
import 'package:qltv/domain/entities/epub/epub_book.dart';
import 'package:qltv/domain/entities/epub/epub_inner_node.dart';
import 'package:qltv/domain/entities/response_data_array_object.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/usecases/bookmark_add_use_case.dart';
import 'package:qltv/domain/usecases/bookmark_delete_use_case.dart';
import 'package:qltv/domain/usecases/bookmark_list_use_case.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_handle.dart';

class EpubBookmarkController extends GetxController {
  EpubBookmarkController(
    this.bookmarkListUseCase,
    this.bookmarkAddUseCase,
    this.bookmarkDeleteUseCase,
  );

  final BookmarkListUseCase bookmarkListUseCase;
  final BookmarkAddUseCase bookmarkAddUseCase;
  final BookmarkDeleteUseCase bookmarkDeleteUseCase;

  final isLoading = false.obs;
  final isLoadingAdd = false.obs;
  final isLoadingDelete = false.obs;
  final isPageBookmark = false.obs;
  var responseData = Rx<ResponseDataArrayObject<Bookmark>?>(null);
  var bookmarksData = RxList<Bookmark?>([]);
  var responseAdd = Rx<ResponseNoData?>(null);
  var responseDelete = Rx<ResponseNoData?>(null);

  getListBookmarks(int itemId) async {
    isLoading.value = true;
    final response = await bookmarkListUseCase.execute(itemId);
    responseData.value = response;
    bookmarksData.assignAll(response.data?.data ?? []);
    isLoading.value = false;
  }

  addBookmark(int itemId, int page, int innerPage, EpubController epubController) async {
    isLoadingAdd.value = true;
    final consistentLocation = epubController.epubBook?.consistentLocation;
    final location = epubController.bookController!.currentController.location;
    final filesFromEpubSpine = getFilesFromEpubSpine(epubController.epubBook ?? EpubBook());
    final document = parse(filesFromEpubSpine[location.page].content);
    var contentChapterStr = document.body!.text;
    var contentStr = '';
    if (consistentLocation?.innerNav is EpubInnerNode) {
      final innerNav = consistentLocation?.innerNav as EpubInnerNode;
      final documentElement = document.getElementsByTagName("html").first;

      final allDocumentNodes = epubController.nodesUnder(documentElement, nodeType: -1, leaveHoles: false);
      final currentNode = allDocumentNodes[innerNav.nodeIndex + 3];
      final indexTextContent = contentChapterStr.indexOf(currentNode?.text ?? '');
      contentStr = contentChapterStr.substring(indexTextContent).substring(innerNav.characterIndex);
    }
    var lengthStr = contentStr.length;
    if (lengthStr >= 300) {
      lengthStr = 300;
    }
    contentStr = contentStr.substring(0, lengthStr);
    final response = await bookmarkAddUseCase.execute(Tuple4(itemId, page, innerPage, contentStr));
    responseAdd.value = response;
    isLoadingAdd.value = false;
  }

  deleteBookmark(int itemId) async {
    isLoadingDelete.value = true;
    final response = await bookmarkDeleteUseCase.execute(itemId);
    responseDelete.value = response;
    isLoadingDelete.value = false;
  }

  checkPageBookmark(EpubController epubController) {
    if (bookmarksData.isNotEmpty) {
      final location = epubController.bookController!.currentController.location;
      for (var data in bookmarksData) {
        if (data?.metadata?.page == location.page && data?.metadata?.inner_page == location.innerNav.page) {
          isPageBookmark.value = true;
          break;
        } else {
          isPageBookmark.value = false;
        }
      }
    } else {
      isPageBookmark.value = false;
    }
  }
}
