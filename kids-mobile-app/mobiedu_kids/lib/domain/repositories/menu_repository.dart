import 'package:mobiedu_kids/domain/entities/meal_detail.dart';
import 'package:mobiedu_kids/domain/entities/meal_school_details.dart';
import 'package:mobiedu_kids/domain/entities/menu_child.dart';
import 'package:mobiedu_kids/domain/entities/menu_class.dart';
import 'package:mobiedu_kids/domain/entities/menu_details.dart';
import 'package:mobiedu_kids/domain/entities/menu_history.dart';
import 'package:mobiedu_kids/domain/entities/menus.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';

abstract class MenuRepository {
  Future<ResponseDataObject<MenuClass<MealDetails>>> get(String group_name);
  Future<ResponseDataObject<MenuChild<MealDetails>>> getChild(String child_id);
  Future<ResponseDataObject<MenuHistory>> history(int page, String group_name);
  Future<ResponseDataObject<MenuDetails<MealDetails>>> detail(
      String group_name, String menu_id);
  Future<ResponseDataObject<MenuHistory>> historyChild(
      int page, String child_id);
  Future<ResponseDataObject<MenuDetails<MealDetails>>> detailChild(
      String child_id, String menu_id);
  Future<ResponseDataObject<Menus>> schoolList(String group_name);
  Future<ResponseDataObject<MealSchoolDetails>> schoolDetail(
      String group_name, String menu_id);
}
