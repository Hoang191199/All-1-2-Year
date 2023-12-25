import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/media/media_controller.dart';
import 'package:mobiedu_kids/presentation/pages/profile/support_parent_details_page.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class SupportParentPage extends StatelessWidget {
  SupportParentPage({super.key});

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
        await mediaController.support();
        for (var i = 0; i < mediaController.categoriesSupport.value!.sub1!.length; i++) {
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
                'Trợ lý cha mẹ',
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
            child: mediaController.issupportLoading.value ? 
            const Center(
              child: CircularLoadingIndicator()
            ) :
            mediaController.categoriesSupport.value?.sub1?.isEmpty ?? true ? 
            const NoData() : 
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 28.0, right: 28.0),
              child: DefaultTabController(
                length: mediaController.categoriesSupport.value?.sub1?.length ?? 0,
                child: Column(
                  children: [
                    Container(
                      height: 36.0,
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
                        tabs: List<Widget>.generate(mediaController.categoriesSupport.value?.sub1?.length ?? 0, (index) => 
                          Tab(
                            child: Text(
                              "${mediaController.categoriesSupport.value?.sub1?[index].name}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        )
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: TabBarView(
                        children: List<Widget>.generate(mediaController.categoriesSupport.value?.sub1?.length ?? 0, (index) => 
                          GetX(
                            init: mediaController,
                            initState: (_) async {
                              await mediaController.video(
                                "${mediaController.categoriesSupport.value?.sub1?[index].slug}",
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
                            ListView.separated(
                              itemCount: mediaController.listdouble[index].length,
                              itemBuilder: (context, ind) => GestureDetector(
                                onTap: () {
                                  Get.to(() => SupportParentDetailsPage(
                                    index1: index,
                                    index2: ind,
                                    id: mediaController.listdouble[index][ind]?.id
                                  ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: (widthScreen - 56.0 - 20) / 3,
                                      width: (widthScreen - 56.0 - 20) / 2,
                                      child: ClipRRect(
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
                                      )
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4.0), 
                                              color: AppColors.starYellow,
                                            ),
                                            child: Text(
                                              DateFormat("dd/MM/yyyy").format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(mediaController.listdouble[index][ind]?.post_date ?? "")),
                                              style: GoogleFonts.raleway(
                                                textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500 
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "${mediaController.listdouble[index][ind]?.post_title}",
                                            style: GoogleFonts.raleway(
                                              textStyle: TextStyle(
                                                color: AppColors.black, 
                                                fontSize: 14.0, 
                                                fontWeight: FontWeight.w700
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    )
                                  ],
                                )
                              ),
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            ) : 
                             Center(
                              child: Text("Trống", 
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black, 
                                    fontSize: 14.0, 
                                    fontWeight: FontWeight.w700
                                  ),
                                )
                              ),
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
      )
    );
  }
}
