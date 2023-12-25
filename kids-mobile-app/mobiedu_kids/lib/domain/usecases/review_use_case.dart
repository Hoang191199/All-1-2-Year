import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/image_data.dart';
import 'package:mobiedu_kids/domain/entities/list_child_daily_details.dart';
import 'package:mobiedu_kids/domain/entities/list_child_details.dart';
import 'package:mobiedu_kids/domain/entities/list_child_monthly_details.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/list_child.dart';
import 'package:mobiedu_kids/domain/entities/template.dart';
import 'package:mobiedu_kids/domain/repositories/review_repository.dart';

class DailyFetchUseCase extends ParamUseCase<
    ResponseDataObject<ListChild<ListChildDailyDetails>>,
    Tuple2<String, String>> {
  DailyFetchUseCase(this.dailyFetchRepository);

  final ReviewRepository dailyFetchRepository;

  @override
  Future<ResponseDataObject<ListChild<ListChildDailyDetails>>> execute(
      Tuple2 params) {
    return dailyFetchRepository.mainFetchDaily(params.value1, params.value2);
  }
}

class DailyReviewUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>,
    Tuple9<String, String, List<String>, List<String>, List<String>,
        List<String>, List<String>, int, int>> {
  DailyReviewUseCase(this.dailyReviewRepository);

  final ReviewRepository dailyReviewRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple9 params) {
    return dailyReviewRepository.mainReviewDaily(
        params.value1,
        params.value2,
        params.value3,
        params.value4,
        params.value5,
        params.value6,
        params.value7,
        params.value8,
        params.value9);
  }
}

class MonthlyFetchUseCase extends ParamUseCase<
    ResponseDataObject<ListChild<ListChildMonthlyDetails>>,
    Tuple3<String, String, String>> {
  MonthlyFetchUseCase(this.monthlyFetchRepository);

  final ReviewRepository monthlyFetchRepository;

  @override
  Future<ResponseDataObject<ListChild<ListChildMonthlyDetails>>> execute(
      Tuple3 params) {
    return monthlyFetchRepository.mainFetchMonthly(
        params.value1, params.value2, params.value3);
  }
}

class MonthlyReviewUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>,
    Tuple11<String, String, String, List<String>, List<String>, List<String>,
        List<String>, List<String>, int, String, int>> {
  MonthlyReviewUseCase(this.monthlyReviewRepository);

  final ReviewRepository monthlyReviewRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple11 params) {
    return monthlyReviewRepository.mainReviewMonthly(
        params.value1,
        params.value2,
        params.value3,
        params.value4,
        params.value5,
        params.value6,
        params.value7,
        params.value8,
        params.value9,
        params.value10,
        params.value11);
  }
}

class MenuFetchReviewUseCase extends ParamUseCase<
    ResponseDataObject<ListChild<ListChildDetails>>,
    Tuple3<String, String, String>> {
  MenuFetchReviewUseCase(this.menuReviewRepository);

  final ReviewRepository menuReviewRepository;

  @override
  Future<ResponseDataObject<ListChild<ListChildDetails>>> execute(
      Tuple3 params) {
    return menuReviewRepository.fetchMenu(
        params.value1, params.value2, params.value3);
  }
}

class MenuReviewUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
    Tuple7<String, String, String, List<String>, String, List<String>, int>> {
  MenuReviewUseCase(this.menuReviewRepository);

  final ReviewRepository menuReviewRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple7 params) {
    return menuReviewRepository.reviewMenu(
        params.value1,
        params.value2,
        params.value3,
        params.value4,
        params.value5,
        params.value6,
        params.value7);
  }
}

class ScheduleFetchReviewUseCase extends ParamUseCase<
    ResponseDataObject<ListChild<ListChildDetails>>, Tuple2<String, String>> {
  ScheduleFetchReviewUseCase(this.scheduleReviewUseCase);

  final ReviewRepository scheduleReviewUseCase;

  @override
  Future<ResponseDataObject<ListChild<ListChildDetails>>> execute(
      Tuple2 params) {
    return scheduleReviewUseCase.fetchSchedule(params.value1, params.value2);
  }
}

class ScheduleReviewUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>,
    Tuple6<String, String, List<String>, String, List<String>, int>> {
  ScheduleReviewUseCase(this.scheduleReviewUseCase);

  final ReviewRepository scheduleReviewUseCase;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple6 params) {
    return scheduleReviewUseCase.reviewSchedule(params.value1, params.value2,
        params.value3, params.value4, params.value5, params.value6);
  }
}

class UploadUseCase extends ParamUseCase<ResponseDataObject<ImageData>,
    Tuple3<String, Uint8List, String>> {
  UploadUseCase(this.uploadUseCase);

  final ReviewRepository uploadUseCase;

  @override
  Future<ResponseDataObject<ImageData>> execute(Tuple3 params) {
    return uploadUseCase.upload(params.value1, params.value2, params.value3);
  }
}

class FetchTemplateUseCase extends ParamUseCase<
    ResponseDataArrayObject<Template>, Tuple2<String, String>> {
  FetchTemplateUseCase(this.fetchTemplateUseCase);

  final ReviewRepository fetchTemplateUseCase;

  @override
  Future<ResponseDataArrayObject<Template>> execute(Tuple2 params) {
    return fetchTemplateUseCase.fetchTemplate(params.value1, params.value2);
  }
}
