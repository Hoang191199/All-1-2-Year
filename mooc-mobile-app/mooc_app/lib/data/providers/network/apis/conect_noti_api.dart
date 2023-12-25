import 'package:get/get.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

import '../../../../app/services/local_storage.dart';

enum BlogType { blog }

class BlogAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  final BlogType type;
  int? page;
  String? slug;
  BlogAPI._({
    required this.type,
    this.page,
    this.slug,
  });
  BlogAPI.fetchBlog(int page)
      : this._(
          type: BlogType.blog,
          page: page,
        );
  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path {
    switch (type) {
      case BlogType.blog:
        return "/restapi/blog/list";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  @override
  Map<String, String> get headers => {};
  @override
  Map<String, String> get query {
    switch (type) {
      case BlogType.blog:
        return {"page": "$page", "limit": "10"};
    }
  }

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
