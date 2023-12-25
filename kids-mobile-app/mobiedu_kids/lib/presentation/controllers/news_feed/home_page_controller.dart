import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_home_page.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/response_post.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/user.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/create_comment_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/home_page_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/create_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/edit_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/friend_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/post_action_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/report_use_case.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';

class HomePageController extends GetxController {
  HomePageController(
    this.homePageUseCase,
    this.createPostUseCase,
    this.postActionUseCase,
    this.getPostUseCase,
    this.createCommentUseCase,
    this.friendConnectUseCase,
    this.reportUseCase,
    this.editPostUseCase,
  );

  final HomePageUseCase homePageUseCase;
  final CreatePostUseCase createPostUseCase;
  final PostActionUseCase postActionUseCase;
  final GetPostUseCase getPostUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final FriendConnectUseCase friendConnectUseCase;
  final ReportUseCase reportUseCase;
  final EditPostUseCase editPostUseCase;

  final isLoadingAll = false.obs;
  final isLoadingFriends = false.obs;
  final canLoadMoreHome = true.obs;
  final canLoadMoreFriends = true.obs;
  final isLoadMore = false.obs;
  final isLoadMoreFriends = false.obs;
  final isRefresh = false.obs;
  final isLoadingCreatePost = false.obs;
  final isLoadingPostAction = false.obs;
  final isLoadingPost = false.obs;
  final canLoadMorePost = true.obs;
  final isLoadingCreateComment = false.obs;
  final isLoadMorePost = false.obs;

  int pageAll = 0;
  int pageFriends = 0;
  int pagePost = 0;

  var postHomeData = RxList<PostNews>([]);
  var friendsHomeData = RxList<User>([]);
  var friendsHomeDataUI = RxList<User>([]);
  var profileData = Rx<User?>(null);
  var postNewsCommentData = RxList<PostNewsComment?>([]);
  var postCommentDetailData = RxList<PostComment>([]);
  var postDetailData = Rx<PostNews?>(null);

  var responseHome = Rx<ResponseDataObject<DataHomePage>?>(null);
  var responsePostAction = Rx<ResponseNoData?>(null);
  var responsePostDetail = Rx<ResponsePost?>(null);
  var responseCreateComment = Rx<ResponseNoData?>(null);
  var responseFollow = Rx<ResponseNoData?>(null);

  final isLoadingPickImage = false.obs;
  final ImagePicker imagePicker = ImagePicker();
  var imagePicked = Rx<XFile?>(null);
  var imageAvatarPicked = Rx<XFile?>(null);
  var imageCoverPicked = Rx<XFile?>(null);

  var commentController = TextEditingController(text: '');
  var postCommentReply = Rx<PostComment?>(null);

  var focusComment = FocusNode();

  var postNewsEdit = Rx<PostNews?>(null);
  var textCreateEditPostController = TextEditingController(text: '');

  var searchFriendController = TextEditingController(text: '');

  refreshHomePageAll(String personName) async {
    isRefresh.value = true;
    await homePageAll(personName);
    isRefresh.value = false;
  }

  homePageAll(String personName) async {
    isLoadingAll(true);
    pageAll = 0;
    postHomeData.value = [];
    postNewsCommentData.value = [];
    canLoadMoreHome(true);
    final response = await homePageUseCase.execute(Tuple3(personName, pageAll, ViewShowPage.all));
    responseHome.value = response;
    profileData.value = response.data?.profile;
    postHomeData.assignAll(response.data?.posts ?? []);
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
    isLoadingAll(false);
  }

  loadMoreHomePageAll(String personName) async {
    if (isLoadMore.value) return;
    isLoadMore(true);
    pageAll += 1;
    final response = await homePageUseCase.execute(Tuple3(personName, pageAll, ViewShowPage.all));
    responseHome.value = response;
    if (response.code == 200) {
      canLoadMoreHome(true);
      profileData.value = response.data?.profile;
      postHomeData.addAll(response.data?.posts ?? []);
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
        canLoadMoreHome(false);
      }
    } else {
      pageAll -= 1;
      canLoadMoreHome(false);
    }
    isLoadMore(false);
  }

  homePageFriends(String personName) async {
    isLoadingFriends(true);
    pageFriends = 0;
    friendsHomeData.value = [];
    canLoadMoreFriends(true);
    final response = await homePageUseCase.execute(Tuple3(personName, pageFriends, ViewShowPage.friends));
    responseHome.value = response;
    friendsHomeData.assignAll(response.data?.friends ?? []);
    friendsHomeDataUI.assignAll(response.data?.friends ?? []);
    isLoadingFriends(false);
  }

  loadMoreHomePageFriends(String personName) async {
    if (isLoadMoreFriends.value) return;
    isLoadMoreFriends(true);
    pageFriends += 1;
    final response = await homePageUseCase.execute(Tuple3(personName, pageFriends, ViewShowPage.friends));
    responseHome.value = response;
    if (response.code == 200) {
      canLoadMoreFriends(true);
      if (response.data?.friends?.isNotEmpty ?? false) {
        friendsHomeData.addAll(response.data?.friends ?? []);
      } else {
        canLoadMoreFriends(false);
      }
    } else {
      pageFriends -= 1;
      canLoadMoreHome(false);
    }
    canLoadMoreFriends(false);
  }

  searchFriends() {
    if (searchFriendController.text.isNotEmpty) {
      friendsHomeDataUI.assignAll(friendsHomeData.where((friend) => friend.user_fullname?.toLowerCase().contains(searchFriendController.text.toLowerCase()) ?? false));
    } else {
      friendsHomeDataUI.assignAll(friendsHomeData);
    }
  }

  pickImageAvatarHomeFromGallery() async {
    imageAvatarPicked.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  pickImageCoverHomeFromGallery() async {
    imageCoverPicked.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  pickImagePostDetailFromGallery() async {
    imagePicked.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  pickImageHomeFromGallery(String postId) async {
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);
    isLoadingPickImage(true);
    postNewsCommentData.assignAll(postNewsCommentDataTemp);
    isLoadingPickImage(false);
  }

  deleteImagePickedHomeFromGallery(String postId) async {
    isLoadingPickImage(true);
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].imagePicked = null;
    postNewsCommentData.assignAll(postNewsCommentDataTemp);
    isLoadingPickImage(false);
  }

  changeAvatarCoverImageHome(String typeStr) async {
    isLoadingCreatePost(true);
    Get.back();
    var listFiles = <Uint8List>[];
    Uint8List? file = typeStr == TypeCreatePost.pictureUser 
      ? await imageAvatarPicked.value?.readAsBytes() 
      : await imageCoverPicked.value?.readAsBytes();
    listFiles.add(file!);
    final response = await createPostUseCase.execute(Tuple7(
      ActionCreatePost.me, 
      profileData.value?.user_id ?? '', 
      typeStr,
      PrivacyCreatePost.public,
      listFiles,
      PhotoType.photo,
      null
    ));
    if (response.code == 200) {
      // final profileDataTemp = User.fromJson(jsonDecode(jsonEncode(profileData.value?.toJson())));
      // profileDataTemp.user_picture = response.data?.post?.user_picture ?? '';
      // profileDataTemp.user_cover = response.data?.post?.user_cover ?? '';
      refreshHomePageAll(profileData.value?.user_name ?? '');
    }
    isLoadingCreatePost(false);
  }

  postActionLikePostFromHome(String action, String postId) async {
    isLoadingPostAction(true);
    final response = await postActionUseCase.execute(Tuple2(action, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postHomeDataTemp = List<PostNews>.from(postHomeData);
      int index = postHomeDataTemp.indexWhere((element) => element.post_id == postId);
      if (action == ActionPostNews.likePost) {
        postHomeDataTemp[index].i_like = true;
        postHomeDataTemp[index].likes = (int.parse(postHomeDataTemp[index].likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikePost) {
        postHomeDataTemp[index].i_like = false;
        postHomeDataTemp[index].likes = (int.parse(postHomeDataTemp[index].likes ?? '0') - 1).toString();
      }
      postHomeData.assignAll(postHomeDataTemp);
    }
    isLoadingPostAction(false);
  }

  postActionLikePostFromPostDetail(String action, String postId) async {
    isLoadingPostAction(true);
    final response = await postActionUseCase.execute(Tuple2(action, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postHomeDataTemp = List<PostNews>.from(postHomeData);
      final postDetailDataTemp = PostNews.fromJson(jsonDecode(jsonEncode(postDetailData.value?.toJson())));
      int index = postHomeDataTemp.indexWhere((element) => element.post_id == postId);
      if (action == ActionPostNews.likePost) {
        postHomeDataTemp[index].i_like = true;
        postHomeDataTemp[index].likes = (int.parse(postHomeDataTemp[index].likes ?? '0') + 1).toString();
        postDetailDataTemp.i_like = true;
        postDetailDataTemp.likes = (int.parse(postDetailData.value?.likes ?? '0') + 1).toString();
      } else if (action == ActionPostNews.unLikePost) {
        postHomeDataTemp[index].i_like = false;
        postHomeDataTemp[index].likes = (int.parse(postHomeDataTemp[index].likes ?? '0') - 1).toString();
        postDetailDataTemp.i_like = false;
        postDetailDataTemp.likes = (int.parse(postDetailData.value?.likes ?? '0') - 1).toString();
      }
      postHomeData.assignAll(postHomeDataTemp);
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

      final postHomeDataTemp = List<PostNews>.from(postHomeData);
      int index = postHomeDataTemp.indexWhere((element) => element.post_id == postId);
      postHomeDataTemp[index].comments = (int.parse(postHomeDataTemp[index].comments ?? '0') - 1).toString();
      postHomeData.assignAll(postHomeDataTemp);
    }
  }

  postActionDeletePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.deletePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postHomeDataTemp = List<PostNews>.from(postHomeData);
      postHomeDataTemp.removeWhere((element) => element.post_id == postId);
      postHomeData.assignAll(postHomeDataTemp);
    }
  }

  friendsConnectFollow(String friendId, String action) async {
    final response = await friendConnectUseCase.execute(Tuple2(friendId, action));
    responseFollow.value = response;
    if (response.code == 200) {
      final iFollow = action == ActionFriendsConnect.follow;
      final profileDataTemp = User.fromJson(jsonDecode(jsonEncode(profileData.value?.toJson())));
      profileDataTemp.i_follow = iFollow;
      profileData.value = profileDataTemp;
      final postHomeDataTemp = List<PostNews>.from(postHomeData);
      for (var i = 0; i < postHomeDataTemp.length; i++) {
        if (postHomeDataTemp[i].author_id == friendId) {
          postHomeDataTemp[i].i_follow = iFollow;
        }
      }
      postHomeData.assignAll(postHomeDataTemp);
    }
  }

  friendsConnectFriend(String action) async {
    final response = await friendConnectUseCase.execute(Tuple2(profileData.value?.user_id ?? '', action));
    if (response.code == 200) {
      if (action == ActionFriendsConnect.block) {
        Get.back();
      } else {
        final profileDataTemp = User.fromJson(jsonDecode(jsonEncode(profileData.value?.toJson())));
        if (action == ActionFriendsConnect.friendRemove) {
          profileDataTemp.we_friends = false;
          profileDataTemp.i_request = false;
        } else if (action == ActionFriendsConnect.friendAdd) {
          profileDataTemp.we_friends = false;
          profileDataTemp.i_request = true;
        } else if (action == ActionFriendsConnect.friendCancel) {
          profileDataTemp.we_friends = false;
          profileDataTemp.i_request = false;
        }
        profileData.value = profileDataTemp;
      }
    }
  }

  createCommentFromHome(String postId, String message, Uint8List? file) async {
    isLoadingCreateComment(true);
    final postHomeDataTemp = List<PostNews>.from(postHomeData);
    int index = postHomeDataTemp.indexWhere((element) => element.post_id == postId);
    final postNewsCommentDataTemp = List<PostNewsComment>.from(postNewsCommentData);
    int indexComment = postNewsCommentDataTemp.indexWhere((element) => element.post_id == postId);
    postNewsCommentDataTemp[indexComment].commentController.text = '';
    postNewsCommentDataTemp[indexComment].imagePicked = null;
    FocusManager.instance.primaryFocus?.unfocus();
    final response = await createCommentUseCase.execute(Tuple4(HandleCommentPostNews.post, postId, message, file));
    responseCreateComment.value = response;
    if (response.code == 200) {
      postHomeDataTemp[index].comments = (int.parse(postHomeDataTemp[index].comments ?? '0') + 1).toString();
      postHomeData.assignAll(postHomeDataTemp);
      postNewsCommentData.assignAll(postNewsCommentDataTemp);
    }
    isLoadingCreateComment(false);
    Get.to(
      () => NewsFeedPostDetailPage(
        from: PostNewsFrom.personPage,
        postId: postId,
        showComment: true,
        personName: profileData.value?.user_name ?? '',
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
      final postHomeDataTemp = List<PostNews>.from(postHomeData);
      int index = postHomeDataTemp.indexWhere((element) => element.post_id == postId);
      postHomeDataTemp[index].comments = (int.parse(postHomeDataTemp[index].comments ?? '0') + 1).toString();
      postHomeData.assignAll(postHomeDataTemp);

      await getPost(postId);
    }
    isLoadingCreateComment(false);
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

  postActionHidePost(String postId) async {
    final response = await postActionUseCase.execute(Tuple2(ActionPostNews.hidePost, postId));
    responsePostAction.value = response;
    if (response.code == 200) {
      final postHomeDataTemp = List<PostNews>.from(postHomeData);
      postHomeDataTemp.removeWhere((element) => element.post_id == postId);
      postHomeData.assignAll(postHomeDataTemp);
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

  reportUser() async {
    final response = await reportUseCase.execute(Tuple2(ActionPostNews.reportUser, profileData.value?.user_id ?? ''));
    if (response.code == 200) {
      showSnackbar(SnackbarType.success, 'Thông báo', 'Báo cáo người dùng thành công!');
    } else if (response.code == 0) {
      showSnackbar(SnackbarType.notice, 'Thông báo', response.message ?? 'Bạn đã báo cáo người dùng này rồi!');
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
      final postHomeDataTemp = List<PostNews>.from(postHomeData);
      int index = postHomeDataTemp.indexWhere((element) => element.post_id == postNewsEdit.value?.post_id);
      postHomeDataTemp[index].text = textCreateEditPostController.text;
      postHomeData.assignAll(postHomeDataTemp);
    }
    isLoadingPostAction(false);
    postNewsEdit.value = null;
    textCreateEditPostController.text = '';
    Get.back();
  }
}