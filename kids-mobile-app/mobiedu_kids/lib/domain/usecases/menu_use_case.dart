import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/meal_detail.dart';
import 'package:mobiedu_kids/domain/entities/meal_school_details.dart';
import 'package:mobiedu_kids/domain/entities/menu_child.dart';
import 'package:mobiedu_kids/domain/entities/menu_class.dart';
import 'package:mobiedu_kids/domain/entities/menu_details.dart';
import 'package:mobiedu_kids/domain/entities/menu_history.dart';
import 'package:mobiedu_kids/domain/entities/menus.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/menu_repository.dart';

class GetMenuUseCase
    extends ParamUseCase<ResponseDataObject<MenuClass<MealDetails>>, String> {
  GetMenuUseCase(this.menuRepository);

  final MenuRepository menuRepository;

  @override
  Future<ResponseDataObject<MenuClass<MealDetails>>> execute(params) {
    return menuRepository.get(params);
  }
}

class GetMenuChildUseCase
    extends ParamUseCase<ResponseDataObject<MenuChild<MealDetails>>, String> {
  GetMenuChildUseCase(this.menuRepository);

  final MenuRepository menuRepository;

  @override
  Future<ResponseDataObject<MenuChild<MealDetails>>> execute(params) {
    return menuRepository.getChild(params);
  }
}

class HistoryMenuUseCase
    extends ParamUseCase<ResponseDataObject<MenuHistory>, Tuple2<int, String>> {
  HistoryMenuUseCase(this.menuRepository);

  final MenuRepository menuRepository;

  @override
  Future<ResponseDataObject<MenuHistory>> execute(Tuple2 params) {
    return menuRepository.history(params.value1, params.value2);
  }
}

class DetailMenuUseCase extends ParamUseCase<
    ResponseDataObject<MenuDetails<MealDetails>>, Tuple2<String, String>> {
  DetailMenuUseCase(this.menuRepository);

  final MenuRepository menuRepository;

  @override
  Future<ResponseDataObject<MenuDetails<MealDetails>>> execute(Tuple2 params) {
    return menuRepository.detail(params.value1, params.value2);
  }
}

class HistoryMenuChildUseCase
    extends ParamUseCase<ResponseDataObject<MenuHistory>, Tuple2<int, String>> {
  HistoryMenuChildUseCase(this.menuRepository);

  final MenuRepository menuRepository;

  @override
  Future<ResponseDataObject<MenuHistory>> execute(Tuple2 params) {
    return menuRepository.historyChild(params.value1, params.value2);
  }
}

class DetailMenuChildUseCase extends ParamUseCase<
    ResponseDataObject<MenuDetails<MealDetails>>, Tuple2<String, String>> {
  DetailMenuChildUseCase(this.menuRepository);

  final MenuRepository menuRepository;

  @override
  Future<ResponseDataObject<MenuDetails<MealDetails>>> execute(Tuple2 params) {
    return menuRepository.detailChild(params.value1, params.value2);
  }
}

class SchoolListMenuUseCase
    extends ParamUseCase<ResponseDataObject<Menus>, String> {
  SchoolListMenuUseCase(this.menuRepository);

  final MenuRepository menuRepository;

  @override
  Future<ResponseDataObject<Menus>> execute(params) {
    return menuRepository.schoolList(params);
  }
}

class SchoolDetailMenuUseCase extends ParamUseCase<
    ResponseDataObject<MealSchoolDetails>, Tuple2<String, String>> {
  SchoolDetailMenuUseCase(this.menuRepository);

  final MenuRepository menuRepository;

  @override
  Future<ResponseDataObject<MealSchoolDetails>> execute(Tuple2 params) {
    return menuRepository.schoolDetail(params.value1, params.value2);
  }
}
