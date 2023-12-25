import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_show_page_group.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/group_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/image_video_picked.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/response_post.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/user.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/create_comment_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/show_page_group_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/create_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/edit_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/friend_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/group_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/post_action_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/report_use_case.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';

class ShowGroupController extends GetxController {
  ShowGroupController(
    this.showPageGroupUseCase,
    this.reportUseCase,
    this.postActionUseCase,
    this.createCommentUseCase,
    this.getPostUseCase,
    this.friendConnectUseCase,
    this.editPostUseCase,
    this.createPostUseCase,
    this.groupConnectUseCase,
  );

  final ShowPageGroupUseCase showPageGroupUseCase;
  final ReportUseCase reportUseCase;
  final PostActionUseCase postActionUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final GetPostUseCase getPostUseCase;
  final FriendConnectUseCase friendConnectUseCase;
  final EditPostUseCase editPostUseCase;
  final CreatePostUseCase createPostUseCase;
  final GroupConnectUseCase groupConnectUseCase;

  final folded = true.obs;
  final isLoadingAll = false.obs;
  final canLoadMoreGroup = true.obs;
  final canLoadMoreGroupMember = true.obs;
  final isLoadMore = false.obs;
  final isLoadMoreMember = false.obs;
  final isRefresh = false.obs;
  final isLoadingCreateComment = false.obs;
  final isLoadingPostAction = false.obs;
  final isLoadingAbout = false.obs;
  final isLoadingPost = false.obs;
  final isLoadMorePost = false.obs;
  final canLoadMorePost = true.obs;
  final isLoadingCreatePost = false.obs;

  int pageAll = 0;
  int pageMember = 0;
  int pagePost = 0;
  var postGroupData = RxList<PostNews>([]);
  var pinnedPostGroupData = Rx<PostNews?>(null);
  var postNewsCommentData = RxList<PostNewsComment?>([]);
  var pinnedPostCommentData = Rx<PostNewsComment?>(null);
  var infoGroupData = Rx<GroupJoin?>(null);
  var memberGroupData = RxList<User>([]);
  var postCommentDetailData = RxList<PostComment>([]);
  var postDetailData = Rx<PostNews?>(null);

  var responseShowGroup = Rx<ResponseDataObject<DataShowPageGroup>?>(null);
  var responsePostAction = Rx<ResponseNoData?>(null);
  var responseCreateComment = Rx<ResponseNoData?>(null);
  var responsePostDetail = Rx<ResponsePost?>(null);
  var responseFollow = Rx<ResponseNoData?>(null);
  var responseGroupConnect = Rx<ResponseNoData?>(null);

  final aboutType = AboutType.intro.obs;
  var focusComment = FocusNode();

  final isLoadingPickImage = false.obs;
  final ImagePicker imagePicker = ImagePicker();
  var imagePicked = Rx<XFile?>(null);
  var imageAvatarPicked = Rx<XFile?>(null);
  var imageCoverPicked = Rx<XFile?>(null);
  var listImageVideoCreatePost = RxList<ImageVideoPicked>([]);
  var imageCreatePostPicked = <XFile>[];
  XFile? videoCreatePostPicked;

  var commentController = TextEditingController(text: '');
  var postCommentReply = Rx<PostComment?>(null);

  var postNewsEdit = Rx<PostNews?>(null);
  var textCreateEditPostController = TextEditingController(text: '');

  final scrollCreatePostController = ScrollController();

  refreshGroupAll(String className) async {
    isRefresh.value = true;
    await showGroupAll(className);
    isRefresh.value = false;
  }

  showGroupAll(String className) async {
    isLoadingAll(true);
    pageAll = 0;
    postGroupData.value = [];
    postNewsCommentData.value = [];
    pinnedPostCommentData.value = null;
    canLoadMoreGroup(true);
    final response = await showPageGroupUseCase.execute(Tuple4('group', className, pageAll, ViewShowPage.all));
    responseShowGroup.value = response;
    infoGroupData.value = response.data?.info_group;
    pinnedPostGroupData.value = response.data?.pinned_post;
    postGroupData.assignAll(response.data?.posts ?? []);
    if (response.data?.posts?.isNotEmpty ?? false) {
      var postNewsCommentArr = <PostNewsComment>[];
      response.data?.posts?.forEach((element) {
        postNewsCommentArr.add(PostNewsComment(
          post_id: element.post_id ?? '',
          imagePicked: null,
          commentController: TextEditingController(text: '')
        ));
      });
      postNewsCommentData.assignAll(postNewsCommentArr);
    }
    if (response.data?.pinned_post != null) {
      pinnedPostCommentData.value = PostNewsComment(
        post_id: response.data?.pinned_post?.post_id ?? '',
        imagePicked: null,
        commentController: TextEditingController(text: '')
      );
    }
    isLoadingAll(false);
  }

  loadMoreShowGroupAll(String className) async {
    if (isLoadMore.value) return;
    isLoadMore(true);
    pageAll += 1;
    final response = await showPageGroupUseCase.execute(Tuple4('group', className, pageAll, ViewShowPage.all));
    responseShowGroup.value = response;
    if (response.code == 200) {
      canLoadMoreGroup(true);
      infoGroupData.value = response.data?.info_group;
      pinnedPostGroupData.value = response.data?.pinned_post;
      postGroupData.addAll(response.data?.posts ?? []);
      if (response.data?.posts?.isNotEmpty ?? false) {
        var postNewsCommentArr = <PostNewsComment>[];
        response.data?.posts?.forEach((element) {
          postNewsCommentArr.add(PostNewsComment(
            post_id: element.post_id ?? '',
            imagePicked: null,
            commentController: TextEditingController(text: '')
          ));
        });
        postNewsCommentData.addAll(postNewsCommentArr);
      } else {
        canLoadMoreGroup(false);
      }
    } else {
      pageAll -= 1;
      canLoadMoreGroup(false);
    }
    isLoadMore(false);
  }

  refreshGroupAboutMembers(String className, double heightContain, double heightItem) async {
    isRefresh.value = true;
    await showGroupAboutMembers(className, heightContain, heightItem);
    isRefresh.value = false;
  }

  showGroupAboutMembers(String className, double heightContain, double heightItem) async {
    isLoadingAbout(true);
    pageMember = 0;
    memberGroupData.value = [];
    canLoadMoreGroupMember(true);
    final response = await showPageGroupUseCase.execute(Tuple4('group', className, pageMember, ViewShowPage.members));
    memberGroupData.assignAll(response.data?.members ?? []);
    if (response.code == 200 && (response.data?.members?.isNotEmpty ?? false)) {
      final numberPageByScreen = (heightContain / ((response.data?.members?.length ?? 0) * heightItem)).floor();
      if (numberPageByScreen > 0) {
        await getAboutMembers(className, numberPageByScreen);
      }
    }
    isLoadingAbout(false);
  }

  getAboutMembers(String className, int numberPageByScreen) async {
    if (pageMember < numberPageByScreen) {
      pageMember += 1;
      final response = await showPageGroupUseCase.execute(Tuple4('group', className, pageMember, ViewShowPage.members));
      if (response.data?.members?.isNotEmpty ?? false) {
        canLoadMoreGroupMember(true);
        memberGroupData.addAll(response.data?.members ?? []);
        await getAboutMembers(className, numberPageByScreen);
      } else {
        canLoadMoreGroupMember(false);
        pageMember -= 1;
      }
    }
  }

  loadMoreShowGroupAboutMembers(String className) async {
    if (isLoadMoreMember.value) return;
    isLoadMoreMember(true);
    pageMember += 1;
    final response = await showPageGroupUseCase.execute(Tuple4('group', className, pageMember, ViewShowPage.members));
    if (response.code == 200) {
      canLoadMoreGroupMember(true);
      if (response.data?.members?.isNotEmpty ?? false) {
        memberGroupData.addAll(response.data?.members ?? []);
      } else {
        canLoadMoreGroupMember(false);
      }
    } else {
      pageMember -= 1;
      canLoadMoreGroupMember(false);
    }
    isLoadMoreMember(false);
  }

  reportGroup(String groupId) async {
    final response = await reportUseCase.execute(Tuple2(ActionPostNews.reportGroup, groupId));
    responsePostAction.value = response;
    if (response.code == 200) {
      showSnackbar(SnackbarType.success, 'Thông báo', 'Báo cáo nhóm thành công!');
    } else if (response.code == 0) {
      showSnackbar(SnackbarType.notice, 'Thông báo', response.message ?? 'Bạn đã báo cáo về nhóm này rồi!');
    }
  }

  postActionLikePostFromClass(String action, String postId) async {
    isLoadingPostAction(true);
    final response = await postActionUseCase.execute(Tuple2(action, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postGroupDataTemp = List<PostNews>.from(postGroupData);
      int index = postGroupDataTemp.indexWhere((element) => element.post_id == postId);
      if (action == ActionPostNews.likePost) {
        postGroupDataTemp[index].i_like = true;
        postGroupDataTemp[index].likes = (int.parse(postGroupDataTemp[index].likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikePost) {
        postGroupDataTemp[index].i_like = false;
        postGroupDataTemp[index].likes = (int.parse(postGroupDataTemp[index].likes ?? '0') - 1).toString();
      }
      postGroupData.assignAll(postGroupDataTemp);

      if (pinnedPostGroupData.value?.post_id == postId) {
        final pinnedPostGroupDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostGroupData.value?.toJson())));
        if (action == ActionPostNews.likePost) {
          pinnedPostGroupDataTemp.i_like = true;
          pinnedPostGroupDataTemp.likes = (int.parse(pinnedPostGroupDataTemp.likes ?? '0') + 1).toString();
        } else if (action == ActionPostNews.unLikePost) {
          pinnedPostGroupDataTemp.i_like = false;
          pinnedPostGroupDataTemp.likes = (int.parse(pinnedPostGroupDataTemp.likes ?? '0') - 1).toString();
        }
        pinnedPostGroupData.value = pinnedPostGroupDataTemp;
      }
    }
    isLoadingPostAction(false);
  }

  createCommentFromGroup(String postId, String message, Uint8List? file) async {
    isLoadingCreateComment(true);
    final postGroupDataTemp = List<PostNews>.from(postGroupData);
    int index = postGroupDataTemp.indexWhere((element) => element.post_id == postId);
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].commentController.text = '';
    postNewsCommentDataTemp[indexComment].imagePicked = null;
    FocusManager.instance.primaryFocus?.unfocus();
    final response = await createCommentUseCase.execute(Tuple4(HandleCommentPostNews.post, postId, message, file));
    responseCreateComment.value = response;
    if (response.code == 200) {
      postGroupDataTemp[index].comments = (int.parse(postGroupDataTemp[index].comments ?? '0') + 1).toString();
      postGroupData.assignAll(postGroupDataTemp);
      postNewsCommentData.assignAll(postNewsCommentDataTemp);
      if (pinnedPostGroupData.value?.post_id == postId) {
        final pinnedPostGroupDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostGroupData.value?.toJson())));
        pinnedPostGroupDataTemp.comments = (int.parse(pinnedPostGroupDataTemp.comments ?? '0') + 1).toString();
        pinnedPostGroupData.value = pinnedPostGroupDataTemp;
      }
    }
    isLoadingCreateComment(false);
    Get.to(
      () => NewsFeedPostDetailPage(
        from: PostNewsFrom.classPage,
        postId: postId,
        showComment: true,
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }

  createCommentFromGroupPin(String postId, String message, Uint8List? file) async {
    isLoadingCreateComment(true);
    final postGroupDataTemp = List<PostNews>.from(postGroupData);
    int index = postGroupDataTemp.indexWhere((element) => element.post_id == postId);
    final pinnedPostGroupDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostGroupData.value?.toJson())));
    final pinnedPostCommentDataTemp = PostNewsComment(
      post_id: postId,
      imagePicked: null,
      commentController: TextEditingController(text: '')
    );
    FocusManager.instance.primaryFocus?.unfocus();
    final response = await createCommentUseCase.execute(Tuple4(HandleCommentPostNews.post, postId, message, file));
    responseCreateComment.value = response;
    if (response.code == 200) {
      pinnedPostGroupDataTemp.comments = (int.parse(pinnedPostGroupDataTemp.comments ?? '0') + 1).toString();
      pinnedPostGroupData.value = pinnedPostGroupDataTemp;
      pinnedPostCommentData.value = pinnedPostCommentDataTemp;
      postGroupDataTemp[index].comments = (int.parse(postGroupDataTemp[index].comments ?? '0') + 1).toString();
      postGroupData.assignAll(postGroupDataTemp);
    }
    isLoadingCreateComment(false);
    Get.to(
      () => NewsFeedPostDetailPage(
        from: PostNewsFrom.classPage,
        postId: postId,
        showComment: true,
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }

  initialPostDetail(String postId) async {
    imagePicked.value = null;
    commentController.text == '';
    isLoadingPost(true);
    await getPost(postId);
    isLoadingPost(false);
  }

  getPost(String postId) async {
    pagePost = 0;
    postCommentDetailData.value = [];
    canLoadMorePost(true);
    final response = await getPostUseCase.execute(Tuple2(postId, pagePost));
    responsePostDetail.value = response;
    postDetailData.value = response.data;
    if (response.comment?.isNotEmpty ?? false) {
      var listPostComment = <PostComment>[];
      final dataSort = response.comment?..sort((a, b) => int.parse(b.comment_id ?? '0').compareTo(int.parse(a.comment_id ?? '0')));
      final responseCommentTemp = List<PostComment>.from(dataSort ?? []);
      for (var i = 0; i < responseCommentTemp.length; i++) {
        responseCommentTemp[i].level = '1';
        listPostComment.add(responseCommentTemp[i]);
        if (responseCommentTemp[i].comment_replies?.isNotEmpty ?? false) {
          final commentChildTemp = responseCommentTemp[i].comment_replies?..sort((a, b) => int.parse(b.comment_id ?? '0').compareTo(int.parse(a.comment_id ?? '0')));
          for (var j = 0; j < (commentChildTemp?.length ?? 0); j++) {
            commentChildTemp?[j].level = '2';
            listPostComment.add(commentChildTemp![j]);
          }
        }
      }
      postCommentDetailData.assignAll(listPostComment);
    }
  }

  loadMoreGetPost(String postId) async {
    if (isLoadMorePost.value) return;
    isLoadMorePost(true);
    pagePost += 1;
    final response = await getPostUseCase.execute(Tuple2(postId, pagePost));
    responsePostDetail.value = response;
    if (response.code == 200) {
      canLoadMorePost(true);
      postDetailData.value = response.data;
      if (response.comment?.isNotEmpty ?? false) {
        var listPostComment = <PostComment>[];
        final dataSort = response.comment?..sort((a, b) => int.parse(b.comment_id ?? '0').compareTo(int.parse(a.comment_id ?? '0')));
        final responseCommentTemp = List<PostComment>.from(dataSort ?? []);
        for (var i = 0; i < responseCommentTemp.length; i++) {
          responseCommentTemp[i].level = '1';
          listPostComment.add(responseCommentTemp[i]);
          if (responseCommentTemp[i].comment_replies?.isNotEmpty ?? false) {
            final commentChildTemp = responseCommentTemp[i].comment_replies?..sort((a, b) => int.parse(b.comment_id ?? '0').compareTo(int.parse(a.comment_id ?? '0')));
            for (var j = 0; j < (commentChildTemp?.length ?? 0); j++) {
              commentChildTemp?[j].level = '2';
              listPostComment.add(commentChildTemp![j]);
            }
          }
        }
        postCommentDetailData.addAll(listPostComment);
      } else {
        canLoadMorePost(false);
      }
    } else {
      pagePost -= 1;
      canLoadMorePost(false);
    }
    isLoadMorePost(false);
  }

  postActionLikePostFromPostDetail(String action, String postId) async {
    isLoadingPostAction(true);
    final response = await postActionUseCase.execute(Tuple2(action, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postGroupDataTemp = List<PostNews>.from(postGroupData);
      final postDetailDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(postDetailData.value?.toJson())));
      int index = postGroupDataTemp.indexWhere((element) => element.post_id == postId);
      if (action == ActionPostNews.likePost) {
        postGroupDataTemp[index].i_like = true;
        postGroupDataTemp[index].likes = (int.parse(postGroupDataTemp[index].likes ?? '0') + 1).toString();
        postDetailDataTemp.i_like = true;
        postDetailDataTemp.likes = (int.parse(postDetailData.value?.likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikePost) {
        postGroupDataTemp[index].i_like = false;
        postGroupDataTemp[index].likes = (int.parse(postGroupDataTemp[index].likes ?? '0') - 1).toString();
        postDetailDataTemp.i_like = false;
        postDetailDataTemp.likes = (int.parse(postDetailData.value?.likes ?? '0') - 1).toString();
      }
      postGroupData.assignAll(postGroupDataTemp);
      postDetailData.value = postDetailDataTemp;
      if (pinnedPostGroupData.value?.post_id == postId) {
        final pinnedPostGroupDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostGroupData.value?.toJson())));
        if (action == ActionPostNews.likePost) {
          pinnedPostGroupDataTemp.i_like = true;
          pinnedPostGroupDataTemp.likes = (int.parse(pinnedPostGroupDataTemp.likes ?? '0') + 1).toString();
        } else if (action == ActionPostNews.unLikePost) {
          pinnedPostGroupDataTemp.i_like = false;
          pinnedPostGroupDataTemp.likes = (int.parse(pinnedPostGroupDataTemp.likes ?? '0') - 1).toString();
        }
        pinnedPostGroupData.value = pinnedPostGroupDataTemp;
      }
    }
    isLoadingPostAction(false);
  }

  postActionLikeCommentFromPostDetail(String action, String commentId) async {
    isLoadingPostAction(true);
    final response = await postActionUseCase.execute(Tuple2(action, commentId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postCommentDetailDataTemp = List<PostComment>.from(postCommentDetailData);
      int index = postCommentDetailDataTemp.indexWhere((element) => element.comment_id == commentId);
      if (action == ActionPostNews.likeComment) {
        postCommentDetailDataTemp[index].i_like = true;
        postCommentDetailDataTemp[index].likes = (int.parse(postCommentDetailDataTemp[index].likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikeComment) {
        postCommentDetailDataTemp[index].i_like = false;
        postCommentDetailDataTemp[index].likes = (int.parse(postCommentDetailDataTemp[index].likes ?? '0') - 1).toString();
      }
      postCommentDetailData.assignAll(postCommentDetailDataTemp);
    }
    isLoadingPostAction(false);
  }

  postActionDeleteCommentFromPostDetail(String commentId, String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.deleteComment, commentId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postCommentDetailDataTemp = List<PostComment>.from(postCommentDetailData);
      final postDetailDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(postDetailData.value?.toJson())));
      postCommentDetailDataTemp.removeWhere((element) => element.comment_id == commentId);
      postDetailDataTemp.comments = (int.parse(postDetailData.value?.comments ?? '0') - 1).toString();
      
      postCommentDetailData.assignAll(postCommentDetailDataTemp);
      postDetailData.value = postDetailDataTemp;

      final postGroupDataTemp = List<PostNews>.from(postGroupData);
      int index = postGroupDataTemp.indexWhere((element) => element.post_id == postId);
      postGroupDataTemp[index].comments = (int.parse(postGroupDataTemp[index].comments ?? '0') - 1).toString();
      postGroupData.assignAll(postGroupDataTemp);
      if (pinnedPostGroupData.value?.post_id == postId) {
        final pinnedPostGroupDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostGroupData.value?.toJson())));
        pinnedPostGroupDataTemp.comments = (int.parse(pinnedPostGroupDataTemp.comments ?? '0') - 1).toString();
        pinnedPostGroupData.value = pinnedPostGroupDataTemp;
      }
    }
  }

  createCommentFromDetailPost(String postId, String message, Uint8List? file) async {
    isLoadingCreateComment(true);
    commentController.text = '';
    imagePicked.value = null;
    FocusManager.instance.primaryFocus?.unfocus();
    final id = postCommentReply.value != null ? postCommentReply.value?.comment_id : postId;
    final action = postCommentReply.value != null ? HandleCommentPostNews.comment : HandleCommentPostNews.post;
    final response = await createCommentUseCase.execute(Tuple4(action, id, message, file));
    responseCreateComment.value = response;
    if (response.code == 200) {
      postCommentReply.value = null;
      final postGroupDataTemp = List<PostNews>.from(postGroupData);
      int index = postGroupDataTemp.indexWhere((element) => element.post_id == postId);
      postGroupDataTemp[index].comments = (int.parse(postGroupDataTemp[index].comments ?? '0') + 1).toString();
      postGroupData.assignAll(postGroupDataTemp);

      if (pinnedPostGroupData.value?.post_id == postId) {
        final pinnedPostGroupDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostGroupData.value?.toJson())));
        pinnedPostGroupDataTemp.comments = (int.parse(pinnedPostGroupDataTemp.comments ?? '0') + 1).toString();
        pinnedPostGroupData.value = pinnedPostGroupDataTemp;
      }

      await getPost(postId);
    }
    isLoadingCreateComment(false);
  }

  postActionShareKid(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.share, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      showSnackbar(SnackbarType.success, 'Thông báo', 'Chia sẻ bài viết thành công!');
      final postDetailDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(postDetailData.value?.toJson())));
      postDetailDataTemp.shares = (int.parse(postDetailData.value?.shares ?? '0') + 1).toString();
      postDetailData.value = postDetailDataTemp;
    }
  }

  pickImagePostDetailFromGallery() async {
    imagePicked.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  pickImageGroupFromGallery(String postId) async {
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);
    isLoadingPickImage(true);
    postNewsCommentData.assignAll(postNewsCommentDataTemp);
    isLoadingPickImage(false);
  }

  pickImageGroupPinFromGallery(String postId) async {
    final pinnedPostCommentDataTemp = PostNewsComment(
      post_id: postId,
      imagePicked: await imagePicker.pickImage(source: ImageSource.gallery),
      commentController: pinnedPostCommentData.value!.commentController
    );
    isLoadingPickImage(true);
    pinnedPostCommentData.value = pinnedPostCommentDataTemp;
    isLoadingPickImage(false);
  }

  pickImageAvatarGroupFromGallery() async {
    imageAvatarPicked.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  pickImageCoverGroupFromGallery() async {
    imageCoverPicked.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  pickImageCreatePostFromGallery() async {
    imageCreatePostPicked = await imagePicker.pickMultiImage();
    for (var i = 0; i < imageCreatePostPicked.length; i++) {
      listImageVideoCreatePost.add(ImageVideoPicked(
        id: DateTime.now().millisecondsSinceEpoch + i, 
        type: 'image', 
        file: imageCreatePostPicked[i]
      ));
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollCreatePostController.animateTo(
        scrollCreatePostController.position.maxScrollExtent, 
        duration: const Duration(milliseconds: 100), 
        curve: Curves.fastOutSlowIn
      );
    });
  }

  pickVideoCreatePostFromGallery() async {
    videoCreatePostPicked = await imagePicker.pickVideo(source: ImageSource.gallery);
    if (videoCreatePostPicked != null) {
      final listImageVideoCreatePostTemp = List<ImageVideoPicked>.from(listImageVideoCreatePost);
      listImageVideoCreatePostTemp.removeWhere((element) => element.type == 'video');
      listImageVideoCreatePost.assignAll(listImageVideoCreatePostTemp);
      Future.delayed(const Duration(milliseconds: 100), () {
        listImageVideoCreatePost.add(ImageVideoPicked(
          id: DateTime.now().millisecondsSinceEpoch, 
          type: 'video', 
          file: videoCreatePostPicked!
        ));
      });
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      scrollCreatePostController.animateTo(
        scrollCreatePostController.position.maxScrollExtent, 
        duration: const Duration(milliseconds: 100), 
        curve: Curves.fastOutSlowIn
      );
    });
  }

  deleteImageVideoItem(ImageVideoPicked imageVideoItem) async {
    final listImageVideoCreatePostTemp = List<ImageVideoPicked>.from(listImageVideoCreatePost);
    listImageVideoCreatePostTemp.removeWhere((element) => element.id == imageVideoItem.id);
    listImageVideoCreatePost.assignAll(listImageVideoCreatePostTemp);
  }

  deleteImagePickedGroupFromGallery(String postId) async {
    isLoadingPickImage(true);
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].imagePicked = null;
    postNewsCommentData.assignAll(postNewsCommentDataTemp);
    isLoadingPickImage(false);
  }

  deleteImagePickedGroupPinFromGallery(String postId) async {
    isLoadingPickImage(true);
    final pinnedPostCommentDataTemp = PostNewsComment(
      post_id: postId,
      imagePicked: null,
      commentController: pinnedPostCommentData.value!.commentController
    );
    pinnedPostCommentData.value = pinnedPostCommentDataTemp;
    isLoadingPickImage(false);
  }

  postActionDeletePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.deletePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postGroupDataTemp = List<PostNews>.from(postGroupData);
      postGroupDataTemp.removeWhere((element) => element.post_id == postId);
      postGroupData.assignAll(postGroupDataTemp);
    }
  }

  friendsConnectFollow(String friendId, String action) async {
    final response = await friendConnectUseCase.execute(Tuple2(friendId, action));
    responseFollow.value = response;
    if (response.code == 200) {
      final iFollow = action == ActionFriendsConnect.follow;
      final postGroupDataTemp = List<PostNews>.from(postGroupData);
      for (var i = 0; i < postGroupDataTemp.length; i++) {
        if (postGroupDataTemp[i].author_id == friendId) {
          postGroupDataTemp[i].i_follow = iFollow;
        }
      }
      postGroupData.assignAll(postGroupDataTemp);
    }
  }

  postActionHidePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.hidePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postGroupDataTemp = List<PostNews>.from(postGroupData);
      postGroupDataTemp.removeWhere((element) => element.post_id == postId);
      postGroupData.assignAll(postGroupDataTemp);
    }
  }

  reportPost(String postId) async {
    final response = await reportUseCase.execute(Tuple2(ActionPostNews.reportPost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      showSnackbar(SnackbarType.success, 'Thông báo', 'Báo cáo bài viết thành công!');
    } else if (response.code == 0) {
      showSnackbar(SnackbarType.notice, 'Thông báo', response.message ?? 'Bạn đã báo cáo bài viết này rồi!');
    }
  }

  postActionSavePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.savePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      showSnackbar(SnackbarType.success, 'Thông báo', 'Lưu bài viết thành công!');
    }
  }

  postActionPinPost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.pinPost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postGroupDataTemp = List<PostNews>.from(postGroupData);
      for (var i = 0; i < postGroupDataTemp.length; i++) {
        if (postGroupDataTemp[i].post_id == postId) {
          postGroupDataTemp[i].pinned = true;
          pinnedPostGroupData.value = postGroupDataTemp[i];
        } else {
          postGroupDataTemp[i].pinned = false;
        }
      }
      postGroupData.assignAll(postGroupDataTemp);
    }
  }

  postActionUnPinPost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.unPinPost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      pinnedPostGroupData.value = null;
      final postGroupDataTemp = List<PostNews>.from(postGroupData);
      int index = postGroupDataTemp.indexWhere((element) => element.post_id == postId);
      postGroupDataTemp[index].pinned = false;
      postGroupData.assignAll(postGroupDataTemp);
    }
  }

  editPostFromGroup() async {
    isLoadingPostAction(true);
    final response = await editPostUseCase.execute(Tuple3(ActionPostNews.editPost, postNewsEdit.value?.post_id, textCreateEditPostController.text));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postGroupDataTemp = List<PostNews>.from(postGroupData);
      int index = postGroupDataTemp.indexWhere((element) => element.post_id == postNewsEdit.value?.post_id);
      postGroupDataTemp[index].text = textCreateEditPostController.text;
      postGroupData.assignAll(postGroupDataTemp);
    }
    isLoadingPostAction(false);
    postNewsEdit.value = null;
    textCreateEditPostController.text = '';
    Get.back();
  }

  createPostFromGroup() async {
    isLoadingCreatePost(true);
    var listFiles = <Uint8List>[];
    String fileType = '';
    if (listImageVideoCreatePost.isNotEmpty) {
      final listImage = listImageVideoCreatePost.where((item) => item.type == 'image');
      if (listImage.isNotEmpty) {
        fileType = PhotoType.photo;
        for (var image in listImage) {
          listFiles.add(
            await image.file.readAsBytes()
          );
        }
      } else {
        fileType = PhotoType.video;
        listFiles.add(
          await listImageVideoCreatePost[0].file.readAsBytes()
        );
      }
    }
    try {
      final response = await createPostUseCase.execute(Tuple7(
        ActionCreatePost.group, 
        infoGroupData.value?.group_id ?? '', 
        TypeCreatePost.publisher,
        null,
        listFiles,
        fileType,
        textCreateEditPostController.text
      ));
      isLoadingCreatePost(false);
      if (response.code == 200) {
        clearCreatePost();
        Get.back();
        showSnackbar(SnackbarType.success, 'Thông báo', 'Tạo bài viết thành công!');
        refreshGroupAll(infoGroupData.value?.group_name ?? '');
      } else {
        showSnackbar(SnackbarType.error, 'Thông báo', 'Tạo bài viết không thành công!');
      }
    } finally {
      isLoadingCreatePost(false);
    }
  }

  clearCreatePost() {
    textCreateEditPostController.text = '';
    listImageVideoCreatePost.value = [];
  }

  changeAvatarCoverImageGroup(String typeStr) async {
    isLoadingCreatePost(true);
    Get.back();
    var listFiles = <Uint8List>[];
    Uint8List? file = typeStr == TypeCreatePost.pictureGroup 
      ? await imageAvatarPicked.value?.readAsBytes() 
      : await imageCoverPicked.value?.readAsBytes();
    listFiles.add(file!);
    final response = await createPostUseCase.execute(Tuple7(
      ActionCreatePost.group, 
      infoGroupData.value?.group_id ?? '', 
      typeStr,
      PrivacyCreatePost.public,
      listFiles,
      PhotoType.photo,
      null
    ));
    if (response.code == 200) {
      // final infoGroupDataTemp = GroupJoin.fromJson(jsonDecode(jsonEncode(infoGroupData.value?.toJson())));
      // infoGroupDataTemp.group_picture = response.data?.post?.group_picture ?? '';
      // infoGroupDataTemp.group_cover = response.data?.post?.group_cover ?? '';
      refreshGroupAll(infoGroupData.value?.group_name ?? '');
    }
    isLoadingCreatePost(false);
  }

  pageConnectJoin(String action) async {
    if (action == ActionGroupConnect.groupLeave) {
      Get.back();
    }
    final response = await groupConnectUseCase.execute(Tuple2(action, infoGroupData.value?.group_id ?? ''));
    responseGroupConnect.value = response;
    if (response.code == 200) {
      // final infoGroupDataTemp = GroupJoin.fromJson(jsonDecode(jsonEncode(infoGroupData.value?.toJson())));
      // if (action == ActionGroupConnect.groupLeave) {
      // }
      refreshGroupAll(infoGroupData.value?.group_name ?? '');
    }
  }
}