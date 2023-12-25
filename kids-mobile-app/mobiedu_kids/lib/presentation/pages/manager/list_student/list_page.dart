import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/album/album_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/growth/growth_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_binding.dart';
import 'package:mobiedu_kids/presentation/pages/manager/diary/diary_add_album.dart';
import 'package:mobiedu_kids/presentation/pages/manager/health/health_note_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/list_student/add_detail_page.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';
import 'package:mobiedu_kids/presentation/pages/init/init_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/list_student/detail_route_page.dart';

class ListPage extends StatelessWidget {
  ListPage({super.key});

  final childController = Get.find<ChildController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        Get.off(() => InitPage());
        return false;
      },
      child: GetX(
        init: childController,
        initState: (state) async {
          await childController.fetch(store.getGroupname);
        },
        builder: (state) => GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            floatingActionButton: SpeedDial(
              icon: CupertinoIcons.add,
              activeIcon: CupertinoIcons.xmark,
              backgroundColor: AppColors.green,
              overlayColor: AppColors.black,
              overlayOpacity: 0.4,
              children: [
                SpeedDialChild(
                  child: const SizedBox(
                    child: Image(
                      width: 24.0,
                      height: 24.0,
                      image: AssetImage(
                        'assets/images/growth.png',
                      ),
                      fit: BoxFit.cover
                    ),
                  ),
                  label: "Chỉ số sức khỏe",
                  labelStyle: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  onTap: () {
                    Get.delete<ChildController>();
                    ChildBinding().dependencies();
                    GrowthBinding().dependencies();
                    Get.to(() => HealthNotePage());
                  }
                ),
                SpeedDialChild(
                  child: const SizedBox(
                    child: Image(
                      width: 24.0,
                      height: 24.0,
                      image: AssetImage(
                        'assets/images/image_add.png',
                      ),
                      fit: BoxFit.cover
                    ),
                  ),
                  label: "Tạo Album",
                  labelStyle: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  onTap: () {
                    Get.delete<ChildController>();
                    ChildBinding().dependencies();
                    AlbumBinding().dependencies();
                    Get.to(() => DiaryAddAlbum());
                  }
                ),
                SpeedDialChild(
                  child: const SizedBox(
                    child: Image(
                      width: 24.0,
                      height: 24.0,
                      image: AssetImage(
                        'assets/images/register.png',
                      ),
                      fit: BoxFit.cover
                    ),
                  ),
                  label: "Thêm trẻ",
                  labelStyle: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  onTap: () {
                    ChildBinding().dependencies();
                    Get.to(() => AddDetailPage());
                  }
                )
              ],
            ),
            body: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                padding: const EdgeInsetsDirectional.only(top: 12.0),
                leading: Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.off(() => InitPage());
                    },
                    child: Icon(CupertinoIcons.back, color: AppColors.primary),
                  ),
                ),
                middle: Text(
                  'Danh sách học sinh (${childController.listStudent.length})',
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
              child: childController.isLoading.value? 
              const Center(
                child: CircularLoadingIndicator()
              ) : 
              childController.listStudent.isEmpty ? 
              const NoData() : 
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 20),
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        ChildBinding().dependencies();
                        Get.to(() => DetailRoutePage(
                          child_id: childController.listStudent[index]?.child_id,
                          childName: childController.listStudent[index]?.child_name,
                        ));
                      },
                      child: Row(
                        crossAxisAlignment:CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 36.0,
                            height: 36.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: (childController.listStudent[index]?.child_picture !='' &&childController.listStudent[index]?.child_picture !=null) ? 
                              CachedNetworkImage(
                                imageUrl:'${urlImage()}${childController.listStudent[index]?.child_picture}',
                                progressIndicatorBuilder: (context,url, downloadProgress) =>Container(),
                                errorWidget:(context, url, error) =>const AvatarError(),
                                fit: BoxFit.cover
                              )
                              : Image.asset(
                                  'assets/images/avatar-mac-dinh.png',
                                  fit: BoxFit.contain
                              )
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( "${childController.listStudent[index]?.child_name}",
                                style: GoogleFonts.raleway(
                                  textStyle:TextStyle(
                                    color:AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                              (childController.listStudent[index]?.parent_phone != "" && childController.listStudent[index]?.parent_phone != null) ? 
                              Text("${childController.listStudent[index]?.parent_phone}",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color:AppColors.grey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ) : 
                              Text( "Chưa cập nhật",
                                style: GoogleFonts.raleway(
                                  textStyle:TextStyle(
                                    color:AppColors.grey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              )
                            ],
                          ), 
                          const Expanded(
                            child: SizedBox()
                          ),
                          (childController.listStudent[index]?.parent_phone != "" && childController.listStudent[index]?.parent_phone != null) ? 
                          GestureDetector(
                            onTap: () async {
                              final Uri url = Uri(
                                scheme: 'tel',
                                path: '${childController.listStudent[index]?.parent_phone}');
                              if (await UrlLauncher.canLaunchUrl(url)) {
                                await UrlLauncher.launchUrl(url);
                              }
                            },
                            child: Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const ClipOval(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/phone.png',
                                  ),
                                  fit: BoxFit.cover
                                ),
                              ),
                            )
                          ): 
                          const SizedBox(),
                        ],
                      )
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Divider(
                            thickness: 1
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: childController.listStudent.length
                )
              )
            )
          )
        )
      )
    );
  }
}
