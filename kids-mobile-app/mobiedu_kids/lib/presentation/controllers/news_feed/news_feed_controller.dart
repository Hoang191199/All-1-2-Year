import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_news_feed.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/group_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_group.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/response_post.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/create_comment_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/news_feed_search_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/news_feed_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/page_group_join_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/edit_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/friend_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/post_action_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/report_use_case.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';

class NewsFeedController extends GetxController {
  NewsFeedController(
    this.newsFeedUseCase,
    this.pageGroupJoinUseCase,
    this.postActionUseCase,
    this.getPostUseCase,
    this.createCommentUseCase,
    this.friendConnectUseCase,
    this.reportUseCase,
    this.newsFeedSearchUseCase,
    this.editPostUseCase,
  );

  final NewsFeedUseCase newsFeedUseCase;
  final PageGroupJoinUseCase pageGroupJoinUseCase;
  final PostActionUseCase postActionUseCase;
  final GetPostUseCase getPostUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final FriendConnectUseCase friendConnectUseCase;
  final ReportUseCase reportUseCase;
  final NewsFeedSearchUseCase newsFeedSearchUseCase;
  final EditPostUseCase editPostUseCase;
  
  final folded = true.obs;
  final isLoadingNewsFeed = false.obs;
  final isLoadingPageGroup = false.obs;
  final isRefresh = false.obs;
  var responsePageGroup = Rx<ResponseDataObject<PageGroup>?>(null);
  var pageJoinData = RxList<PageJoin?>([]);
  var groupJoinData = RxList<GroupJoin?>([]);
  int page = 0;
  var responseNewsFeed = Rx<ResponseDataObject<DataNewsFeed>?>(null);
  var postNewsData = RxList<PostNews>([]);
  var postNewsCommentData = RxList<PostNewsComment?>([]);
  final isLoadMore = false.obs;
  final canLoadMoreNewsFeed = true.obs;
  final isLoadingPostAction = false.obs;
  var responsePostAction = Rx<ResponseNoData?>(null);
  final isLoadingPost = false.obs;
  int pagePost = 0;
  var responsePostDetail = Rx<ResponsePost?>(null);
  var postDetailData = Rx<PostNews?>(null);
  var postCommentDetailData = RxList<PostComment>([]);
  final isLoadingCreateComment = false.obs;
  var responseCreateComment = Rx<ResponseNoData?>(null);
  final isLoadMorePost = false.obs;
  final canLoadMorePost = true.obs;
  var responseFollow = Rx<ResponseNoData?>(null);

  var commentController = TextEditingController(text: '');
  var focusComment = FocusNode();

  final ImagePicker imagePicker = ImagePicker();
  var imagePicked = Rx<XFile?>(null);
  final isLoadingPickImage = false.obs;

  var postCommentReply = Rx<PostComment?>(null);

  var postNewsEdit = Rx<PostNews?>(null);
  var textCreateEditPostController = TextEditingController(text: '');

  // refreshNewsFeed() async {
  //   isRefresh.value = true;
  //   await Future.wait([
  //     getPageGroupJoined(),
  //     getListNewsFeed(),
  //   ] as Iterable<Future>);
  //   isRefresh.value = false;
  // }

  getListNewsFeed() async {
    isLoadingNewsFeed(true);
    page = 0;
    postNewsData.value = [];
    postNewsCommentData.value = [];
    canLoadMoreNewsFeed(true);
    final response = await newsFeedUseCase.execute(page);
    responseNewsFeed.value = response;
    postNewsData.assignAll(response.data?.posts ?? []);
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
    isLoadingNewsFeed(false);
  }

  loadMoreNewsFeed() async {
    if (isLoadMore.value) return;
    isLoadMore(true);
    page += 1;
    final response = await newsFeedUseCase.execute(page);
    responseNewsFeed.value = response;
    if (response.code == 200) {
      canLoadMoreNewsFeed(true);
      postNewsData.addAll(response.data?.posts ?? []);
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
        canLoadMoreNewsFeed(false);
      }
    } else {
      page -= 1;
      canLoadMoreNewsFeed(false);
    }
    isLoadMore(false);
  }

  getPageGroupJoined() async {
    isLoadingPageGroup(true);
    pageJoinData.value = [];
    final response = await pageGroupJoinUseCase.execute();
    responsePageGroup.value = response;
    pageJoinData.assignAll(response.data?.pages ?? []);
    groupJoinData.assignAll(response.data?.groups ?? []);
    isLoadingPageGroup(false);
  }

  postActionLikePostFromNewsFeed(String action, String postId) async {
    isLoadingPostAction(true);
    final response = await postActionUseCase.execute(Tuple2(action, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postNewsDataTemp = List<PostNews>.from(postNewsData);
      int index = postNewsDataTemp.indexWhere((element) => element.post_id == postId);
      if (action == ActionPostNews.likePost) {
        postNewsDataTemp[index].i_like = true;
        postNewsDataTemp[index].likes = (int.parse(postNewsDataTemp[index].likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikePost) {
        postNewsDataTemp[index].i_like = false;
        postNewsDataTemp[index].likes = (int.parse(postNewsDataTemp[index].likes ?? '0') - 1).toString();
      }
      postNewsData.assignAll(postNewsDataTemp);
    }
    isLoadingPostAction(false);
  }

  postActionLikePostFromPostDetail(String action, String postId) async {
    isLoadingPostAction(true);
    final response = await postActionUseCase.execute(Tuple2(action, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postNewsDataTemp = List<PostNews>.from(postNewsData);
      final postDetailDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(postDetailData.value?.toJson())));
      int index = postNewsDataTemp.indexWhere((element) => element.post_id == postId);
      if (action == ActionPostNews.likePost) {
        postNewsDataTemp[index].i_like = true;
        postNewsDataTemp[index].likes = (int.parse(postNewsDataTemp[index].likes ?? '0') + 1).toString();
        postDetailDataTemp.i_like = true;
        postDetailDataTemp.likes = (int.parse(postDetailData.value?.likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikePost) {
        postNewsDataTemp[index].i_like = false;
        postNewsDataTemp[index].likes = (int.parse(postNewsDataTemp[index].likes ?? '0') - 1).toString();
        postDetailDataTemp.i_like = false;
        postDetailDataTemp.likes = (int.parse(postDetailData.value?.likes ?? '0') - 1).toString();
      }
      postNewsData.assignAll(postNewsDataTemp);
      postDetailData.value = postDetailDataTemp;
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

      final postNewsDataTemp = List<PostNews>.from(postNewsData);
      int index = postNewsDataTemp.indexWhere((element) => element.post_id == postId);
      postNewsDataTemp[index].comments = (int.parse(postNewsDataTemp[index].comments ?? '0') - 1).toString();
      postNewsData.assignAll(postNewsDataTemp);
    }
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

  postActionDeletePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.deletePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postNewsDataTemp = List<PostNews>.from(postNewsData);
      postNewsDataTemp.removeWhere((element) => element.post_id == postId);
      postNewsData.assignAll(postNewsDataTemp);
    }
  }

  postActionHidePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.hidePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postNewsDataTemp = List<PostNews>.from(postNewsData);
      postNewsDataTemp.removeWhere((element) => element.post_id == postId);
      postNewsData.assignAll(postNewsDataTemp);
    }
  }

  postActionSavePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.savePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      showSnackbar(SnackbarType.success, 'Thông báo', 'Lưu bài viết thành công!');
    }
  }

  initialPostDetail(String postId) {
    imagePicked.value = null;
    commentController.text = '';
    getPost(postId);
  }

  getPost(String postId) async {
    isLoadingPost(true);
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
    isLoadingPost(false);
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

  createCommentFromNewsFeed(String postId, String message, Uint8List? file) async {
    isLoadingCreateComment(true);
    final postNewsDataTemp = List<PostNews>.from(postNewsData);
    int index = postNewsDataTemp.indexWhere((element) => element.post_id == postId);
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].commentController.text = '';
    postNewsCommentDataTemp[indexComment].imagePicked = null;
    FocusManager.instance.primaryFocus?.unfocus();
    final response = await createCommentUseCase.execute(Tuple4(HandleCommentPostNews.post, postId, message, file));
    responseCreateComment.value = response;
    if (response.code == 200) {
      postNewsDataTemp[index].comments = (int.parse(postNewsDataTemp[index].comments ?? '0') + 1).toString();
      postNewsData.assignAll(postNewsDataTemp);
      postNewsCommentData.assignAll(postNewsCommentDataTemp);
    }
    isLoadingCreateComment(false);
    Get.to(
      () => NewsFeedPostDetailPage(
        from: PostNewsFrom.newsFeedPage,
        postId: postId,
        showComment: true,
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
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
      final postNewsDataTemp = List<PostNews>.from(postNewsData);
      int index = postNewsDataTemp.indexWhere((element) => element.post_id == postId);
      postNewsDataTemp[index].comments = (int.parse(postNewsDataTemp[index].comments ?? '0') + 1).toString();
      postNewsData.assignAll(postNewsDataTemp);

      await getPost(postId);
    }
    isLoadingCreateComment(false);
  }

  friendsConnectFollow(String friendId, String action) async {
    final response = await friendConnectUseCase.execute(Tuple2(friendId, action));
    responseFollow.value = response;
    if (response.code == 200) {
      final iFollow = action == ActionFriendsConnect.follow;
      final postNewsDataTemp = List<PostNews>.from(postNewsData);
      for (var i = 0; i < postNewsDataTemp.length; i++) {
        if (postNewsDataTemp[i].author_id == friendId) {
          postNewsDataTemp[i].i_follow = iFollow;
        }
      }
      postNewsData.assignAll(postNewsDataTemp);
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

  pickImagePostDetailFromGallery() async {
    imagePicked.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  pickImageNewsFeedFromGallery(String postId) async {
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);
    isLoadingPickImage(true);
    postNewsCommentData.assignAll(postNewsCommentDataTemp);
    isLoadingPickImage(false);
  }

  deleteImagePickedNewsFeedFromGallery(String postId) async {
    isLoadingPickImage(true);
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].imagePicked = null;
    postNewsCommentData.assignAll(postNewsCommentDataTemp);
    isLoadingPickImage(false);
  }

  editPostFromNewsFeed() async {
    isLoadingPostAction(true);
    final response = await editPostUseCase.execute(Tuple3(ActionPostNews.editPost, postNewsEdit.value?.post_id, textCreateEditPostController.text));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postNewsDataTemp = List<PostNews>.from(postNewsData);
      int index = postNewsDataTemp.indexWhere((element) => element.post_id == postNewsEdit.value?.post_id);
      postNewsDataTemp[index].text = textCreateEditPostController.text;
      postNewsData.assignAll(postNewsDataTemp);
    }
    isLoadingPostAction(false);
    postNewsEdit.value = null;
    textCreateEditPostController.text = '';
    Get.back();
  }

}