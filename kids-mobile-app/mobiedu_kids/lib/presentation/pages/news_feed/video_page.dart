import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/photo_video_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/video_post.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class VideoPage extends StatelessWidget {
  VideoPage({
    super.key,
    required this.typeOwner,
    required this.id,
  });

  final String typeOwner;
  final String id;

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
        photoVideoController.getAllVideo(typeOwner, id, context.responsive(heightScreen - 100.0), widthScreenSubPadding / 2);
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
          body: photoVideoController.isLoadingVideo.value
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
                  const PageTagTop(tagName: 'Video'),
                  SizedBox(height: context.responsive(12.0)),
                  Expanded(
                    child: (typeOwner == TypeGetPhoto.page
                      ? photoVideoController.videoPageData.isNotEmpty
                      : typeOwner == TypeGetPhoto.group
                        ? photoVideoController.videoGroupData.isNotEmpty
                        : photoVideoController.videoHomeData.isNotEmpty)
                      ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                        child: RefreshIndicator(
                          color: AppColors.pink,
                          onRefresh: () async {
                            photoVideoController.refreshAllVideo(typeOwner, id, context.responsive(heightScreen - 100.0), widthScreenSubPadding / 2);
                          },
                          child: Container(
                            constraints: const BoxConstraints.expand(),
                            child: GridView.count(
                              crossAxisCount: context.responsive(2),
                              mainAxisSpacing: context.responsive(6.0),
                              crossAxisSpacing: context.responsive(6.0),
                              padding: const EdgeInsets.all(0.0),
                              shrinkWrap: true,
                              children: List.generate(
                                typeOwner == TypeGetPhoto.page 
                                  ? photoVideoController.videoPageData.length 
                                  : typeOwner == TypeGetPhoto.group
                                    ? photoVideoController.videoGroupData.length
                                    : photoVideoController.videoHomeData.length, 
                                (index) => Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black
                                  ),
                                  child: VideoPost(
                                    fileType: VideoFileType.network,
                                    filePath: typeOwner == TypeGetPhoto.page
                                      ? photoVideoController.videoPageData[index].source ?? ''
                                      : typeOwner == TypeGetPhoto.group
                                        ? photoVideoController.videoGroupData[index].source ?? ''
                                        : photoVideoController.videoHomeData[index].source ?? '',
                                  ),
                                )
                              ),
                            ),
                          ),
                        ),
                      )
                      : const Center(
                        child: NoData(),
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
    if (photoVideoController.canLoadMoreVideo.value) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        photoVideoController.loadMoreVideo(typeOwner, id);
      }
    }
  }
}