import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/about_page.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_show_page_group.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/image_video_picked.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/response_post.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/school_review.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/contact_school_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/create_comment_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/create_review_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/show_page_group_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/create_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/edit_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/friend_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/page_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/post_action_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/report_use_case.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';

class ShowPageController extends GetxController {
  ShowPageController(
    this.showPageGroupUseCase,
    this.postActionUseCase,
    this.reportUseCase,
    this.createCommentUseCase,
    this.getPostUseCase,
    this.pageConnectUseCase,
    this.contactSchoolUseCase,
    this.friendConnectUseCase,
    this.editPostUseCase,
    this.createPostUseCase,
    this.createReviewUseCase,
  );

  final ShowPageGroupUseCase showPageGroupUseCase;
  final PostActionUseCase postActionUseCase;
  final ReportUseCase reportUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final GetPostUseCase getPostUseCase;
  final PageConnectUseCase pageConnectUseCase;
  final ContactSchoolUseCase contactSchoolUseCase;
  final FriendConnectUseCase friendConnectUseCase;
  final EditPostUseCase editPostUseCase;
  final CreatePostUseCase createPostUseCase;
  final CreateReviewUseCase createReviewUseCase;

  final folded = true.obs;
  final isLoadingAll = false.obs;
  final isLoadingReview = false.obs;
  final isLoadingAbout = false.obs;
  final isRefresh = false.obs;
  final isLoadMore = false.obs;
  int pageAll = 0;
  int pageReview = 0;
  var responseShowPage = Rx<ResponseDataObject<DataShowPageGroup>?>(null);
  var infoPageData = Rx<PageJoin?>(null);
  var reviewPageData = RxList<SchoolReview>([]);
  var postPageData = RxList<PostNews>([]);
  var pinnedPostPageData = Rx<PostNews?>(null);
  var aboutPageData = Rx<AboutPage?>(null);
  final canLoadMorePage = true.obs;
  final canLoadMorePageReview = true.obs;
  var postNewsCommentData = RxList<PostNewsComment?>([]);
  var pinnedPostCommentData = Rx<PostNewsComment?>(null);
  var responsePostAction = Rx<ResponseNoData?>(null);
  var responseCreateComment = Rx<ResponseNoData?>(null);
  var responsePageConnect = Rx<ResponseNoData?>(null);
  var responsePageAction = Rx<ResponseNoData?>(null);
  var responseFollow = Rx<ResponseNoData?>(null);

  final isLoadingPickImage = false.obs;
  final ImagePicker imagePicker = ImagePicker();
  var imagePicked = Rx<XFile?>(null);
  var imageAvatarPicked = Rx<XFile?>(null);
  var imageCoverPicked = Rx<XFile?>(null);
  var listImageVideoCreatePost = RxList<ImageVideoPicked>([]);
  var imageCreatePostPicked = <XFile>[];
  XFile? videoCreatePostPicked;

  var focusComment = FocusNode();

  final isLoadingCreateComment = false.obs;
  final isLoadingPostAction = false.obs;
  final isLoadingCreatePost = false.obs;
  final isLoadingCreateReview = false.obs;

  final isLoadingPost = false.obs;
  int pagePost = 0;
  var responsePostDetail = Rx<ResponsePost?>(null);
  var postDetailData = Rx<PostNews?>(null);
  var postCommentDetailData = RxList<PostComment>([]);
  final isLoadMorePost = false.obs;
  final canLoadMorePost = true.obs;

  var commentController = TextEditingController(text: '');
  var postCommentReply = Rx<PostComment?>(null);

  var parentTextInputController = TextEditingController(text: '');
  var phoneTextInputController = TextEditingController(text: '');
  var studentInfoTextInputController = TextEditingController(text: '');
  final isSendingContact = false.obs;

  var postNewsEdit = Rx<PostNews?>(null);
  var textCreateEditPostController = TextEditingController(text: '');

  final scrollCreatePostController = ScrollController();

  var textRateController = TextEditingController(text: '');
  final rateNumber = 5.0.obs;

  refreshPageAll(String pageName) async {
    isRefresh.value = true;
    await showPageAll(pageName);
    isRefresh.value = false;
  }

  showPageAll(String pageName) async {
    isLoadingAll(true);
    pageAll = 0;
    postPageData.value = [];
    postNewsCommentData.value = [];
    pinnedPostCommentData.value = null;
    canLoadMorePage(true);
    final response = await showPageGroupUseCase.execute(Tuple4('page', pageName, pageAll, ViewShowPage.all));
    responseShowPage.value = response;
    infoPageData.value = response.data?.info_page;
    pinnedPostPageData.value = response.data?.pinned_post;
    postPageData.assignAll(response.data?.post ?? []);
    if (response.data?.post?.isNotEmpty ?? false) {
      var postNewsCommentArr = <PostNewsComment>[];
      response.data?.post?.forEach((element) {
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

  loadMoreShowPageAll(String pageName) async {
    if (isLoadMore.value) return;
    isLoadMore(true);
    pageAll += 1;
    final response = await showPageGroupUseCase.execute(Tuple4('page', pageName, pageAll, ViewShowPage.all));
    responseShowPage.value = response;
    if (response.code == 200) {
      canLoadMorePage(true);
      infoPageData.value = response.data?.info_page;
      pinnedPostPageData.value = response.data?.pinned_post;
      postPageData.addAll(response.data?.post ?? []);
      if (response.data?.post?.isNotEmpty ?? false) {
        var postNewsCommentArr = <PostNewsComment>[];
        response.data?.post?.forEach((element) {
          postNewsCommentArr.add(PostNewsComment(
            post_id: element.post_id ?? '',
            imagePicked: null,
            commentController: TextEditingController(text: '')
          ));
        });
        postNewsCommentData.addAll(postNewsCommentArr);
      } else {
        canLoadMorePage(false);
      }
    } else {
      pageAll -= 1;
      canLoadMorePage(false);
    }
    isLoadMore(false);
  }

  showPageReview(String pageName) async {
    isLoadingReview(true);
    pageReview = 0;
    reviewPageData.value = [];
    canLoadMorePageReview(true);
    final response = await showPageGroupUseCase.execute(Tuple4('page', pageName, pageReview, ViewShowPage.reviews));
    responseShowPage.value = response;
    reviewPageData.assignAll(response.data?.school_review ?? []);
    isLoadingReview(false);
  }

  loadMoreShowPageReview(String pageName) async {
    if (isLoadMore.value) return;
    isLoadMore(true);
    pageReview += 1;
    final response = await showPageGroupUseCase.execute(Tuple4('page', pageName, pageReview, ViewShowPage.reviews));
    responseShowPage.value = response;
    if (response.code == 200) {
      canLoadMorePageReview(true);
      if (response.data?.school_review?.isNotEmpty ?? false) {
        reviewPageData.addAll(response.data?.school_review ?? []);
      } else {
        canLoadMorePageReview(false);
      }
    } else {
      pageAll -= 1;
      canLoadMorePageReview(false);
    }
    isLoadMore(false);
  }

  showPageAbout(String pageName) async {
    isLoadingAbout(true);
    aboutPageData.value = null;
    final response = await showPageGroupUseCase.execute(Tuple4('page', pageName, null, ViewShowPage.abouts));
    responseShowPage.value = response;
    aboutPageData.value = response.data?.about_page;
    isLoadingAbout(false);
  }

  postActionDeletePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.deletePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postPageDataTemp = List<PostNews>.from(postPageData);
      postPageDataTemp.removeWhere((element) => element.post_id == postId);
      postPageData.assignAll(postPageDataTemp);
    }
  }

  postActionHidePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.hidePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postPageDataTemp = List<PostNews>.from(postPageData);
      postPageDataTemp.removeWhere((element) => element.post_id == postId);
      postPageData.assignAll(postPageDataTemp);
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
      final postPageDataTemp = List<PostNews>.from(postPageData);
      for (var i = 0; i < postPageDataTemp.length; i++) {
        if (postPageDataTemp[i].post_id == postId) {
          postPageDataTemp[i].pinned = true;
          pinnedPostPageData.value = postPageDataTemp[i];
        } else {
          postPageDataTemp[i].pinned = false;
        }
      }
      postPageData.assignAll(postPageDataTemp);
    }
  }

  postActionUnPinPost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.unPinPost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      pinnedPostPageData.value = null;
      final postPageDataTemp = List<PostNews>.from(postPageData);
      int index = postPageDataTemp.indexWhere((element) => element.post_id == postId);
      postPageDataTemp[index].pinned = false;
      postPageData.assignAll(postPageDataTemp);
    }
  }

  pickImagePostDetailFromGallery() async {
    imagePicked.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  pickImagePageFromGallery(String postId) async {
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);
    isLoadingPickImage(true);
    postNewsCommentData.assignAll(postNewsCommentDataTemp);
    isLoadingPickImage(false);
  }

  pickImagePagePinFromGallery(String postId) async {
    final pinnedPostCommentDataTemp = PostNewsComment(
      post_id: postId,
      imagePicked: await imagePicker.pickImage(source: ImageSource.gallery),
      commentController: pinnedPostCommentData.value!.commentController
    );
    isLoadingPickImage(true);
    pinnedPostCommentData.value = pinnedPostCommentDataTemp;
    isLoadingPickImage(false);
  }

  pickImageAvatarPageFromGallery() async {
    imageAvatarPicked.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  pickImageCoverPageFromGallery() async {
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

  deleteImagePickedPageFromGallery(String postId) async {
    isLoadingPickImage(true);
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].imagePicked = null;
    postNewsCommentData.assignAll(postNewsCommentDataTemp);
    isLoadingPickImage(false);
  }

  deleteImagePickedPagePinFromGallery(String postId) async {
    isLoadingPickImage(true);
    final pinnedPostCommentDataTemp = PostNewsComment(
      post_id: postId,
      imagePicked: null,
      commentController: pinnedPostCommentData.value!.commentController
    );
    pinnedPostCommentData.value = pinnedPostCommentDataTemp;
    isLoadingPickImage(false);
  }

  createCommentFromPage(String postId, String message, Uint8List? file) async {
    isLoadingCreateComment(true);
    final postPageDataTemp = List<PostNews>.from(postPageData);
    int index = postPageDataTemp.indexWhere((element) => element.post_id == postId);
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].commentController.text = '';
    postNewsCommentDataTemp[indexComment].imagePicked = null;
    FocusManager.instance.primaryFocus?.unfocus();
    final response = await createCommentUseCase.execute(Tuple4(HandleCommentPostNews.post, postId, message, file));
    responseCreateComment.value = response;
    if (response.code == 200) {
      postPageDataTemp[index].comments = (int.parse(postPageDataTemp[index].comments ?? '0') + 1).toString();
      postPageData.assignAll(postPageDataTemp);
      postNewsCommentData.assignAll(postNewsCommentDataTemp);
      if (pinnedPostPageData.value?.post_id == postId) {
        final pinnedPostPageDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostPageData.value?.toJson())));
        pinnedPostPageDataTemp.comments = (int.parse(pinnedPostPageDataTemp.comments ?? '0') + 1).toString();
        pinnedPostPageData.value = pinnedPostPageDataTemp;
      }
    }
    isLoadingCreateComment(false);
    Get.to(
      () => NewsFeedPostDetailPage(
        from: PostNewsFrom.schoolPage,
        postId: postId,
        showComment: true,
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }

  createCommentFromPagePin(String postId, String message, Uint8List? file) async {
    isLoadingCreateComment(true);
    final postPageDataTemp = List<PostNews>.from(postPageData);
    int index = postPageDataTemp.indexWhere((element) => element.post_id == postId);
    final pinnedPostPageDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostPageData.value?.toJson())));
    final pinnedPostCommentDataTemp = PostNewsComment(
      post_id: postId,
      imagePicked: null,
      commentController: TextEditingController(text: '')
    );
    FocusManager.instance.primaryFocus?.unfocus();
    final response = await createCommentUseCase.execute(Tuple4(HandleCommentPostNews.post, postId, message, file));
    responseCreateComment.value = response;
    if (response.code == 200) {
      pinnedPostPageDataTemp.comments = (int.parse(pinnedPostPageDataTemp.comments ?? '0') + 1).toString();
      pinnedPostPageData.value = pinnedPostPageDataTemp;
      pinnedPostCommentData.value = pinnedPostCommentDataTemp;
      postPageDataTemp[index].comments = (int.parse(postPageDataTemp[index].comments ?? '0') + 1).toString();
      postPageData.assignAll(postPageDataTemp);
    }
    isLoadingCreateComment(false);
    Get.to(
      () => NewsFeedPostDetailPage(
        from: PostNewsFrom.schoolPage,
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

      final postPageDataTemp = List<PostNews>.from(postPageData);
      int index = postPageDataTemp.indexWhere((element) => element.post_id == postId);
      postPageDataTemp[index].comments = (int.parse(postPageDataTemp[index].comments ?? '0') - 1).toString();
      postPageData.assignAll(postPageDataTemp);
      if (pinnedPostPageData.value?.post_id == postId) {
        final pinnedPostPageDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostPageData.value?.toJson())));
        pinnedPostPageDataTemp.comments = (int.parse(pinnedPostPageDataTemp.comments ?? '0') - 1).toString();
        pinnedPostPageData.value = pinnedPostPageDataTemp;
      }
    }
  }

  postActionLikePostFromPostDetail(String action, String postId) async {
    isLoadingPostAction(true);
    final response = await postActionUseCase.execute(Tuple2(action, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postPageDataTemp = List<PostNews>.from(postPageData);
      final postDetailDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(postDetailData.value?.toJson())));
      int index = postPageDataTemp.indexWhere((element) => element.post_id == postId);
      if (action == ActionPostNews.likePost) {
        postPageDataTemp[index].i_like = true;
        postPageDataTemp[index].likes = (int.parse(postPageDataTemp[index].likes ?? '0') + 1).toString();
        postDetailDataTemp.i_like = true;
        postDetailDataTemp.likes = (int.parse(postDetailData.value?.likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikePost) {
        postPageDataTemp[index].i_like = false;
        postPageDataTemp[index].likes = (int.parse(postPageDataTemp[index].likes ?? '0') - 1).toString();
        postDetailDataTemp.i_like = false;
        postDetailDataTemp.likes = (int.parse(postDetailData.value?.likes ?? '0') - 1).toString();
      }
      postPageData.assignAll(postPageDataTemp);
      postDetailData.value = postDetailDataTemp;
      if (pinnedPostPageData.value?.post_id == postId) {
        final pinnedPostPageDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostPageData.value?.toJson())));
        if (action == ActionPostNews.likePost) {
          pinnedPostPageDataTemp.i_like = true;
          pinnedPostPageDataTemp.likes = (int.parse(pinnedPostPageDataTemp.likes ?? '0') + 1).toString();
        } else if (action == ActionPostNews.unLikePost) {
          pinnedPostPageDataTemp.i_like = false;
          pinnedPostPageDataTemp.likes = (int.parse(pinnedPostPageDataTemp.likes ?? '0') - 1).toString();
        }
        pinnedPostPageData.value = pinnedPostPageDataTemp;
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
      final postPageDataTemp = List<PostNews>.from(postPageData);
      int index = postPageDataTemp.indexWhere((element) => element.post_id == postId);
      postPageDataTemp[index].comments = (int.parse(postPageDataTemp[index].comments ?? '0') + 1).toString();
      postPageData.assignAll(postPageDataTemp);

      if (pinnedPostPageData.value?.post_id == postId) {
        final pinnedPostPageDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostPageData.value?.toJson())));
        pinnedPostPageDataTemp.comments = (int.parse(pinnedPostPageDataTemp.comments ?? '0') + 1).toString();
        pinnedPostPageData.value = pinnedPostPageDataTemp;
      }

      await getPost(postId);
    }
    isLoadingCreateComment(false);
  }

  pageConnectLikePage(String action, String pageId) async {
    final response = await pageConnectUseCase.execute(Tuple2(action, pageId));
    responsePageConnect.value = response;
    if (response.code == 200) {
      final infoPageDataTemp = PageJoin.fromJson(jsonDecode(jsonEncode(infoPageData.value?.toJson())));
      if (action == ActionPageConnect.pageLike) {
        infoPageDataTemp.i_like = true;
        infoPageDataTemp.page_likes = (int.parse(infoPageDataTemp.page_likes ?? '0') + 1).toString();
      } else if (action == ActionPageConnect.pageUnLike) {
        infoPageDataTemp.i_like = false;
        infoPageDataTemp.page_likes = (int.parse(infoPageDataTemp.page_likes ?? '0') - 1).toString();
      }
      infoPageData.value = infoPageDataTemp;
    }
  }

  reportPage(String pageId) async {
    final response = await reportUseCase.execute(Tuple2(ActionPageConnect.reportPage, pageId));
    responsePageAction.value = response;
    if (response.code == 200) {
      showSnackbar(SnackbarType.success, 'Thông báo', 'Báo cáo trang thành công!');
    } else if (response.code == 0) {
      showSnackbar(SnackbarType.notice, 'Thông báo', response.message ?? 'Bạn đã báo cáo về trang này rồi!');
    }
  }

  contactSchool() async {
    isSendingContact(true);
    final response = await contactSchoolUseCase.execute(Tuple4(
      infoPageData.value?.school_id,
      parentTextInputController.text,
      phoneTextInputController.text,
      studentInfoTextInputController.text
    ));
    if (response.code == 200) {
      parentTextInputController.text = '';
      phoneTextInputController.text = '';
      studentInfoTextInputController.text = '';
      Get.back();
      showSnackbar(SnackbarType.success, 'Thông báo', 'Gửi liên hệ thành công!');
    } else if (response.code == 0) {
      showSnackbar(SnackbarType.notice, 'Thông báo', response.message ?? 'Gửi liên hệ không thành công!');
    }
    isSendingContact(false);
  }

  postActionLikePostFromSchool(String action, String postId) async {
    isLoadingPostAction(true);
    final response = await postActionUseCase.execute(Tuple2(action, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postPageDataTemp = List<PostNews>.from(postPageData);
      int index = postPageDataTemp.indexWhere((element) => element.post_id == postId);
      if (action == ActionPostNews.likePost) {
        postPageDataTemp[index].i_like = true;
        postPageDataTemp[index].likes = (int.parse(postPageDataTemp[index].likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikePost) {
        postPageDataTemp[index].i_like = false;
        postPageDataTemp[index].likes = (int.parse(postPageDataTemp[index].likes ?? '0') - 1).toString();
      }
      postPageData.assignAll(postPageDataTemp);
      
      if (pinnedPostPageData.value?.post_id == postId) {
        final pinnedPostPageDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(pinnedPostPageData.value?.toJson())));
        if (action == ActionPostNews.likePost) {
          pinnedPostPageDataTemp.i_like = true;
          pinnedPostPageDataTemp.likes = (int.parse(pinnedPostPageDataTemp.likes ?? '0') + 1).toString();
        } else if (action == ActionPostNews.unLikePost) {
          pinnedPostPageDataTemp.i_like = false;
          pinnedPostPageDataTemp.likes = (int.parse(pinnedPostPageDataTemp.likes ?? '0') - 1).toString();
        }
        pinnedPostPageData.value = pinnedPostPageDataTemp;
      }
    }
    isLoadingPostAction(false);
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

  friendsConnectFollow(String friendId, String action) async {
    final response = await friendConnectUseCase.execute(Tuple2(friendId, action));
    responseFollow.value = response;
    if (response.code == 200) {
      final iFollow = action == ActionFriendsConnect.follow;
      final postPageDataTemp = List<PostNews>.from(postPageData);
      for (var i = 0; i < postPageDataTemp.length; i++) {
        if (postPageDataTemp[i].author_id == friendId) {
          postPageDataTemp[i].i_follow = iFollow;
        }
      }
      postPageData.assignAll(postPageDataTemp);
    }
  }

  editPostFromPage() async {
    isLoadingPostAction(true);
    final response = await editPostUseCase.execute(Tuple3(ActionPostNews.editPost, postNewsEdit.value?.post_id, textCreateEditPostController.text));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postPageDataTemp = List<PostNews>.from(postPageData);
      int index = postPageDataTemp.indexWhere((element) => element.post_id == postNewsEdit.value?.post_id);
      postPageDataTemp[index].text = textCreateEditPostController.text;
      postPageData.assignAll(postPageDataTemp);
    }
    isLoadingPostAction(false);
    postNewsEdit.value = null;
    textCreateEditPostController.text = '';
    Get.back();
  }

  changeAvatarCoverImagePage(String typeStr) async {
    isLoadingCreatePost(true);
    Get.back();
    var listFiles = <Uint8List>[];
    Uint8List? file = typeStr == TypeCreatePost.picturePage 
      ? await imageAvatarPicked.value?.readAsBytes() 
      : await imageCoverPicked.value?.readAsBytes();
    listFiles.add(file!);
    final response = await createPostUseCase.execute(Tuple7(
      ActionCreatePost.page, 
      infoPageData.value?.page_id ?? '', 
      typeStr,
      PrivacyCreatePost.public,
      listFiles,
      PhotoType.photo,
      null
    ));
    if (response.code == 200) {
      // final infoPageDataTemp = PageJoin.fromJson(jsonDecode(jsonEncode(infoPageData.value?.toJson())));
      // infoPageDataTemp.page_picture = response.data?.post?.page_picture ?? '';
      // infoPageDataTemp.page_cover = response.data?.post?.page_cover ?? '';
      refreshPageAll(infoPageData.value?.page_name ?? '');
    }
    isLoadingCreatePost(false);
  }

  createPostFromPage() async {
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
        ActionCreatePost.page, 
        infoPageData.value?.page_id ?? '', 
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
        refreshPageAll(infoPageData.value?.page_name ?? '');
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

  createReviewPage() async {
    Get.back();
    isLoadingCreateReview(true);
    final response = await createReviewUseCase.execute(Tuple4(
      'school', 
      infoPageData.value?.page_id ?? '', 
      rateNumber.toInt(),
      textRateController.text
    ));
    isLoadingCreateReview(false);
    if (response.code == 200) {
      showSnackbar(SnackbarType.success, 'Thông báo', 'Đánh giá trang thành công!');
      refreshPageAll(infoPageData.value?.page_name ?? '');
    } else {
      showSnackbar(SnackbarType.error, 'Thông báo', response.message ?? 'Không thể gửi thêm đánh giá!');
    }
    textRateController.text == '';
  }

}