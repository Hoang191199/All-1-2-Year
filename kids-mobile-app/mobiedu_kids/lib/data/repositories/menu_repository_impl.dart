import 'package:mobiedu_kids/data/providers/network/apis/menu_api.dart';
import 'package:mobiedu_kids/domain/entities/meal_detail.dart';
import 'package:mobiedu_kids/domain/entities/meal_school_details.dart';
import 'package:mobiedu_kids/domain/entities/menu_child.dart';
import 'package:mobiedu_kids/domain/entities/menu_class.dart';
import 'package:mobiedu_kids/domain/entities/menu_details.dart';
import 'package:mobiedu_kids/domain/entities/menu_history.dart';
import 'package:mobiedu_kids/domain/entities/menus.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/menu_repository.dart';

class MenuRepositoryImpl extends MenuRepository {
  @override
  Future<ResponseDataObject<MenuClass<MealDetails>>> get(
      String group_name) async {
    final response = await MenuAPI.get(group_name).request();
    return ResponseDataObject<MenuClass<MealDetails>>.fromJson(
        response,
        (data) => MenuClass<MealDetails>.fromJson(
            data, (d) => MealDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataObject<MenuChild<MealDetails>>> getChild(
      String child_id) async {
    final response = await MenuAPI.getChild(child_id).request();
    return ResponseDataObject<MenuChild<MealDetails>>.fromJson(
        response,
        (data) => MenuChild<MealDetails>.fromJson(
            data, (d) => MealDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataObject<MenuHistory>> history(
      int page, String group_name) async {
    final response = await MenuAPI.history(page, group_name).request();
    return ResponseDataObject<MenuHistory>.fromJson(
        response, (data) => MenuHistory.fromJson(data));
  }

  @override
  Future<ResponseDataObject<MenuDetails<MealDetails>>> detail(
      String group_name, String menu_id) async {
    final response = await MenuAPI.detail(group_name, menu_id).request();
    return ResponseDataObject<MenuDetails<MealDetails>>.fromJson(
        response,
        (data) => MenuDetails<MealDetails>.fromJson(
            data, (d) => MealDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataObject<MenuHistory>> historyChild(
      int page, String child_id) async {
    final response = await MenuAPI.historyChild(page, child_id).request();
    return ResponseDataObject<MenuHistory>.fromJson(
        response, (data) => MenuHistory.fromJson(data));
  }

  @override
  Future<ResponseDataObject<MenuDetails<MealDetails>>> detailChild(
      String child_id, String menu_id) async {
    final response = await MenuAPI.detailChild(child_id, menu_id).request();
    return ResponseDataObject<MenuDetails<MealDetails>>.fromJson(
        response,
        (data) => MenuDetails<MealDetails>.fromJson(
            data, (d) => MealDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataObject<Menus>> schoolList(String group_name) async {
    final response = await MenuAPI.schoolList(group_name).request();
    return ResponseDataObject<Menus>.fromJson(
        response, (data) => Menus.fromJson(data));
  }

  @override
  Future<ResponseDataObject<MealSchoolDetails>> schoolDetail(
      String group_name, String user_id) async {
    final response = await MenuAPI.schoolDetail(group_name, user_id).request();
    return ResponseDataObject<MealSchoolDetails>.fromJson(
        response, (data) => MealSchoolDetails.fromJson(data));
  }
}
