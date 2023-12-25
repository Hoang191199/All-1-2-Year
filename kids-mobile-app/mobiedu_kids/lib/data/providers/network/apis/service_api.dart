import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_parent_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum ServiceType { fetch, history, update, serviceParent, historyParent, register }

class ServiceApi implements APIRequestRepresentable {
  final ServiceType type;


  ServiceApi._({required this.type});

  ServiceApi.fetchData() : this._(type: ServiceType.fetch);

  ServiceApi.update() : this._(type: ServiceType.update);

  ServiceApi.history() : this._(type: ServiceType.history);

  ServiceApi.serviceParent() : this._(type: ServiceType.serviceParent);

  ServiceApi.register() : this._(type: ServiceType.register);

  ServiceApi.historyParent() : this._(type: ServiceType.historyParent);

  final store = Get.find<LocalStorageService>();
  final serviceController = Get.find<ServiceController>();
  final spashControlller = Get.find<SplashScreenController>();
  final serviceParentController = Get.find<ServiceParentController>();

  @override
  FormData get form {
    switch (type) {
      case ServiceType.fetch:
      return FormData({
        "user_id": store.userFromStorage?.user_id,
        "user_token": "${store.userFromStorage?.user_token}",
        "group_name": store.getGroupname,
        "do": "list_usage",
        "using_at": convertDateTimeToString(serviceController.dateUsing),
      });

      case ServiceType.history:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "do": "history",
          "using_at": convertDateTimeToString(serviceController.dateHistory),
      });

      case ServiceType.update:
        var objectService = {
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "do": "save",
          "using_at": convertDateTimeToString(serviceController.dateUsing),
        };

        serviceController.listItemChild.asMap().forEach((key, value) {
          int legth = 0;
          serviceController.listItemChild[key].service?.asMap().forEach((index, valueService) {
            if(valueService.check == true){
              objectService["list_childId[${value.child_id}][$legth]"] = valueService.service_id;
              legth++;
            }
          }
          );
        });
        return FormData(objectService);

      case ServiceType.serviceParent:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "child_id": spashControlller.childId,
          "view": "services_countbased",
          "using_at": convertDateTimeToString(serviceParentController.dateUsing),
        });

      case ServiceType.historyParent:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "child_id": spashControlller.childId,
          "do": "service_history_all",
          "begin": convertDateTimeToString(serviceParentController.firstDate),
          "end": convertDateTimeToString(serviceParentController.lastDate)
        });
      
      case ServiceType.register:
        var objectRegister = {
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "child_id": spashControlller.childId,
          "do": "register_countbased",
          "using_at": convertDateTimeToString(serviceParentController.dateUsing),
        };

        serviceParentController.listItemSerivce.asMap().forEach((key, value) {
            if(value.check_status == true){
              objectRegister["list_service_id[$key]"] = value.service_id;
            }
        });
        return FormData(objectRegister);
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch(type){
      case ServiceType.fetch :
      case ServiceType.history :
      case ServiceType.update :
        return "/manageClassService";
      case ServiceType.serviceParent:
        return "/manageChildServiceShow";
      case ServiceType.historyParent:
      case ServiceType.register:
        return "/manageChildService";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.post;
  }

  @override
  Map<String, String> get headers => {};

  @override
  get query => null;

  @override
  get body => form;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
