import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/image_metadata.dart';
import 'package:mobiedu_kids/presentation/controllers/album/album_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/album/image_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class DiaryAddAlbumSpecific extends StatelessWidget {
  DiaryAddAlbumSpecific({super.key, this.child_id});

  final String? child_id;

  final childController = Get.find<ChildController>();
  final albumController = Get.find<AlbumController>();
  final imageAlbumController = Get.put(ImageAlbumController());
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return WillPopScope(
      onWillPop: () async {
        await albumController.fetch(
          store.getGroupname,
          child_id ?? "",
          int.parse(DateFormat('yyyy').format(albumController.indexDateNow.value))
        );
        Get.back();
        return false;
      },
      child: GetX(
        init: childController,
        initState: (state) async {
          await childController.fetch(store.getGroupname);
          imageAlbumController.listfile.value = [];
          albumController.caption.text = "";
          albumController.listPhoto.value = [];
        },
        builder: (state) => GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: CupertinoPageScaffold(
                resizeToAvoidBottomInset: false,
                navigationBar: CupertinoNavigationBar(
                  padding: const EdgeInsetsDirectional.only(top: 19.0),
                  leading: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                      onTap: () async {
                        await albumController.fetch(
                          store.getGroupname,
                          child_id ?? "",
                          int.parse(DateFormat('yyyy').format(albumController.indexDateNow.value))
                        );
                        Get.back();
                      },
                      child: const Icon(CupertinoIcons.back),
                    ),
                  ),
                  middle: GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 50.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/calendar_page.png',
                            width: 36,
                            height: 36,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            DateFormat('dd/MM/yyyy').format(childController.dateNow.value),
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  border: const Border(),
                ),
                child: childController.isLoading.value ? 
                  const Center( 
                    child: CircularLoadingIndicator()
                  ) : 
                  childController.listStudent.isEmpty ? 
                  Center(
                    child: Text(
                      "Dữ liệu trống",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ) : 
                  Padding(
                    padding: EdgeInsets.only(
                      left: 28.0,
                      right: 28.0,
                      bottom: bottomPadding + 10
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Tên album : ",
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0
                                ),
                              ),
                            ),
                            Expanded(
                              child: CupertinoTextField(
                              controller:albumController.caption,
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black
                                ),
                              ),
                              placeholder: "Tên",
                              placeholderStyle: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.lightGrey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0
                                ),
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(
                              child: SizedBox()
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor:Colors.transparent,
                                  isScrollControlled: true,
                                  isDismissible: imageAlbumController.loading.value ? false : true,
                                  context: context,
                                  builder: (
                                    (builder) => GetBuilder<ImageAlbumController>
                                    (builder: ((_) => 
                                      imageAlbumController.reloading.value ? 
                                      WillPopScope(onWillPop: () async { return false;}, 
                                        child: Container(
                                          decoration: const BoxDecoration(color: Colors.transparent),
                                          child: const Center(
                                            child: CircularLoadingIndicator()
                                          )
                                        )
                                      ) :
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                                        height: 120.0,
                                        width: MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        child: Column(
                                          children: <Widget>[
                                            const SizedBox(height: 20),
                                            Text(
                                              "Chọn ảnh mới",
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20.0
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height:20),
                                            Row(
                                              mainAxisAlignment:MainAxisAlignment.center,
                                              children: <Widget>[
                                                TextButton.icon(
                                                  icon:Icon(
                                                    Icons.image,
                                                    color: AppColors.pink,
                                                  ),
                                                  onPressed: () async {
                                                    imageAlbumController.reloading.value = true;
                                                    imageAlbumController.update();
                                                    await imageAlbumController.capturegallery();
                                                    if (imageAlbumController.listfile.isNotEmpty) {
                                                      for (var i = 0; i < imageAlbumController.listfile.length; i++) {
                                                        albumController.listPhoto.add(
                                                          ImageMetaData(
                                                            source_file: imageAlbumController.listfile[i].path, 
                                                            file_name: imageAlbumController.listfile[i].name, 
                                                            binary: await imageAlbumController.listfile[i].readAsBytes()
                                                          )
                                                        );
                                                      }
                                                    }
                                                    imageAlbumController.update();
                                                    imageAlbumController.reloading.value = false;
                                                    imageAlbumController.update();
                                                    Navigator.pop(context);
                                                  },
                                                  label: Text(
                                                    "gallery".tr,
                                                    style: TextStyle(color: AppColors.pink),
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
                            child: const ClipRRect(
                              child: Image(
                                height: 20,
                                width: 20,
                                image: AssetImage("assets/images/image_add.png"),
                                fit: BoxFit.cover
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: GridView.count(
                          childAspectRatio: 3 / 4,
                          physics: const ClampingScrollPhysics(),
                          crossAxisSpacing: 20,
                          crossAxisCount: 2,
                          children: List.generate(albumController.listPhoto.length, (ind) {
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
                                            ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                              child: Container(
                                                height: (widthScreen - 56.0 - 20) / 2,
                                                width: (widthScreen - 56.0 - 20) / 2,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(File(albumController.listPhoto[ind]?.source_file ?? "")), 
                                                    fit: BoxFit.cover
                                                  ),
                                                )
                                              )
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                albumController.listPhoto.removeAt(ind);
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
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widthScreen - 56,
                            child: CupertinoButton(
                              onPressed: albumController.submit.value ? null : () async {
                                albumController.submit(true);    
                                final list = <Uint8List>[];
                                list.assignAll(albumController.listPhoto.map((element) => element!.binary!));
                                await albumController.addAlbum(
                                  store.getGroupname, 
                                  child_id ?? "",
                                  albumController.caption.text,
                                  list,
                                  list.length
                                );
                                albumController.caption.text = "";
                                albumController.listPhoto.value = [];
                                albumController.submit(false);    
                              },
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                              borderRadius:BorderRadius.circular(10.0),
                              color: AppColors.pink,
                                child: Text(
                                  'Lưu',
                                  style: GoogleFonts.raleway(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight:FontWeight.w700
                                    ),
                                  ),
                                )
                              )
                            ),
                          ]
                        ),
                      ],
                    )
                  )
                )
              )
            )
          )
        )
      );
  }
}

class ShowDateAlbumAddSpecific extends StatelessWidget {
  ShowDateAlbumAddSpecific({Key? key}) : super(key: key);
  final childController = Get.find<ChildController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).copyWith().size.height / 3,
      child: Container(
        color: Colors.white,
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
                        textStyle: TextStyle(
                          color: AppColors.black,
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
                        textStyle: TextStyle(
                          color: AppColors.black,
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
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime newDateTime) async {
                  childController.dateNow.value = newDateTime;
                },
                initialDateTime: childController.dateNow.value,
                minimumYear: 1990,
                maximumDate: DateTime.now(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
