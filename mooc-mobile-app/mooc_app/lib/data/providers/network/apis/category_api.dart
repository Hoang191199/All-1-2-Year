import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

class CategoryAPI implements APIRequestRepresentable {
  int page;
  int perpage;
  CategoryAPI._({required this.page, required this.perpage});
  CategoryAPI.fetchCategory(int page, int perpage)
      : this._(page: page, perpage: perpage);

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path => "/course/restapi/coursecategory/list";

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  @override
  Map<String, String> get headers => {};

  @override
  Map<String, String> get query => {'page': "$page", 'limit': "$perpage"};

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
