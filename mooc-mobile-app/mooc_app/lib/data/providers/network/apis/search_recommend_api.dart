import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

class SearchRCMAPI implements APIRequestRepresentable {

  SearchRCMAPI.fetchRCMSearch();

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path => "/admin/course/recommend.json";

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  @override
  Map<String, String> get headers => {};

  @override
  Map<String, String> get query => {'limit': '1', 'page': '5'};

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
