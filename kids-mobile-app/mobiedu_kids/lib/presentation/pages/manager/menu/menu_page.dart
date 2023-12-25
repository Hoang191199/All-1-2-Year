import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/checkbox_controller.dart';
import 'package:mobiedu_kids/presentation/pages/init/init_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/menu/menu_history_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/menu/quick_menu_review.dart';
import 'package:mobiedu_kids/presentation/pages/manager/menu/widget/empty_menu.dart';
import 'package:mobiedu_kids/presentation/pages/manager/menu/widget/list_menu.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

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
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return WillPopScope(
      onWillPop: () async {
        Get.off(() => InitPage());
        return false;
      },
      child: GetX(
        init: checkbox.menuController,
        initState: (state) async {
          await checkbox.menuController.fetch(store.getGroupname);
          if (checkbox.menuController.data.isNotEmpty) {
            await checkbox.menuReviewController.fetch(
              store.getGroupname,
              DateFormat('dd/MM/yyyy').format(DateTime.now()),
              checkbox.menuController.data[0]?.meal_time ?? ""
            );
          }
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
                      Get.off(() => InitPage());
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
                trailing: Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => MenuHistoryPage());
                    },
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.primary,
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
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    alignment: Alignment.centerLeft,
                                    child: Row( 
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              items[checkbox.menuController.indexDate.value],
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
                                checkbox.menuController.isLoading.value ? 
                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 2,
                                  child: const Center(
                                    child: CircularLoadingIndicator()
                                  ),
                                ) :
                                Column(
                                  children: [
                                    Container( 
                                      padding: const EdgeInsets.only(top: 10, left: 28, right: 28),
                                      child: checkbox .menuController.indexDate.value == 0 ? 
                                      checkbox.menuController.data.isEmpty ? 
                                      const EmptyData(type: 'menu') : 
                                      ListMenu(day: 'monday') : 
                                      checkbox.menuController.indexDate.value == 1 ? 
                                      checkbox.menuController.data.isEmpty ? 
                                      const EmptyData(type: 'menu') : 
                                      ListMenu(day: 'tuesday') : 
                                      checkbox.menuController.indexDate.value == 2 ? 
                                      checkbox.menuController.data.isEmpty ? 
                                      const EmptyData(type: 'menu') : 
                                      ListMenu(day: 'wednesday') :
                                      checkbox.menuController.indexDate.value == 3 ? 
                                      checkbox.menuController.data.isEmpty ? 
                                      const EmptyData(type: 'menu') : 
                                      ListMenu(day: 'thursday') :
                                      checkbox.menuController.indexDate.value == 4 ? 
                                      checkbox.menuController.data.isEmpty ? 
                                      const EmptyData(type: 'menu') :
                                      ListMenu(day: 'friday') :
                                      checkbox.menuController.data.isEmpty ? 
                                      const EmptyData(type: 'menu') :
                                      checkbox.menuController.is_saturday.value == "0" ? 
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
                                      ListMenu(day: 'saturday')                        
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                        child: Obx(
                                          () => checkbox.menuController.isLoading.value ? 
                                          const SizedBox() : 
                                          checkbox.menuReviewController.isLoading.value? 
                                          const Center(
                                            child: CircularLoadingIndicator(),
                                          ) : 
                                          checkbox.menuReviewController.responsefetchData.isEmpty ? 
                                          const Padding(
                                            padding: EdgeInsets.only(top: 30.0),
                                            child: NoData(),
                                          ) : 
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const SizedBox(),
                                                  Row(
                                                    children: [
                                                      GetBuilder<CheckBoxController>(
                                                        init: CheckBoxController(),
                                                        builder: (controller) => CupertinoCheckbox(
                                                          checkColor: Colors.white,
                                                          activeColor: AppColors.green,
                                                          value: CheckBoxController.to.menuReviewController.check.value.containsValue(false) ? false : true,
                                                          onChanged: (bool? value) {
                                                            CheckBoxController.to.toggleMenuAll(value);
                                                          }
                                                        )
                                                      ),
                                                      Text(
                                                        "Chọn tất cả",
                                                        style: GoogleFonts.raleway(
                                                          textStyle: TextStyle(color: AppColors.black, fontSize: 14.0, fontWeight: FontWeight.w700),
                                                        ),
                                                      )
                                                    ]
                                                  )
                                                ]
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                child: Column(
                                                  children: List<Widget>.generate(checkbox.menuReviewController.responsefetchData.length, (index) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 36.0,
                                                                height: 36.0,
                                                                decoration: const BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                ),
                                                                child: ClipOval(
                                                                  child: (checkbox.menuReviewController.responsefetchData[index].child_picture == '' || checkbox.menuReviewController.responsefetchData[index].child_picture == null)
                                                                ? Image.asset('assets/images/avatar-mac-dinh.png', fit: BoxFit.contain)
                                                                : CachedNetworkImage(
                                                                    imageUrl: '${urlImage()}${checkbox.menuReviewController.responsefetchData[index].child_picture}',
                                                                    progressIndicatorBuilder: (context,url, downloadProgress) => Container(),
                                                                    errorWidget:(context, url, error) =>const AvatarError(),
                                                                    fit: BoxFit.cover
                                                                  )
                                                                ),
                                                              ),
                                                              const SizedBox(width: 8.0),
                                                              Text(
                                                                '${index + 1} .${checkbox.menuReviewController.responsefetchData[index].child_name}',
                                                                style: GoogleFonts.raleway(
                                                                  textStyle: TextStyle(color: AppColors.black, fontSize: 14.0, fontWeight: FontWeight.w700),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          GetBuilder<CheckBoxController>(
                                                            init: CheckBoxController(),
                                                            builder: (controller) => CupertinoCheckbox(
                                                              checkColor: Colors.white,
                                                              activeColor: AppColors.green,
                                                              value: CheckBoxController.to.menuReviewController.check.value[CheckBoxController.to.menuReviewController.responsefetchData[index].child_id],
                                                              onChanged: (bool? value) {
                                                                CheckBoxController.to.toggleMenu(CheckBoxController.to.menuReviewController.responsefetchData[index].child_id, value);
                                                              }
                                                            )
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              margin: const EdgeInsets.only(left: 36.0),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(bottom: 8.0),
                                                                    child: Row(
                                                                      children: []
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 300.0,
                                                                    child: SizedBox(
                                                                      width: 200.0,
                                                                      child: CupertinoTextField(
                                                                        controller: checkbox.menuReviewController.textControllers.value[checkbox.menuReviewController.responsefetchData[index].child_id],
                                                                        style: GoogleFonts.raleway(
                                                                          textStyle: TextStyle(
                                                                            fontSize: 14.0,
                                                                            color: AppColors.black,
                                                                          ),
                                                                        ),
                                                                        minLines: 1,
                                                                        maxLines: 5,
                                                                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                                                        placeholder: "Thêm ghi chú",
                                                                        placeholderStyle: GoogleFonts.raleway(
                                                                          textStyle: TextStyle(
                                                                            fontSize: 14.0, 
                                                                            fontWeight: FontWeight.w500, 
                                                                            color: AppColors.grey
                                                                          )
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            color: AppColors.lightGrey
                                                                          ), 
                                                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                                                        )
                                                                      ),
                                                                    )
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ),
                                                        ],
                                                        )
                                                      ]
                                                    );
                                                  }
                                                )
                                              )
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ]
                                        )
                                      )
                                    )
                                    
                                  ],
                                ),
                              ]
                            )
                          )
                        )
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: (widthScreen - 56) / 2 - 10,
                            child: CupertinoButton(
                              onPressed: () async {
                                await checkbox.menuReviewController.listName();
                                if (checkbox.menuReviewController.chooseChild.value.isNotEmpty) {
                                  Get.to(() => QuickReviewMenuPage(
                                    menu_id: checkbox.menuController.id.value,
                                    date: DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year, DateTime.now().month,
                                    DateTime.now().day + (checkbox.menuController.indexDate.value - checkbox.menuController.indexDateNow.value)))
                                  ));
                                } else {
                                  showSnackbar(
                                    SnackbarType.notice,
                                    "Chưa lựa chọn",
                                    "Chưa chọn trẻ hoặc danh sách trống"
                                  );
                                }
                              },
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColors.grey2,
                              child: Text(
                                'Nhận xét nhanh',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              )
                            )
                          ),
                          SizedBox(
                            width: (widthScreen - 56) / 2 - 10,
                            child: CupertinoButton(
                              onPressed: () async {
                                await checkbox.menuReviewController.listName();
                                if (checkbox.menuReviewController.chooseChild.value.isNotEmpty) {
                                  var listNote = <String>[];
                                  for (var i = 0; i < checkbox.menuReviewController.chooseChild.value.length; i++) {
                                    listNote.add(checkbox.menuReviewController.textControllers.value[checkbox.menuReviewController.chooseChild.value[i].child_id]!.text);
                                  }
                                  var listId = <String>[];
                                  for (var i = 0; i < checkbox.menuReviewController.chooseChild.value.length; i++) {
                                    listId.add(checkbox.menuReviewController.chooseChild.value[i].child_id ?? "");
                                  }
                                  await checkbox.menuReviewController.review(
                                    store.getGroupname,
                                    DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day + (checkbox.menuController.indexDate.value - checkbox.menuController.indexDateNow.value))),
                                    DateFormat("EEEE").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + (checkbox.menuController.indexDate.value - checkbox.menuController.indexDateNow.value))),
                                    listNote,
                                    checkbox.menuController.id.value ?? "",
                                    listId,
                                    checkbox.menuReviewController.chooseChild.value.length
                                  );
                                  await checkbox.menuController.fetch(store.getGroupname);
                                    if (checkbox.menuController.data.isNotEmpty) {
                                    await checkbox.menuReviewController.fetch(
                                      store.getGroupname,
                                      DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day + (checkbox.menuController.indexDate.value - checkbox.menuController.indexDateNow.value))),
                                      checkbox.menuController.data[0]?.meal_time ?? "");
                                    }
                                    checkbox.update();
                                  } else {
                                    showSnackbar(
                                      SnackbarType.notice,
                                      "Chưa lựa chọn",
                                      "Chưa chọn trẻ hoặc danh sách trống"
                                    );
                                  }
                                },
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.pink,
                                child: Text(
                                  'Lưu',
                                  style: GoogleFonts.raleway(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                )
                              ),
                            )
                          ]
                        ),
                        const SizedBox(height: 10.0),
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
                    initialItem: checkbox.menuController.indexDate.value,
                  ),
                  onSelectedItemChanged: (int selectedItem) async {
                    checkbox.menuController.indexDate.value = selectedItem;
                    await checkbox.menuReviewController.fetch(
                      store.getGroupname,
                      DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + (checkbox.menuController.indexDate.value - checkbox.menuController.indexDateNow.value))), 
                      checkbox.menuController.data[0]?.meal_time ?? ""
                    );
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


