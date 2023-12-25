// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/checkbox_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/menu/widget/empty_menu.dart';
import 'package:mobiedu_kids/presentation/pages/manager/menu/widget/list_menu.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class MenuDetailsPage extends StatelessWidget {
  
  MenuDetailsPage({super.key, this.menu_id});
  final String? menu_id;
  final store = Get.find<LocalStorageService>();
  final checkbox = Get.put(CheckBoxController());
  final items = [
    'Thứ 2',
    'Thứ 3',
    'Thứ 4',
    'Thứ 5',
    'Thứ 6',
    'Thứ 7',
  ];

  @override
  Widget build(BuildContext context) {
    // double widthScreen = MediaQuery.of(context).size.width;
    // double heightScreen = MediaQuery.of(context).size.height;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: GetX(
        init: checkbox.menuController,
        initState: (state) async {
          await checkbox.menuController.detail(store.getGroupname,menu_id ?? "");
          checkbox.menuController.indexDateDetail.value = 0;
        },
        builder: (state) {
          return GestureDetector(
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
                      Navigator.pop(context);
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                middle: Text(
                  'Thực đơn',
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
                padding: EdgeInsets.only(bottom: bottomPadding + 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 10, left: 28, right: 28),
                                    child: CupertinoButton(
                                      pressedOpacity: 0.65,
                                      color: AppColors.lightPink,
                                      borderRadius:const BorderRadius.all(Radius.circular(50)),
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(items[checkbox.menuController.indexDateDetail.value],
                                                style: GoogleFonts.raleway(
                                                  textStyle: TextStyle(
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),
                                            ]
                                          )
                                        ]
                                      ),
                                      onPressed: () {
                                        _showDialog(context);
                                      },
                                    )
                                  ),
                                 checkbox.menuController.isdetailLoading.value ? 
                                 const Center(
                                    child: CircularLoadingIndicator()
                                  ) : 
                                  Container(
                                    padding: const EdgeInsets.only( top: 10, left: 28, right: 28),
                                    child: checkbox.menuController.indexDateDetail.value == 0 ? 
                                    checkbox.menuController.detailMenu.value?.details?.isEmpty ?? true ? 
                                    const EmptyData(type: 'menu') : 
                                    ListMenu(day: 'monday', details: true) : 
                                    checkbox.menuController.indexDateDetail.value == 1 ? 
                                    checkbox.menuController.detailMenu.value?.details?.isEmpty ?? true ? 
                                    const EmptyData(type: 'menu') : 
                                    ListMenu(day: 'tuesday', details: true) :
                                    checkbox.menuController.indexDateDetail.value == 2 ? 
                                    checkbox.menuController.detailMenu.value?.details?.isEmpty ?? true ? 
                                    const EmptyData(type: 'menu') : 
                                    ListMenu(day: 'wednesday', details: true) :
                                    checkbox.menuController.indexDateDetail.value == 3 ? 
                                    checkbox.menuController.detailMenu.value?.details?.isEmpty ?? true ? 
                                    const EmptyData(type: 'menu') :
                                    ListMenu(day: 'thursday', details: true) :
                                    checkbox.menuController.indexDateDetail.value == 4 ? 
                                    checkbox.menuController.detailMenu.value?.details?.isEmpty ?? true ? 
                                    const EmptyData(type: 'menu') : 
                                    ListMenu(day: 'friday', details: true) :
                                    checkbox.menuController.detailMenu.value?.details?.isEmpty ?? true ? 
                                    const EmptyData(type: 'menu') : 
                                    checkbox.menuController.is_saturday_detail.value == "0" ? 
                                    SizedBox(
                                      height: 150,
                                      child: Center(
                                        child: Text(
                                          "Nghỉ thứ bảy",
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.primary, 
                                              fontWeight: FontWeight.w700
                                            )
                                          ),
                                        )
                                      ),
                                    ) : 
                                    ListMenu(day: 'saturday', details: true)
                                  ),
                                ]
                              )
                            )
                          )
                        ),
                      ]
                    )
                  )
                )
              );
            }
          )
        );
  }



  void _showDialog(BuildContext context) {
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
                    initialItem: checkbox.menuController.indexDateDetail.value,
                  ),
                  onSelectedItemChanged: (int selectedItem) async {
                    checkbox.menuController.indexDateDetail.value = selectedItem;
                  },
                  children: List<Widget>.generate(items.length, (int index) {
                    return Center(child: Text(items[index]));
                  }),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
