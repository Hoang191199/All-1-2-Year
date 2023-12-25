import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/infomation/data_menu.dart';
import 'package:mobiedu_kids/domain/entities/infomation/data_posts.dart';
import 'package:mobiedu_kids/domain/entities/infomation/info_child.dart';
import 'package:mobiedu_kids/domain/entities/infomation/schedule_child.dart';
import 'package:mobiedu_kids/domain/entities/post_details.dart';
import 'package:mobiedu_kids/domain/entities/response_data_comment.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/information_repository.dart';

class InfomationUseCase extends NoParamUseCase<ResponseDataObject<InfoChild>> {
  InfomationUseCase(this.infomationRepository);

  final InformationRepository infomationRepository;

  @override
  Future<ResponseDataObject<InfoChild>> execute() {
    return infomationRepository.fetchData();
  }
}

class GetMenuInfoUseCase extends NoParamUseCase<ResponseDataObject<MenuClass>> {
  GetMenuInfoUseCase(this.getMenuRepository);

  final InformationRepository getMenuRepository;

  @override
  Future<ResponseDataObject<MenuClass>> execute() {
    return getMenuRepository.getMenu();
  }
}

class GetScheduleInfoUseCase extends NoParamUseCase<ResponseDataObject<ScheduleChild>> {
  GetScheduleInfoUseCase(this.getScheduleRepository);

  final InformationRepository getScheduleRepository;

  @override
  Future<ResponseDataObject<ScheduleChild>> execute() {
    return getScheduleRepository.getSchedule();
  }
}

class NewPostInfoUseCase extends NoParamUseCase<ResponseDataObject<DataPost>> {
  NewPostInfoUseCase(this.newPostRepository);

  final InformationRepository newPostRepository;

  @override
  Future<ResponseDataObject<DataPost>> execute() {
    return newPostRepository.newPost();
  }
}

class ActionLikeUseCase extends ParamUseCase<ResponseNoData,Tuple2<String?, String?>> {
  ActionLikeUseCase(this.actionLikeRepository);

  final InformationRepository actionLikeRepository;

  @override
  Future<ResponseNoData> execute(Tuple2 params) {
    return actionLikeRepository.actionLike(params.value1, params.value2);
  }
}


class ActionCommentUseCase extends ParamUseCase<ResponseNoData,Tuple2<String?, String?>> {
  ActionCommentUseCase(this.actionCommentRepository);

  final InformationRepository actionCommentRepository;

  @override
  Future<ResponseNoData> execute(Tuple2 params) {
    return actionCommentRepository.actionComment(params.value1, params.value2);
  }
}

class PostDetailUseCase extends ParamUseCase<ResponseDataComment<PostDetails>,Tuple2<String?, String?>> {
  PostDetailUseCase(this.postDetailRepository);

  final InformationRepository postDetailRepository;

  @override
  Future<ResponseDataComment<PostDetails>> execute(Tuple2 params) {
    return postDetailRepository.getPostDetail(params.value1, params.value2);
  }
}