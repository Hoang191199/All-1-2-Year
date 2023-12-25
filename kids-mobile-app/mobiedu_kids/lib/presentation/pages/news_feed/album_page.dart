import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/photo_video_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/grid_view_photo.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class AlbumPage extends StatelessWidget {
  AlbumPage({
    super.key,
    required this.typeOwner,
    required this.username,
    required this.albumId,
    required this.albumName,
  });

  final String typeOwner;
  final String username;
  final String albumId;
  final String albumName;

  final photoVideoController = Get.find<PhotoVideoController>();
  final scrollController = ScrollController();

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
        photoVideoController.getAlbum(typeOwner, username, albumId, heightScreen - context.responsive(100.0), widthScreenSubPadding / 3);
        scrollController.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) {
        return Scaffold(
          backgroundColor: HexColor('FFFFFF'),
          body: photoVideoController.isLoadingAlbum.value && !photoVideoController.isRefresh.value
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
                  PageTagTop(tagName: albumName),
                  SizedBox(height: context.responsive(12.0)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                      child: RefreshIndicator(
                        color: AppColors.pink,
                        onRefresh: () async {
                          photoVideoController.refreshAlbum(typeOwner, username, albumId, heightScreen - context.responsive(100.0), widthScreenSubPadding / 3);
                        },
                        child: Container(
                          constraints: const BoxConstraints.expand(),
                          child: GridViewPhoto(
                            controller: scrollController,
                            listPhoto: typeOwner == TypeGetPhoto.page 
                              ? photoVideoController.albumPageData.value?.photos ?? []
                              : typeOwner == TypeGetPhoto.group
                                ? photoVideoController.albumGroupData.value?.photos ?? []
                                : photoVideoController.albumHomeData.value?.photos ?? [],
                            sizeWidth: widthScreenSubPadding / 3,
                            sizeHeight: widthScreenSubPadding / 3,
                          ),
                        ),
                      )
                    )
                  )
                ],
              ),
            ),
        );
      }
    );
  }

  void scrollListener() {
    if (photoVideoController.canLoadMoreAlbum.value) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        photoVideoController.loadMoreAlbum(typeOwner, username, albumId);
      }
    }
  }
}