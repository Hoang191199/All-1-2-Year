import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_news_feed.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/response_post.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/create_comment_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_saved_posts_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/edit_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/friend_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/post_action_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/report_use_case.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';

class SavedPostsController extends GetxController {
  SavedPostsController(
    this.getSavedPostsUseCase,
    this.postActionUseCase,
    this.createCommentUseCase,
    this.friendConnectUseCase,
    this.reportUseCase,
    this.editPostUseCase,
    this.getPostUseCase,
  );

  final GetSavedPostsUseCase getSavedPostsUseCase;
  final PostActionUseCase postActionUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final FriendConnectUseCase friendConnectUseCase;
  final ReportUseCase reportUseCase;
  final EditPostUseCase editPostUseCase;
  final GetPostUseCase getPostUseCase;

  final isLoadingSavedPost = false.obs;
  final canLoadMoreSavedPost = true.obs;
  final isLoadMore = false.obs;
  final isRefresh = false.obs;
  final isLoadingPostAction = false.obs;
  final isLoadingCreateComment = false.obs;
  final isLoadingPost = false.obs;
  final canLoadMorePost = true.obs;
  final isLoadMorePost = false.obs;

  int pageSavedPost = 0;
  int pagePost = 0;

  var savedPostData = RxList<PostNews>([]);
  var postNewsCommentData = RxList<PostNewsComment?>([]);
  var postCommentDetailData = RxList<PostComment>([]);
  var postDetailData = Rx<PostNews?>(null);

  var responseSavedPost = Rx<ResponseDataObject<DataNewsFeed>?>(null);
  var responsePostAction = Rx<ResponseNoData?>(null);
  var responseCreateComment = Rx<ResponseNoData?>(null);
  var responseFollow = Rx<ResponseNoData?>(null);
  var responsePostDetail = Rx<ResponsePost?>(null);

  final isLoadingPickImage = false.obs;
  final ImagePicker imagePicker = ImagePicker();
  var imagePicked = Rx<XFile?>(null);

  var postNewsEdit = Rx<PostNews?>(null);
  var textCreateEditPostController = TextEditingController(text: '');

  var commentController = TextEditingController(text: '');
  var postCommentReply = Rx<PostComment?>(null);

  var focusComment = FocusNode();

  refreshSavedPost() async {
    isRefresh.value = true;
    await getSavedPost();
    isRefresh.value = false;
  }

  getSavedPost() async {
    isLoadingSavedPost(true);
    pageSavedPost = 0;
    savedPostData.value = [];
    postNewsCommentData.value = [];
    canLoadMoreSavedPost(true);
    final response = await getSavedPostsUseCase.execute(pageSavedPost);
    responseSavedPost.value = response;
    savedPostData.assignAll(response.data?.posts ?? []);
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
    isLoadingSavedPost(false);
  }

  loadMoreSavedPost() async {
    if (isLoadMore.value) return;
    isLoadMore(true);
    pageSavedPost += 1;
    final response = await getSavedPostsUseCase.execute(pageSavedPost);
    responseSavedPost.value = response;
    if (response.code == 200) {
      canLoadMoreSavedPost(true);
      savedPostData.addAll(response.data?.posts ?? []);
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
        canLoadMoreSavedPost(false);
      }
    } else {
      pageSavedPost -= 1;
      canLoadMoreSavedPost(false);
    }
    isLoadMore(false);
  }

  postActionLikePostFromSavedPost(String action, String postId) async {
    isLoadingPostAction(true);
    final response = await postActionUseCase.execute(Tuple2(action, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final savedPostDataTemp = List<PostNews>.from(savedPostData);
      int index = savedPostDataTemp.indexWhere((element) => element.post_id == postId);
      if (action == ActionPostNews.likePost) {
        savedPostDataTemp[index].i_like = true;
        savedPostDataTemp[index].likes = (int.parse(savedPostDataTemp[index].likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikePost) {
        savedPostDataTemp[index].i_like = false;
        savedPostDataTemp[index].likes = (int.parse(savedPostDataTemp[index].likes ?? '0') - 1).toString();
      }
      savedPostData.assignAll(savedPostDataTemp);
    }
    isLoadingPostAction(false);
  }

  postActionDeletePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.deletePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final savedPostDataTemp = List<PostNews>.from(savedPostData);
      savedPostDataTemp.removeWhere((element) => element.post_id == postId);
      savedPostData.assignAll(savedPostDataTemp);
    }
  }

  friendsConnectFollow(String friendId, String action) async {
    final response = await friendConnectUseCase.execute(Tuple2(friendId, action));
    responseFollow.value = response;
    if (response.code == 200) {
      final iFollow = action == ActionFriendsConnect.follow;
      final savedPostDataTemp = List<PostNews>.from(savedPostData);
      for (var i = 0; i < savedPostDataTemp.length; i++) {
        if (savedPostDataTemp[i].author_id == friendId) {
          savedPostDataTemp[i].i_follow = iFollow;
        }
      }
      savedPostData.assignAll(savedPostDataTemp);
    }
  }

  createCommentFromSavedPost(String postId, String message, Uint8List? file) async {
    isLoadingCreateComment(true);
    final savedPostDataTemp = List<PostNews>.from(savedPostData);
    int index = savedPostDataTemp.indexWhere((element) => element.post_id == postId);
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].commentController.text = '';
    postNewsCommentDataTemp[indexComment].imagePicked = null;
    FocusManager.instance.primaryFocus?.unfocus();
    final response = await createCommentUseCase.execute(Tuple4(HandleCommentPostNews.post, postId, message, file));
    responseCreateComment.value = response;
    if (response.code == 200) {
      savedPostDataTemp[index].comments = (int.parse(savedPostDataTemp[index].comments ?? '0') + 1).toString();
      savedPostData.assignAll(savedPostDataTemp);
      postNewsCommentData.assignAll(postNewsCommentDataTemp);
    }
    isLoadingCreateComment(false);
    Get.to(
      () => NewsFeedPostDetailPage(
        from: PostNewsFrom.savedPostPage,
        postId: postId,
        showComment: true,
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }

  pickImagePostDetailFromGallery() async {
    imagePicked.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  pickImageSavedPostFromGallery(String postId) async {
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);
    isLoadingPickImage(true);
    postNewsCommentData.assignAll(postNewsCommentDataTemp);
    isLoadingPickImage(false);
  }

  deleteImagePickedSavedPostFromGallery(String postId) async {
    isLoadingPickImage(true);
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].imagePicked = null;
    postNewsCommentData.assignAll(postNewsCommentDataTemp);
    isLoadingPickImage(false);
  }

  postActionHidePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.hidePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final savedPostDataTemp = List<PostNews>.from(savedPostData);
      savedPostDataTemp.removeWhere((element) => element.post_id == postId);
      savedPostData.assignAll(savedPostDataTemp);
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

  editPostFromHome() async {
    isLoadingPostAction(true);
    final response = await editPostUseCase.execute(Tuple3(ActionPostNews.editPost, postNewsEdit.value?.post_id, textCreateEditPostController.text));
    responsePostAction.value = response;
    if (response.code == 200) {
      final savedPostDataTemp = List<PostNews>.from(savedPostData);
      int index = savedPostDataTemp.indexWhere((element) => element.post_id == postNewsEdit.value?.post_id);
      savedPostDataTemp[index].text = textCreateEditPostController.text;
      savedPostData.assignAll(savedPostDataTemp);
    }
    isLoadingPostAction(false);
    postNewsEdit.value = null;
    textCreateEditPostController.text = '';
    Get.back();
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
      final savedPostDataTemp = List<PostNews>.from(savedPostData);
      final postDetailDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(postDetailData.value?.toJson())));
      int index = savedPostDataTemp.indexWhere((element) => element.post_id == postId);
      if (action == ActionPostNews.likePost) {
        savedPostDataTemp[index].i_like = true;
        savedPostDataTemp[index].likes = (int.parse(savedPostDataTemp[index].likes ?? '0') + 1).toString();
        postDetailDataTemp.i_like = true;
        postDetailDataTemp.likes = (int.parse(postDetailData.value?.likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikePost) {
        savedPostDataTemp[index].i_like = false;
        savedPostDataTemp[index].likes = (int.parse(savedPostDataTemp[index].likes ?? '0') - 1).toString();
        postDetailDataTemp.i_like = false;
        postDetailDataTemp.likes = (int.parse(postDetailData.value?.likes ?? '0') - 1).toString();
      }
      savedPostData.assignAll(savedPostDataTemp);
      postDetailData.value = postDetailDataTemp;
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
      final savedPostDataTemp = List<PostNews>.from(savedPostData);
      int index = savedPostDataTemp.indexWhere((element) => element.post_id == postId);
      savedPostDataTemp[index].comments = (int.parse(savedPostDataTemp[index].comments ?? '0') + 1).toString();
      savedPostData.assignAll(savedPostDataTemp);

      await getPost(postId);
    }
    isLoadingCreateComment(false);
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

      final savedPostDataTemp = List<PostNews>.from(savedPostData);
      int index = savedPostDataTemp.indexWhere((element) => element.post_id == postId);
      savedPostDataTemp[index].comments = (int.parse(savedPostDataTemp[index].comments ?? '0') - 1).toString();
      savedPostData.assignAll(savedPostDataTemp);
    }
  }
}