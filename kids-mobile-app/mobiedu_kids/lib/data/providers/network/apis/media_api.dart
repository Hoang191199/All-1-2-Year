import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum MediaType { support, comic, video, detail }

class MediaAPI implements APIRequestRepresentable {
  final MediaType type;
  int? page;
  String? category;
  String? filter_by;
  String? id;

  final store = Get.find<LocalStorageService>();

  MediaAPI._(
      {required this.type, this.page, this.category, this.filter_by, this.id});

  MediaAPI.support(String category)
      : this._(type: MediaType.support, category: category);

  MediaAPI.comic(String category)
      : this._(type: MediaType.comic, category: category);

  MediaAPI.video(String category, String filter_by, int page)
      : this._(
            type: MediaType.video,
            filter_by: filter_by,
            category: category,
            page: page);

  MediaAPI.detail(String id) : this._(type: MediaType.detail, id: id);

  @override
  FormData get form {
    switch (type) {
      case MediaType.support:
        return FormData({
          "category": "${category}",
        });
      case MediaType.comic:
        return FormData({"category": "${category}"});
      case MediaType.video:
        return FormData({
          "category": "${category}",
          "filter_by": "${filter_by}",
          "page": "${page}",
        });
      case MediaType.detail:
        return FormData({});
    }
  }

  @override
  String get endpoint => APIEndpoint.endpointMedia;

  @override
  String get path {
    switch (type) {
      case MediaType.support:
      case MediaType.comic:
        return "/getCategories";
      case MediaType.video:
        return "/getPosts";
      case MediaType.detail:
        return "";
    }
  }

  @override
  String get url {
    switch (type) {
      case MediaType.support:
      case MediaType.comic:
      case MediaType.video:
        return endpoint + path;
      case MediaType.detail:
        return "http://blog.mobiedu.vn/wp-json/wp/v2/posts/$id";
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case MediaType.support:
      case MediaType.comic:
      case MediaType.video:
        return HTTPMethod.post;
      case MediaType.detail:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String>? get headers => {};

  @override
  Map<String, String>? get query => {};

  @override
  get body {
    switch (type) {
      case MediaType.support:
      case MediaType.comic:
      case MediaType.video:
        return form;
      case MediaType.detail:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
