import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/media/media_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPage extends StatelessWidget {
  VideoPage({super.key});

  final store = Get.find<LocalStorageService>();
  final mediaController = Get.find<MediaController>();
  final List<String> filter = [
    'latest',
    'featured',
    'most_popular',
    'popular_in_7days',
    'review_score',
    'random'
  ];

  final List<Text> filterText = [
    const Text("Gần đây nhất"),
    const Text("Đặc sắc"),
    const Text("Thịnh hành nhất"),
    const Text("Thịnh hành trong 7 ngày"),
    const Text("Điểm"),
    const Text("Ngẫu nhiên"),
  ];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return GestureDetector(
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
              'Videos',
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
          child: Container(
            padding: const EdgeInsets.only(top: 20.0, left: 28.0, right: 28.0),
            child: DefaultTabController(
              length: 3,
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
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.primary,
                      labelStyle: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12.0,
                          // fontWeight: FontWeight.w700
                        ),
                      ),
                      unselectedLabelStyle: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12.0,
                          // fontWeight: FontWeight.w500
                        ),
                      ),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: AppColors.primary,
                      ),
                      tabs: const [
                        Tab(
                          child: Text("Hoạt hình"),
                        ),
                        Tab(
                          child: Text("Ca nhạc"),
                        ),
                        Tab(
                          child: Text("Hài"),
                        ),
                      ]
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: List<Widget>.generate(3, (index) => GetX(
                        init: mediaController,
                        initState: (_) async {
                          if (index == 0) {
                            await mediaController.videomain("hoat-hinh", "latest", 0);
                            mediaController.listCartoon.assignAll(mediaController.listVideo2);
                          } else if (index == 1) {
                            await mediaController.videomain("ca-nhac", "latest", 0);
                            mediaController.listMusic.assignAll(mediaController.listVideo2);
                          } else {
                            await mediaController.videomain("hai", "latest", 0);
                            mediaController.listComedy.assignAll(mediaController.listVideo2);
                          }
                        },
                        builder: (_) => Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: CupertinoButton(
                                pressedOpacity: 0.65,
                                color: AppColors.lightPink,
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      title(index),
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      CupertinoIcons.chevron_down,
                                      color: AppColors.primary,
                                      size: 20.0,
                                    )
                                  ]
                                ),
                                onPressed: () {
                                  _showDialog(context, index);
                                },
                              )
                            ),
                            const SizedBox(height: 20.0),
                            Expanded(
                              child: GridView.count(
                                childAspectRatio: 1,
                                physics: const ClampingScrollPhysics(),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 3,
                                children: List.generate(index == 2 ? mediaController.listComedy.length : 
                                index == 1 ? mediaController.listMusic.length : 
                                mediaController.listCartoon.length, (ind) {
                                  return GestureDetector(
                                    onTap: () async {
                                      final Uri url = index == 2 ? 
                                      Uri.parse(mediaController.listComedy[ind]?.post_name ??"") : 
                                      index == 1 ? Uri.parse(mediaController.listMusic[ind]?.post_name ?? "") : 
                                      Uri.parse(mediaController.listCartoon[ind]?.post_name ?? "");
                                        if (!await launchUrl(url)) {
                                          throw Exception('Could not launch');
                                        }
                                      },
                                      child: SizedBox(
                                        width: (widthScreen - 56.0 - 20) / 3,
                                        height: (widthScreen - 56.0 - 20) / 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                              child: index == 2 ? 
                                              mediaController.listComedy[ind]?.thumbnail != null && mediaController.listComedy[ind]?.thumbnail != "" ? 
                                              Image(
                                                height: (widthScreen - 56.0 - 20) / 3,
                                                width: (widthScreen - 56.0 - 20) / 3,
                                                image: CachedNetworkImageProvider(
                                                  "${mediaController.listComedy[ind]?.thumbnail}",
                                                ),
                                                fit: BoxFit.cover
                                              ) : 
                                              Image(
                                                height: (widthScreen - 56.0 - 20) / 3,
                                                width: (widthScreen - 56.0 - 20) / 3,
                                                image: const AssetImage("assets/images/avatar-mac-dinh.png"),
                                                fit: BoxFit.cover
                                              ) : 
                                              index == 1 ? 
                                              mediaController.listMusic[ind]?.thumbnail != null && mediaController.listMusic[ind]?.thumbnail != "" ? 
                                              Image(
                                                height: (widthScreen - 56.0 - 20) / 3,
                                                width: (widthScreen - 56.0 - 20) / 3,
                                                image: CachedNetworkImageProvider(
                                                  "${mediaController.listMusic[ind]?.thumbnail}",
                                                ),
                                                fit: BoxFit.cover
                                              ) : 
                                              Image(
                                                height: (widthScreen - 56.0 - 20) / 3, 
                                                width: (widthScreen - 56.0 - 20) / 3, 
                                                image: const AssetImage("assets/images/avatar-mac-dinh.png"), 
                                                fit: BoxFit.cover
                                              ) : 
                                              mediaController.listCartoon[ind]?.thumbnail != null && mediaController.listCartoon[ind]?.thumbnail != "" ? 
                                              Image(
                                                height: (widthScreen - 56.0 - 20) / 3,
                                                width: (widthScreen - 56.0 - 20) / 3,
                                                image: CachedNetworkImageProvider(
                                                  "${mediaController.listCartoon[ind]?.thumbnail}",
                                                ),
                                                fit: BoxFit.cover
                                              ) : 
                                              Image(
                                                height: (widthScreen - 56.0 - 20) / 3, 
                                                width: (widthScreen - 56.0 - 20) / 3, 
                                                image: const AssetImage("assets/images/avatar-mac-dinh.png"), 
                                                fit: BoxFit.cover
                                              ),
                                            ),
                                          ]
                                        )
                                      )
                                    );
                                  }
                                ),
                              )
                            )
                          ]
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
    ));
  }

  String title(int index){
    return index == 2 ? 
    (mediaController.indexFilter.value == 0 ? "Gần đây nhất"  : 
      mediaController.indexFilter.value == 1 ? "Đặc sắc" : 
      mediaController.indexFilter.value == 2 ? "Thịnh hành nhất" : 
      mediaController.indexFilter.value == 3 ? "Thịnh hành trong 7 ngày" : 
      mediaController.indexFilter.value == 4 ? "Điểm" : 
      mediaController.indexFilter.value == 5 ? "Ngẫu nhiên" : 
      "Sắp xếp theo"
    ) : 
    index == 1 ? 
    mediaController.indexFilter2.value == 0 ? "Gần đây nhất" : 
    (mediaController.indexFilter2.value == 1 ? "Đặc sắc" : 
      mediaController.indexFilter2.value == 2 ? "Thịnh hành nhất" : 
      mediaController.indexFilter2.value == 3 ? "Thịnh hành trong 7 ngày" : 
      mediaController.indexFilter2.value == 4 ? "Điểm" : 
      mediaController.indexFilter2.value == 5 ? "Ngẫu nhiên" : 
      "Sắp xếp theo"
    ) : 
    mediaController.indexFilter3.value == 0 ? "Gần đây nhất" : 
    mediaController.indexFilter3.value == 1 ? "Đặc sắc" : 
    mediaController.indexFilter3.value == 2 ? "Thịnh hành nhất" : 
    mediaController.indexFilter3.value == 3 ? "Thịnh hành trong 7 ngày" : 
    mediaController.indexFilter3.value == 4 ? "Điểm" : 
    mediaController.indexFilter3.value == 5 ? "Ngẫu nhiên" : 
    "Sắp xếp theo";
  }

  void _showDialog(BuildContext context, int index) {
    double heightScreen = MediaQuery.of(context).size.height;

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: heightScreen / 3,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Hủy',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Chọn',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: mediaController.indexFilter.value,
                  ),
                  onSelectedItemChanged: (int selectedItem) async {
                    if (index == 2) {
                      mediaController.indexFilter.value = selectedItem;
                      await mediaController.videomain(
                        "hai",
                        filter[mediaController.indexFilter.value], 
                        0
                      );
                      mediaController.listComedy.assignAll(mediaController.listVideo2);
                    } else if (index == 1) {
                      mediaController.indexFilter2.value = selectedItem;
                      await mediaController.videomain(
                        "ca-nhac",
                        filter[mediaController.indexFilter2.value], 
                        0
                      );
                      mediaController.listMusic.assignAll(mediaController.listVideo2);
                    } else {
                      mediaController.indexFilter3.value = selectedItem;
                      await mediaController.videomain(
                        "hoat-hinh",
                        filter[mediaController.indexFilter3.value], 
                        0
                      );
                      mediaController.listCartoon.assignAll(mediaController.listVideo2);
                    }
                  },
                  children: filterText
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
