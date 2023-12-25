import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/album.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/photo_post.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/video.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_album_social_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_all_photo_albums_video_use_case.dart';

class PhotoVideoController extends GetxController {
  PhotoVideoController(
    this.getAllPhotoAlbumsVideoUseCase,
    this.getAlbumSocialUseCase,
  );
  
  final GetAllPhotoAlbumsVideoUseCase getAllPhotoAlbumsVideoUseCase;
  final GetAlbumSocialUseCase getAlbumSocialUseCase;

  final isLoadingPhoto = false.obs;
  final isLoadingAlbums = false.obs;
  final isLoadingAlbum = false.obs;
  final isLoadingVideo = false.obs;
  final canLoadMorePhoto = true.obs;
  final canLoadMoreAlbums = true.obs;
  final canLoadMoreAlbum = true.obs;
  final canLoadMoreVideo = true.obs;
  final isRefresh = false.obs;
  final isLoadMorePhotoAll = false.obs;
  final isLoadMoreAlbums = false.obs;
  final isLoadMoreAlbum = false.obs;
  final isLoadMoreVideo = false.obs;
  int pagePhoto = 0;
  int pageAlbums = 0;
  int pageAlbum = 0;
  int pageVideo = 0;
  var photoPageData = RxList<PhotoPost>([]);
  var photoGroupData = RxList<PhotoPost>([]);
  var photoHomeData = RxList<PhotoPost>([]);
  var albumsPageData = RxList<Album>([]);
  var albumsGroupData = RxList<Album>([]);
  var albumsHomeData = RxList<Album>([]);
  var albumPageData = Rx<Album?>(null);
  var albumGroupData = Rx<Album?>(null);
  var albumHomeData = Rx<Album?>(null);
  var videoPageData = RxList<Video>([]);
  var videoGroupData = RxList<Video>([]);
  var videoHomeData = RxList<Video>([]);

  final photoType = PhotoType.photo.obs;

  refreshAllPhoto(String typeOwner, String id, double heightContain, double heightItem) async {
    isRefresh.value = true;
    await getAllPhoto(typeOwner, id, heightContain, heightItem);
    isRefresh.value = false;
  }

  getAllPhoto(String typeOwner, String id, double heightContain, double heightItem) async {
    isLoadingPhoto(true);
    pagePhoto = 0;
    photoPageData.value = [];
    canLoadMorePhoto(true);
    final response = await getAllPhotoAlbumsVideoUseCase.execute(Tuple4(PhotoType.photo, typeOwner, id, pagePhoto));
    if (typeOwner == TypeGetPhoto.page) {
      photoPageData.assignAll(response.data?.photos ?? []);
    } else if (typeOwner == TypeGetPhoto.group) {
      photoGroupData.assignAll(response.data?.photos ?? []);
    } else if (typeOwner == TypeGetPhoto.user) {
      photoHomeData.assignAll(response.data?.photos ?? []);
    }
    if (response.code == 200 && (response.data?.photos?.isNotEmpty ?? false)) {
      final numberPageByScreen = (heightContain / (((response.data?.photos?.length ?? 0) / 3).ceil() * heightItem)).floor();
      if (numberPageByScreen > 0) {
        await getPhotoByScreen(typeOwner, id, numberPageByScreen);
      }
    }
    isLoadingPhoto(false);
  }

  getPhotoByScreen(String typeOwner, String id, int numberPageByScreen) async {
    if (pagePhoto < numberPageByScreen) {
      pagePhoto += 1;
      final response = await getAllPhotoAlbumsVideoUseCase.execute(Tuple4(PhotoType.photo, typeOwner, id, pagePhoto));
      if (response.data?.photos?.isNotEmpty ?? false) {
        canLoadMorePhoto(true);
        if (typeOwner == TypeGetPhoto.page) {
          photoPageData.addAll(response.data?.photos ?? []);
        } else if (typeOwner == TypeGetPhoto.group) {
          photoGroupData.addAll(response.data?.photos ?? []);
        } else if (typeOwner == TypeGetPhoto.user) {
          photoHomeData.addAll(response.data?.photos ?? []);
        }
        await getPhotoByScreen(typeOwner, id, numberPageByScreen);
      } else {
        canLoadMorePhoto(false);
        pagePhoto -= 1;
      }
    }
  }

  loadMoreAllPhoto(String typeOwner, String id) async {
    if (isLoadMorePhotoAll.value) return;
    isLoadMorePhotoAll(true);
    pagePhoto += 1;
    final response = await getAllPhotoAlbumsVideoUseCase.execute(Tuple4(PhotoType.photo, typeOwner, id, pagePhoto));
    if (response.code == 200) {
      canLoadMorePhoto(true);
      if (response.data?.photos?.isNotEmpty ?? false) {
        if (typeOwner == TypeGetPhoto.page) {
          photoPageData.addAll(response.data?.photos ?? []);
        } else if (typeOwner == TypeGetPhoto.group) {
          photoGroupData.addAll(response.data?.photos ?? []);
        } else if (typeOwner == TypeGetPhoto.user) {
          photoHomeData.addAll(response.data?.photos ?? []);
        }
      } else {
        canLoadMorePhoto(false);
      }
    } else {
      pagePhoto -= 1;
      canLoadMorePhoto(false);
    }
    isLoadMorePhotoAll(false);
  }

  refreshAlbums(String typeOwner, String name, double heightContain, double heightItem) async {
    isRefresh.value = true;
    await getAlbums(typeOwner, name, heightContain, heightItem);
    isRefresh.value = false;
  }

  getAlbums(String typeOwner, String name, double heightContain, double heightItem) async {
    isLoadingAlbums(true);
    pageAlbums = 0;
    albumsPageData.value = [];
    canLoadMoreAlbums(true);
    final response = await getAllPhotoAlbumsVideoUseCase.execute(Tuple4(PhotoType.album, typeOwner, name, pageAlbums));
    if (typeOwner == TypeGetPhoto.page) {
      albumsPageData.assignAll(response.data?.albums ?? []);
    } else if (typeOwner == TypeGetPhoto.group) {
      albumsGroupData.assignAll(response.data?.albums ?? []);
    } else if (typeOwner == TypeGetPhoto.user) {
      albumsHomeData.assignAll(response.data?.albums ?? []);
    }
    if (response.code == 200 && (response.data?.albums?.isNotEmpty ?? false)) {
      final numberPageByScreen = (heightContain / (((response.data?.albums?.length ?? 0) / 2).ceil() * heightItem)).floor();
      if (numberPageByScreen > 0) {
        await getAlbumsByScreen(typeOwner, name, numberPageByScreen);
      }
    }
    isLoadingAlbums(false);
  }

  getAlbumsByScreen(String typeOwner, String name, int numberPageByScreen) async {
    if (pageAlbums < numberPageByScreen) {
      pageAlbums += 1;
      final response = await getAllPhotoAlbumsVideoUseCase.execute(Tuple4(PhotoType.album, typeOwner, name, pageAlbums));
      if (response.data?.albums?.isNotEmpty ?? false) {
        canLoadMoreAlbums(true);
        if (typeOwner == TypeGetPhoto.page) {
          albumsPageData.addAll(response.data?.albums ?? []);
        } else if (typeOwner == TypeGetPhoto.group) {
          albumsGroupData.addAll(response.data?.albums ?? []);
        } else if (typeOwner == TypeGetPhoto.user) {
          albumsHomeData.addAll(response.data?.albums ?? []);
        }
        await getAlbumsByScreen(typeOwner, name, numberPageByScreen);
      } else {
        canLoadMoreAlbums(false);
        pageAlbums -= 1;
      }
    }
  }

  loadMoreAlbums(String typeOwner, String name) async {
    if (isLoadMoreAlbums.value) return;
    isLoadMoreAlbums(true);
    pageAlbums += 1;
    final response = await getAllPhotoAlbumsVideoUseCase.execute(Tuple4(PhotoType.album, typeOwner, name, pageAlbums));
    if (response.code == 200) {
      canLoadMoreAlbums(true);
      if (response.data?.photos?.isNotEmpty ?? false) {
        if (typeOwner == TypeGetPhoto.page) {
          albumsPageData.addAll(response.data?.albums ?? []);
        } else if (typeOwner == TypeGetPhoto.group) {
          albumsGroupData.addAll(response.data?.albums ?? []);
        } else if (typeOwner == TypeGetPhoto.user) {
          albumsHomeData.addAll(response.data?.albums ?? []);
        }
      } else {
        canLoadMoreAlbums(false);
      }
    } else {
      pageAlbums -= 1;
      canLoadMoreAlbums(false);
    }
    isLoadMoreAlbums(false);
  }

  refreshAlbum(String typeOwner, String name, String albumId, double heightContain, double heightItem) async {
    isRefresh.value = true;
    await getAlbum(typeOwner, name, albumId, heightContain, heightItem);
    isRefresh.value = false;
  }

  getAlbum(String typeOwner, String name, String albumId, double heightContain, double heightItem) async {
    isLoadingAlbum(true);
    pageAlbum = 0;
    albumPageData.value = null;
    albumGroupData.value = null;
    canLoadMoreAlbum(true);
    final response = await getAlbumSocialUseCase.execute(Tuple4(typeOwner, name, albumId, pageAlbum));
    if (typeOwner == TypeGetPhoto.page) {
      albumPageData.value = response.data?.album;
    } else if (typeOwner == TypeGetPhoto.group) {
      albumGroupData.value = response.data?.album;
    } else if (typeOwner == TypeGetPhoto.user) {
      albumHomeData.value = response.data?.album;
    }
    if (response.code == 200 && (response.data?.album?.photos?.isNotEmpty ?? false)) {
      final numberPageByScreen = (heightContain / (((response.data?.album?.photos?.length ?? 0) / 3).ceil() * heightItem)).floor();
      if (numberPageByScreen > 0) {
        await getAlbumByScreen(typeOwner, name, albumId, numberPageByScreen);
      }
    }
    isLoadingAlbum(false);
  }

  getAlbumByScreen(String typeOwner, String name, String albumId, int numberPageByScreen) async {
    if (pageAlbum < numberPageByScreen) {
      pageAlbum += 1;
      final response = await getAlbumSocialUseCase.execute(Tuple4(typeOwner, name, albumId, pageAlbum));
      if (response.data?.album?.photos?.isNotEmpty ?? false) {
        canLoadMoreAlbum(true);
        if (typeOwner == TypeGetPhoto.page) {
          final albumPageDataTemp = Album.fromJson(jsonDecode(jsonEncode(albumPageData.value?.toJson())));
          albumPageDataTemp.photos?.addAll(response.data?.album?.photos ?? []);
          albumPageData.value = albumPageDataTemp;
        } else if (typeOwner == TypeGetPhoto.group) {
          final albumGroupDataTemp = Album.fromJson(jsonDecode(jsonEncode(albumGroupData.value?.toJson())));
          albumGroupDataTemp.photos?.addAll(response.data?.album?.photos ?? []);
          albumGroupData.value = albumGroupDataTemp;
        } else if (typeOwner == TypeGetPhoto.user) {
          final albumHomeDataTemp = Album.fromJson(jsonDecode(jsonEncode(albumHomeData.value?.toJson())));
          albumHomeDataTemp.photos?.addAll(response.data?.album?.photos ?? []);
          albumHomeData.value = albumHomeDataTemp;
        }
        await getAlbumsByScreen(typeOwner, name, numberPageByScreen);
      } else {
        canLoadMoreAlbum(false);
        pageAlbum -= 1;
      }
    }
  }

  loadMoreAlbum(String typeOwner, String name, String albumId) async {
    if (isLoadMoreAlbum.value) return;
    isLoadMoreAlbum(true);
    pageAlbum += 1;
    final response = await getAlbumSocialUseCase.execute(Tuple4(typeOwner, name, albumId, pageAlbum));
    if (response.code == 200) {
      canLoadMoreAlbum(true);
      if (response.data?.photos?.isNotEmpty ?? false) {
        if (typeOwner == TypeGetPhoto.page) {
          final albumPageDataTemp = Album.fromJson(jsonDecode(jsonEncode(albumPageData.value?.toJson())));
          albumPageDataTemp.photos?.addAll(response.data?.album?.photos ?? []);
          albumPageData.value = albumPageDataTemp;
        } else if (typeOwner == TypeGetPhoto.group) {
          final albumGroupDataTemp = Album.fromJson(jsonDecode(jsonEncode(albumGroupData.value?.toJson())));
          albumGroupDataTemp.photos?.addAll(response.data?.album?.photos ?? []);
          albumGroupData.value = albumGroupDataTemp;
        } else if (typeOwner == TypeGetPhoto.user) {
          final albumHomeDataTemp = Album.fromJson(jsonDecode(jsonEncode(albumHomeData.value?.toJson())));
          albumHomeDataTemp.photos?.addAll(response.data?.album?.photos ?? []);
          albumHomeData.value = albumHomeDataTemp;
        }
      } else {
        canLoadMoreAlbum(false);
      }
    } else {
      pageAlbum -= 1;
      canLoadMoreAlbum(false);
    }
    isLoadMoreAlbums(false);
  }

  refreshAllVideo(String typeOwner, String id, double heightContain, double heightItem) async {
    isRefresh.value = true;
    await getAllVideo(typeOwner, id, heightContain, heightItem);
    isRefresh.value = false;
  }

  getAllVideo(String typeOwner, String id, double heightContain, double heightItem) async {
    isLoadingVideo(true);
    pageVideo = 0;
    videoPageData.value = [];
    videoGroupData.value = [];
    videoHomeData.value = [];
    canLoadMoreVideo(true);
    final response = await getAllPhotoAlbumsVideoUseCase.execute(Tuple4(PhotoType.video, typeOwner, id, pageVideo));
    if (typeOwner == TypeGetPhoto.page) {
      videoPageData.assignAll(response.data?.videos ?? []);
    } else if (typeOwner == TypeGetPhoto.group) {
      videoGroupData.assignAll(response.data?.videos ?? []);
    } else if (typeOwner == TypeGetPhoto.user) {
      videoHomeData.assignAll(response.data?.videos ?? []);
    }
    if (response.code == 200 && (response.data?.videos?.isNotEmpty ?? false)) {
      final numberPageByScreen = (heightContain / (((response.data?.videos?.length ?? 0) / 2).ceil() * heightItem)).floor();
      if (numberPageByScreen > 0) {
        await getVideoByScreen(typeOwner, id, numberPageByScreen);
      }
    }
    isLoadingVideo(false);
  }

  getVideoByScreen(String typeOwner, String id, int numberPageByScreen) async {
    if (pageVideo < numberPageByScreen) {
      pageVideo += 1;
      final response = await getAllPhotoAlbumsVideoUseCase.execute(Tuple4(PhotoType.video, typeOwner, id, pageVideo));
      if (response.data?.videos?.isNotEmpty ?? false) {
        canLoadMoreVideo(true);
        if (typeOwner == TypeGetPhoto.page) {
          videoPageData.addAll(response.data?.videos ?? []);
        } else if (typeOwner == TypeGetPhoto.group) {
          videoGroupData.addAll(response.data?.videos ?? []);
        } else if (typeOwner == TypeGetPhoto.user) {
          videoHomeData.addAll(response.data?.videos ?? []);
        }
        await getVideoByScreen(typeOwner, id, numberPageByScreen);
      } else {
        canLoadMoreVideo(false);
        pageVideo -= 1;
      }
    }
  }

  loadMoreVideo(String typeOwner, String id) async {
    if (isLoadMoreVideo.value) return;
    isLoadMoreVideo(true);
    pageVideo += 1;
    final response = await getAllPhotoAlbumsVideoUseCase.execute(Tuple4(PhotoType.video, typeOwner, id, pageVideo));
    if (response.code == 200) {
      canLoadMoreVideo(true);
      if (response.data?.videos?.isNotEmpty ?? false) {
        if (typeOwner == TypeGetPhoto.page) {
          videoPageData.addAll(response.data?.videos ?? []);
        } else if (typeOwner == TypeGetPhoto.group) {
          videoGroupData.addAll(response.data?.videos ?? []);
        } else if (typeOwner == TypeGetPhoto.user) {
          videoHomeData.addAll(response.data?.videos ?? []);
        }
      } else {
        canLoadMoreVideo(false);
      }
    } else {
      pageVideo -= 1;
      canLoadMoreVideo(false);
    }
    isLoadMoreVideo(false);
  }
}