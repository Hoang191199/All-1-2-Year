import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/album/album_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/init_page_tab_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/diary/album_details.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/diary/diary_add_album.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DiaryChildPage extends StatelessWidget {
  DiaryChildPage({super.key, this.child_parent_id});

  final String? child_parent_id;
  final albumController = Get.find<AlbumController>();
  final store = Get.find<LocalStorageService>();
  final itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    // double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: albumController,
      initState: (state) async {
        await albumController.fetchChild(
          child_parent_id ?? "",
          int.parse(DateFormat('yyyy').format(albumController.indexDateNow.value))
        );
        itemScrollController.scrollTo(
          index: 99, 
          duration: const Duration(seconds: 1)
        );
        albumController.index.value = 99;
      },
      builder: (state) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 12.0),
            leading: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: () {
                  final initPageTabController = Get.put(InitPageTabController());
                  initPageTabController.changeIndexTab(1);
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.primary,
                ),
              ),
            ),
            trailing: Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => DiaryAddAlbumChild(
                    child_parent_id: child_parent_id ?? "",
                  ));
                },
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.primary,
                ),
              ),
            ),
            middle: Text(
              'Nhật ký',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Text(
                      "Chọn năm",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.center,
                  height: 150,
                  child: Row(
                    children: [
                    Expanded(
                      child: ScrollablePositionedList.separated(
                        itemCount: 100,
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () async {
                            await albumController.fetchChild(
                              child_parent_id ?? "",
                              int.parse(DateFormat('yyyy').format(albumController.indexDateNow.value)) - 99 + index
                            );
                            itemScrollController.scrollTo(
                              index: index,
                              duration: const Duration(seconds: 1)
                            );
                            albumController.index.value = index;
                            albumController.indexDate.value = DateTime(albumController.indexDateNow.value.year - 99 + index);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: (widthScreen - 56.0 - 30) / 4,
                            decoration: BoxDecoration(
                              color: index == albumController.index.value ? AppColors.pink : AppColors.grey2,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('${int.parse(DateFormat('yyyy').format(albumController.indexDateNow.value)) - 99 + index}',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: index == albumController.index.value ? Colors.white : AppColors.black,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                        ),
                        itemScrollController: itemScrollController,
                        separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                      )
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5)
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Chọn năm"),
                            content: SizedBox(
                              height: 300,
                              width: 300,
                              child: YearPicker(
                                currentDate: albumController.indexDate.value,
                                firstDate: DateTime(albumController.indexDateNow.value.year - 100),
                                lastDate: albumController.indexDateNow.value,
                                initialDate: albumController.indexDate.value,
                                onChanged: (DateTime value) async {
                                  albumController.indexDate.value = value;
                                  Navigator.pop(context);
                                  await albumController.fetchChild(
                                    child_parent_id ?? "",
                                    int.parse(DateFormat('yyyy').format(albumController.indexDate.value))
                                  );
                                  itemScrollController.scrollTo(
                                    index: 99 - albumController.indexDateNow.value.year + albumController.indexDate.value.year,
                                    duration: const Duration(
                                      seconds: 1
                                    )
                                  );
                                  albumController.index.value = 99 - albumController.indexDateNow.value.year + albumController.indexDate.value.year;
                                },
                                selectedDate: albumController.indexDate.value,
                              ),
                            ),
                          )
                        );
                      },
                      child: Container(
                        width: (widthScreen - 56.0 - 30) / 4,
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColors.grey2,
                          borderRadius:BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Khác',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      )
                    )
                  ]
                )
              ),
              const SizedBox(height: 20.0),
              albumController.isLoading.value ? 
              const Center(
                child: CircularLoadingIndicator()
              ) : 
              albumController.diverse.isEmpty ? 
              const NoData() : 
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: albumController.diverse.length,
                  itemBuilder: (context, index) => SizedBox(
                    height: ((albumController.diverse[index].length / 2).ceil()) * 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${albumController.diverse[index][0]?.created_at}",
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              fontWeight:FontWeight.w700,
                              color: AppColors.black,
                              fontSize: 16.0
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Expanded(
                          child: GridView.count(
                            childAspectRatio: 3 / 4,
                            physics: const ClampingScrollPhysics(),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            crossAxisCount: 2,
                            children: List.generate(albumController.diverse[index].length, (ind) {
                              return GestureDetector(
                              onTap: () {
                                Get.to(() => AlbumChildDetails(
                                  album_id: albumController.diverse[index][ind]?.child_journal_album_id,
                                  child_parent_id:child_parent_id,
                                ));
                              },
                              child: SizedBox(
                                width: (widthScreen - 56.0 - 20) / 2,
                                height: widthScreen,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:  MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                          child: albumController.diverse[index][ind]?.thumbnail != null && albumController.diverse[index][ind]?.thumbnail != ""  ? 
                                          Image(
                                            height: (widthScreen - 56.0 - 20) / 2,
                                            width: (widthScreen - 56.0 - 20) / 2,
                                            image: CachedNetworkImageProvider(
                                              "${albumController.diverse[index][ind]?.thumbnail}",
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
                                      const SizedBox(height: 8.0),
                                      Text(
                                        '${albumController.diverse[index][ind]?.caption}',
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.grey, 
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.0
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        '${albumController.diverse[index][ind]?.image_count} ảnh',
                                        style:GoogleFonts.raleway(
                                          textStyle:TextStyle(
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0
                                          ),
                                        ),
                                      ),
                                    ]
                                  )
                                )
                              );
                            }
                          ),
                        ),
                      ),
                    ]
                  ),
                )
              )
            )
          ],
        )
      )
    )));
  }
}
