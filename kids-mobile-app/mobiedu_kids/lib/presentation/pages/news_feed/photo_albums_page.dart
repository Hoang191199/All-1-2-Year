import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/album.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/photo_video_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/album_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/grid_view_photo.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/item_image_rect.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class PhotoAlbumsPage extends StatelessWidget {
  PhotoAlbumsPage({
    super.key,
    required this.typeOwner,
    this.id,
    this.name,
  });

  final String typeOwner;
  final String? id;
  final String? name;

  final photoVideoController = Get.find<PhotoVideoController>();
  final scrollControllerPhoto = ScrollController();
  final scrollControllerAlbums = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    final widthScreenSubPadding = widthScreen - context.responsive(56.0);

    return GetX(
      init: photoVideoController,
      initState: (state) async {
        photoVideoController.getAllPhoto(typeOwner, id ?? '', context.responsive(heightScreen - 100.0), widthScreenSubPadding / 3);
        photoVideoController.getAlbums(typeOwner, name ?? '', context.responsive(heightScreen - 100.0), widthScreenSubPadding / 2);
        scrollControllerPhoto.addListener(scrollListener);
        scrollControllerAlbums.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollControllerPhoto.addListener(scrollListener);
        scrollControllerAlbums.addListener(scrollListener);
      },
      dispose: (state) {
        scrollControllerPhoto.removeListener(scrollListener);
        scrollControllerAlbums.removeListener(scrollListener);
      },
      builder: (_) {
        return Scaffold(
          backgroundColor: HexColor('FFFFFF'),
          body: photoVideoController.isLoadingPhoto.value && !photoVideoController.isRefresh.value
            ? const Center(
              child: CircularLoadingIndicator(),
            )
            : Container(
              padding: EdgeInsets.only(
                top: statusBarHeight + context.responsive(10.0), 
                bottom: bottomPadding + context.responsive(20.0)
              ),
              child: Column(
                children: [
                  const PageTagTop(tagName: 'Tất cả ảnh'),
                  SizedBox(height: context.responsive(12.0)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                    child: Container(
                      height: context.responsive(36.0),
                      decoration: BoxDecoration(
                        color: HexColor('FFFDFD'),
                        border: Border.all(color: HexColor('FFDFF1')),
                        borderRadius: BorderRadius.all(Radius.circular(context.responsive(10.0))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          photoTypeItem(context, PhotoType.photo),
                          photoTypeItem(context, PhotoType.album)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.responsive(8.0)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                      child: RefreshIndicator(
                        color: AppColors.pink,
                        onRefresh: () async {
                          if (photoVideoController.photoType.value == PhotoType.photo) {
                            photoVideoController.refreshAllPhoto(typeOwner, id ?? '', context.responsive(heightScreen - 100.0), widthScreenSubPadding / 3);
                          } else if (photoVideoController.photoType.value == PhotoType.album) {
                            photoVideoController.refreshAlbums(typeOwner, name ?? '', context.responsive(heightScreen - 100.0), widthScreenSubPadding / 2);
                          }
                        },
                        child: Container(
                          constraints: const BoxConstraints.expand(),
                          child: photoVideoController.photoType.value == PhotoType.photo
                            ? (typeOwner == TypeGetPhoto.page 
                                ? photoVideoController.photoPageData.isNotEmpty
                                : typeOwner == TypeGetPhoto.group
                                  ? photoVideoController.photoGroupData.isNotEmpty
                                  : photoVideoController.photoHomeData.isNotEmpty)
                                    ? GridViewPhoto(
                                      controller: scrollControllerPhoto,
                                      listPhoto: typeOwner == TypeGetPhoto.page 
                                        ? photoVideoController.photoPageData 
                                        : typeOwner == TypeGetPhoto.group
                                          ? photoVideoController.photoGroupData
                                          : photoVideoController.photoHomeData,
                                      sizeWidth: widthScreenSubPadding / 3,
                                      sizeHeight: widthScreenSubPadding / 3,
                                    )
                                    : const Center(
                                      child: NoData(),
                                    )
                            : viewAlbum(context, widthScreenSubPadding / 2),
                        ), 
                      ),
                    )
                  ), 
                ],
              ),
            ),
        );
      }
    );
  }

  void scrollListener() {
    if (photoVideoController.photoType.value == PhotoType.photo) {
      if (photoVideoController.canLoadMorePhoto.value) {
        if (scrollControllerPhoto.position.pixels == scrollControllerPhoto.position.maxScrollExtent) {
          photoVideoController.loadMoreAllPhoto(typeOwner, id ?? '');
        }
      }
    } else if (photoVideoController.photoType.value == PhotoType.album) {
      if (photoVideoController.canLoadMoreAlbums.value) {
        if (scrollControllerAlbums.position.pixels == scrollControllerAlbums.position.maxScrollExtent) {
          photoVideoController.loadMoreAlbums(typeOwner, name ?? '');
        }
      }
    }
  }

  Widget photoTypeItem(BuildContext context, String photoType) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(context.responsive(3.0)),
        child: InkWell(
          onTap: () {
            photoVideoController.photoType.value = photoType;
          },
          borderRadius: BorderRadius.all(Radius.circular(context.responsive(7.0))),
          child: Container(
            decoration: photoType == photoVideoController.photoType.value
              ? BoxDecoration(
                color: HexColor('FFF4FA'),
                borderRadius: BorderRadius.all(Radius.circular(context.responsive(7.0))),
              )
              : null,
            child: Center(
              child: Text(
                photoType == PhotoType.photo ? 'Ảnh' : 'Albums',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: context.responsive(14.0), 
                    fontWeight: photoType == photoVideoController.photoType.value ? FontWeight.w700 : FontWeight.w500, 
                    color: HexColor('783199')
                  )
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget viewAlbum(BuildContext context, double size) {
    return (typeOwner == TypeGetPhoto.page
      ? photoVideoController.albumsPageData.isNotEmpty
      : typeOwner == TypeGetPhoto.group
        ? photoVideoController.albumsGroupData.isNotEmpty
        : photoVideoController.albumsHomeData.isNotEmpty)
          ? GridView.count(
          controller: scrollControllerAlbums,
          crossAxisCount: context.responsive(2),
          mainAxisSpacing: context.responsive(5.0),
          crossAxisSpacing: context.responsive(5.0),
          padding: const EdgeInsets.all(0.0),
          shrinkWrap: true,
          childAspectRatio: size / (size + context.responsive(5.0 + 3.0 + 3.0 + 5.0 + 18.0 + 17.0)),
          children: List.generate(
            typeOwner == TypeGetPhoto.page 
              ? photoVideoController.albumsPageData.length 
              : typeOwner == TypeGetPhoto.group
                ? photoVideoController.albumsGroupData.length
                : photoVideoController.albumsHomeData.length, 
            (index) {
              final album = typeOwner == TypeGetPhoto.page 
                ? photoVideoController.albumsPageData[index] 
                : typeOwner == TypeGetPhoto.group
                  ? photoVideoController.albumsGroupData[index]
                  : photoVideoController.albumsHomeData[index];
              return InkWell(
                onTap: () {
                  handlePressAlbumsItem(album);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        context.responsive(6.0), 
                        0.0, 
                        context.responsive(6.0), 
                        context.responsive(3.0)
                      ),
                      child: const HorizontalDividerNoPadding(color: 'FF9ACE'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        context.responsive(3.0), 
                        0.0, 
                        context.responsive(3.0), 
                        context.responsive(3.0)
                      ),
                      child: const HorizontalDividerNoPadding(color: 'FF9ACE'),
                    ),
                    ItemImageRect(
                      imageUrl: album.cover ?? '', 
                      width: size,
                      height: size,
                      borderRadius: 0,
                    ),
                    SizedBox(height: context.responsive(5.0)),
                    Text(
                      getAlbumTitle(album.title ?? ''),
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: context.responsive(14.0), 
                          height: context.responsive(1.28), 
                          fontWeight: FontWeight.w700, 
                          color: HexColor('464646')
                        )
                      ),
                    ),
                    Text(
                      '${album.photos_count} ảnh',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: context.responsive(12.0), 
                          height: context.responsive(1.2), 
                          fontWeight: FontWeight.w500, 
                          color: HexColor('6F6F6F')
                        )
                      ),
                    )
                  ],
                ),
              );
            }
          ),
        )
        : const Center(
          child: NoData(),
        );
  }

  void handlePressAlbumsItem(Album album) {
    if (typeOwner == TypeGetPhoto.page) {
      Get.to(
        () => AlbumPage(
          typeOwner: TypeGetPhoto.page,
          username: album.page_name ?? '',
          albumId: album.album_id ?? '',
          albumName: getAlbumTitle(album.title ?? ''),
        ),
        duration: const Duration(milliseconds: 400),
        transition: Transition.rightToLeft
      );
    } else if (typeOwner == TypeGetPhoto.group) {
      Get.to(
        () => AlbumPage(
          typeOwner: TypeGetPhoto.group,
          username: album.group_name ?? '',
          albumId: album.album_id ?? '',
          albumName: getAlbumTitle(album.title ?? ''),
        ),
        duration: const Duration(milliseconds: 400),
        transition: Transition.rightToLeft
      );
    } else if (typeOwner == TypeGetPhoto.user) {
      Get.to(
        () => AlbumPage(
          typeOwner: TypeGetPhoto.user,
          username: album.user_name ?? '',
          albumId: album.album_id ?? '',
          albumName: getAlbumTitle(album.title ?? ''),
        ),
        duration: const Duration(milliseconds: 400),
        transition: Transition.rightToLeft
      );
    }
  }
}