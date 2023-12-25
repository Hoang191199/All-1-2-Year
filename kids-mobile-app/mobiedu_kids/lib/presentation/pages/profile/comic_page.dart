import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/media/media_controller.dart';
import 'package:mobiedu_kids/presentation/pages/profile/support_parent_details_page.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class ComicPage extends StatelessWidget {
  ComicPage({super.key});

  final store = Get.find<LocalStorageService>();
  final mediaController = Get.find<MediaController>();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: mediaController,
      initState: (_) async {
        mediaController.listdouble.value = [];
        mediaController.isoutVideoLoading.value = [];
        await mediaController.comic();
        for (var i = 0; i < mediaController.categoriesComic.value!.sub1!.length; i++) {
          mediaController.listdouble.add([]);
          mediaController.isoutVideoLoading.add(false.obs);
        }
      },
      builder: (_) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              padding: const EdgeInsetsDirectional.only(top: 12.0),
              leading: Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColors.primary,
                  ),
                ),
              ),
              middle: Text(
                'Truyện',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              border: const Border(),
            ),
            child: mediaController.iscomicLoading.value ? 
            const Center(
              child: CircularLoadingIndicator()
            ) : 
            mediaController.categoriesComic.value?.sub1?.isEmpty ?? true ? 
            const NoData() : 
            Container(
              padding: const EdgeInsets.only(top: 20.0, left: 28.0, right: 28.0),
              child: DefaultTabController(
                length: mediaController.categoriesComic.value?.sub1?.length ?? 0,
                child: Column(
                  children: [
                  Container(
                    height: 36,
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: const BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: TabBar(
                      isScrollable: true,
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.primary,
                      labelStyle: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12.0,
                        ),
                      ),
                      unselectedLabelStyle: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12.0,
                        ),
                      ),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: AppColors.primary,
                      ),
                      tabs: List<Widget>.generate(mediaController.categoriesComic.value?.sub1?.length ?? 0,(index) => 
                        Tab(
                          child: Text("${mediaController.categoriesComic.value?.sub1?[index].name}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: TabBarView(
                      children: List<Widget>.generate(mediaController.categoriesComic.value?.sub1?.length ??0, (index) =>
                        GetX(
                          init: mediaController,
                          initState: (_) async {
                            await mediaController.video(
                              "${mediaController.categoriesComic.value?.sub1?[index].slug}",
                              "latest",
                              0,
                              index
                            );
                            mediaController.listdouble[index].assignAll(mediaController.listVideo);
                          },
                          builder: (_) => mediaController.isoutVideoLoading[index].value ? 
                            const Center(
                              child: CircularLoadingIndicator()
                            ) : 
                            mediaController.listdouble[index].isNotEmpty ? 
                            GridView.count(
                              childAspectRatio: 1 / 2,
                              physics: const ClampingScrollPhysics(),
                              crossAxisSpacing: 20,
                              crossAxisCount: 3,
                              children: List.generate(mediaController.listdouble[index].length, (ind) {
                                return GestureDetector(
                                  onTap: () async {
                                    Get.to(() => SupportParentDetailsPage(
                                      id: mediaController.listdouble[index][ind]?.id,
                                      index1: index,
                                      index2: ind,
                                    ));
                                  },
                                  child: SizedBox(
                                    width: (widthScreen - 56.0 - 20) / 2,
                                    height: widthScreen,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, 
                                      mainAxisAlignment: MainAxisAlignment.start, 
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                          child: mediaController.listdouble[index][ind]?.thumbnail != null && mediaController.listdouble[index][ind]?.thumbnail != "" ?
                                          Image(
                                            height: (widthScreen - 56.0 - 20) / 2,
                                            width: (widthScreen - 56.0 - 20) / 2,
                                            image: CachedNetworkImageProvider(
                                              "${mediaController.listdouble[index][ind]?.thumbnail}",
                                            ),
                                            fit: BoxFit.cover
                                          ) : 
                                          Image(
                                            height: (widthScreen - 56.0 - 20) / 2, 
                                            width: (widthScreen - 56.0 - 20) / 2, 
                                            image: const AssetImage("assets/images/avatar-mac-dinh.png"), 
                                            fit: BoxFit.cover
                                          ),
                                        ),
                                        const SizedBox(height: 6.0),
                                        Text( '${mediaController.listdouble[index][ind]?.post_title}',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black, 
                                              fontSize: 14.0, 
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                        )
                                      ]
                                    )
                                  )
                                );
                              }
                            ),
                          ) : 
                          const Center(
                            child: Text("Trống"),
                          )
                        )
                      )
                    )
                  )
                ]
              ),
            ),
          )
        )
      )
    ));
  }
}
