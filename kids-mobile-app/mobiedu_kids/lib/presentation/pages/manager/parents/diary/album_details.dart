import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/album/album_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/album/image_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AlbumChildDetails extends StatelessWidget {
  AlbumChildDetails({super.key, this.album_id, this.child_parent_id});

  final String? album_id;
  final String? child_parent_id;

  final albumController = Get.find<AlbumController>();
  final store = Get.find<LocalStorageService>();
  final imageAlbumController = Get.put(ImageAlbumController());
  final itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    // double bottomPadding = MediaQuery.of(context).padding.bottom;
    return WillPopScope(
      onWillPop: () async {
        await albumController.fetchChild(
          child_parent_id ?? "",
          int.parse(DateFormat('yyyy').format(albumController.indexDateNow.value)));
        Get.back();
        return false;
      },
      child: GetX(
        init: albumController,
        initState: (state) async {
          await albumController.detailChild(
          child_parent_id ?? "", album_id ?? "");
        },
        builder: (state) => GestureDetector(
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
                    onTap: () async {
                      await albumController.fetchChild(
                          child_parent_id ?? "",
                          int.parse(DateFormat('yyyy').format(
                              albumController.indexDateNow.value)));
                      Get.back();
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
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('Lựa chọn tùy chỉnh album'),
                          children: [
                            SimpleDialogOption(
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor:Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: ((builder) => GetBuilder<ImageAlbumController>(
                                    builder: ((_) => imageAlbumController.reloading.value ?
                                    WillPopScope(onWillPop: () async { return false;} , 
                                      child: Container(
                                        decoration: const BoxDecoration(color: Colors.transparent),
                                        child: const Center(child: CircularLoadingIndicator())
                                      )
                                    ) : 
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white
                                      ),
                                      height: 120.0,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                      child: Column(
                                        children: <Widget>[
                                          const SizedBox(height: 20.0),
                                          const Text(
                                            "Chọn ảnh",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20.0
                                          ),
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.center,
                                            children: <Widget>[
                                              TextButton.icon(
                                                icon: Icon(
                                                  Icons.image,
                                                  color: AppColors.pink,
                                                ),
                                                onPressed: () async {
                                                  imageAlbumController.reloading.value = true;
                                                  imageAlbumController.update();
                                                  await imageAlbumController.capturegallery();
                                                  if (imageAlbumController.listfile.isNotEmpty) {
                                                    final lf = <Uint8List>[];
                                                    for (var i = 0; i < imageAlbumController.listfile.length; i++) {
                                                      lf.add(await imageAlbumController.listfile[i].readAsBytes());
                                                    }
                                                    await albumController.addPhotoChild(
                                                      child_parent_id ?? "",
                                                      album_id ??"",
                                                      lf,
                                                      lf.length
                                                    );
                                                  }
                                                  await albumController.detailChild(
                                                    child_parent_id ?? "",
                                                    album_id ?? ""
                                                  );
                                                  imageAlbumController.update();
                                                  imageAlbumController.reloading.value = false;
                                                  imageAlbumController.update();
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                label: Text(
                                                  "gallery".tr,
                                                  style: TextStyle(
                                                    color: AppColors.pink
                                                  ),
                                                ),
                                              ),
                                            ]
                                          )
                                        ],
                                      ),
                                    )
                                  ),
                                )
                              )
                            );
                          },
                          child: const Text('Thêm ảnh'),
                        ),
                        SimpleDialogOption(
                          onPressed: () async {
                            Navigator.pop(context);
                            albumController.caption.text = albumController.detailAlbum.value?.caption ?? "";
                            await _displayTextInputDialog(context);
                          },
                          child: const Text('Sửa tiêu đề'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                            _showAlertDialog(context);
                          },
                          child: const Text('Xóa album'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Icon(Icons.more_horiz_outlined),
              ),
            ),
            middle: Text(albumController.isDetailLoading.value ? "" : '${albumController.detailAlbum.value?.caption}',
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
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                albumController.isDetailLoading.value ? 
                const Center(
                  child: CircularLoadingIndicator()
                ) : 
                albumController.detailAlbum.value?.pictures?.isEmpty ?? true ? 
                const NoData() :
                Expanded(
                  child: GridView.count(
                    childAspectRatio: 3 / 4,
                    physics: const ClampingScrollPhysics(),
                    crossAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: List.generate(albumController.detailAlbum.value?.pictures?.length ??0, (ind) {
                      return GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: (widthScreen - 56.0 - 20) / 2,
                          height: widthScreen,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      SizedBox(
                                        height: (widthScreen - 56.0 - 20) / 2,
                                        width: (widthScreen - 56.0 - 20) / 2,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                          child: Image(
                                            height: (widthScreen - 56.0 - 20) / 2,
                                            width: (widthScreen - 56.0 - 20) / 2,
                                            image: CachedNetworkImageProvider(
                                              "${albumController.detailAlbum.value?.pictures?[ind].source_file}",
                                            ),
                                            fit: BoxFit.cover
                                          ),
                                        )
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await albumController.deletePhotoChild(
                                            child_parent_id ?? "",
                                            albumController.detailAlbum.value?.pictures?[ind].child_journal_id ?? ""
                                          );
                                          await albumController.detailChild(
                                            child_parent_id ?? "",
                                            album_id ?? ""
                                          );
                                        },
                                        child: const Image(
                                          height: 30,
                                          width: 30,
                                          image: AssetImage("assets/images/cancel.png"),
                                          fit: BoxFit.cover
                                        )
                                      )
                                    ]
                                  )
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
    )
  ));
}

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Xóa'),
        content: Text('Bạn có chắc chắn muốn xóa ?',
          style: TextStyle(
            color: AppColors.black
          )
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy', 
              style: TextStyle(
                color: AppColors.primaryBlue
              )
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              await albumController.deleteChild(child_parent_id ?? "", album_id ?? "");
              Navigator.pop(context);
              Navigator.pop(context);
              await albumController.fetchChild(
                child_parent_id ?? "",
                int.parse(DateFormat('yyyy').format(albumController.indexDateNow.value))
              );
            },
            child: Text(
              'Ok',
              style: TextStyle(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Sửa tiêu đề',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.black,
              ),
            ),
          ),
          content: TextField(
            controller: albumController.caption,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.black,
              ),
            ),
            decoration: InputDecoration(
              hintText: "Nhập tiêu đề",
              hintStyle: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await albumController.editCaptionChild(
                  child_parent_id ?? "",
                  album_id ?? "",
                  albumController.caption.text
                );
                await albumController.detailChild(
                  child_parent_id ?? "", 
                  album_id ?? ""
                );
                Navigator.pop(context);
              },
              child: Text(
                "Thay đổi",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              )
            )
          ],
        );
      }
    );
  }
}
