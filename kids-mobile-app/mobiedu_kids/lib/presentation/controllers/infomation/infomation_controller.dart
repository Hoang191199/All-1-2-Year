import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/domain/entities/infomation/data_menu.dart';
import 'package:mobiedu_kids/domain/entities/infomation/data_posts.dart';
import 'package:mobiedu_kids/domain/entities/infomation/info_child.dart';
import 'package:mobiedu_kids/domain/entities/infomation/info_child_review.dart';
import 'package:mobiedu_kids/domain/entities/infomation/schedule_child.dart';
import 'package:mobiedu_kids/domain/entities/post_details.dart';
import 'package:mobiedu_kids/domain/entities/response_data_comment.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/usecases/infomation_use_case.dart';

class InformationController extends GetxController {
  InformationController(this.fetch, this.getMenu, this.getSchedule,
      this.newPost, this.like, this.comment, this.postDetail);
  var responseInfomation = Rx<ResponseDataObject<InfoChild>?>(null);
  var responseMenu = Rx<ResponseDataObject<MenuClass>?>(null);
  var responseSchedule = Rx<ResponseDataObject<ScheduleChild>?>(null);
  var responseNewPost = Rx<ResponseDataObject<DataPost>?>(null);
  var responsePostDetail = Rx<ResponseDataComment<PostDetails>?>(null);

  final isLoading = false.obs;
  final isLoadingPostDetail = false.obs;
  final typeMenu = Rx<InfoChildReview?>(null);
  final typeSleep = Rx<InfoChildReview?>(null);
  final typeHygiene = Rx<InfoChildReview?>(null);
  final typeSchedule = Rx<InfoChildReview?>(null);
  final checkLike = <String>[].obs;
  final idPost = <String>[].obs;
  final checkLikeDetail = ''.obs;
  final checkComment = <TextEditingController>[].obs;
  late TextEditingController commentDetail;
  final attendanceKey = GlobalKey();
  final indexPage = 0.obs;
  final indexChild = 0.obs;

  DateTime dateNow = DateTime.now();
  late DateTime startOfWeek;
  late DateTime endOfWeek;

  final InfomationUseCase fetch;
  final GetMenuInfoUseCase getMenu;
  final GetScheduleInfoUseCase getSchedule;
  final NewPostInfoUseCase newPost;
  final ActionLikeUseCase like;
  final ActionCommentUseCase comment;
  final PostDetailUseCase postDetail;

  @override
  void onInit() {
    startOfWeek = dateNow.subtract(Duration(days: dateNow.weekday - 1));
    endOfWeek = startOfWeek.add(const Duration(days: 6));
    commentDetail = TextEditingController();

    super.onInit();
  }

  fetchData() async {
    isLoading(true);
    final response = await fetch.execute();
    responseInfomation.value = response;
    final responseDataMenu = await getMenu.execute();
    responseMenu.value = responseDataMenu;
    final responseDataSchedule = await getSchedule.execute();
    responseSchedule.value = responseDataSchedule;
    await listPost();
    var infoChild = response.data?.infoChildReview;
    if(infoChild?.isNotEmpty ?? false) {
      infoChild?.asMap().forEach((key, value) {
        if (value.type == 'menu') {
          typeMenu.value = value;
        }
        if (value.type == 'sleep') {
          typeSleep.value = value;
        }
        if (value.type == 'poo') {
          typeHygiene.value = value;
        }
        if (value.type == 'schedule') {
          typeSchedule.value = value;
        }
      });
    }else{
      typeMenu.value = null;
      typeSleep.value = null;
      typeHygiene.value = null;
      typeSchedule.value = null;
    }
    isLoading(false);
  }

  listPost() async {
    final responseDataPost = await newPost.execute();
    responseNewPost.value = responseDataPost;
    checkLike.value = List.generate(responseDataPost.data?.posts?.length ?? 0, (_) => '');
    idPost.value = List.generate(responseDataPost.data?.posts?.length ?? 0, (_) => '');
    checkComment.value = List.generate(responseDataPost.data?.posts?.length ?? 0,(_) => TextEditingController());
    responseDataPost.data?.posts?.asMap().forEach((index, element) {
      idPost[index] = element.post_id ?? '0';
      if (element.i_like == true) {
        checkLike[index] = 'like_post';
      } else {
        checkLike[index] = 'unlike_post';
      }
    });
  }

  actionLike(int? index) async {
    final responseActionLike = await like.execute(Tuple2(checkLike[index ?? 0], idPost[index ?? 0]));
    if (responseActionLike.code == 200) {
      await listPost();
    }
  }

  actionLikeDetail(String idPost) async {
    final responseActionLike = await like.execute(Tuple2(checkLikeDetail.value, idPost));
    if (responseActionLike.code == 200) {
      await getPostDetail(idPost, '0');
    }
  }

  actionComment(int index) async {
    if (checkComment[index].text != "") {
      final responseActionComment = await comment.execute(Tuple2(checkComment[index].text, idPost[index]));
      if (responseActionComment.code == 200) {
        await listPost();
      }
    }
  }

  actionCommentDetail(String idPost) async {
    if (commentDetail.text != "") {
      final responseActionComment = await comment.execute(Tuple2(commentDetail.text, idPost));
      if (responseActionComment.code == 200) {
        await getPostDetail(idPost, '0');
      }
    }
  }

  getPostDetail(String idPost, String page) async {
    isLoadingPostDetail(true);
    final response = await postDetail.execute(Tuple2(page, idPost));
    responsePostDetail.value = response;
    isLoadingPostDetail(false);
  }

  formatDate(String dateStr) {
    DateFormat inputDateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime inputDate = inputDateFormat.parse(dateStr);
    DateFormat outputDateFormat = DateFormat("dd/MM/yyyy");
    String outputDateStr = outputDateFormat.format(inputDate);

    return outputDateStr;
  }

  getDay(String dateStr) {
    DateFormat inputDateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime inputDate = inputDateFormat.parse(dateStr);
    String dayOfWeek = DateFormat.EEEE('vi').format(inputDate);

    return dayOfWeek;
  }

  checkHeight(int leght) {
    double height = 350;
    if (leght == 1) {
      return height = 226;
    } else if (leght == 2) {
      return height = 200;
    } else if (leght == 3) {
      return height = 412;
    }
    return height;
  }
}
