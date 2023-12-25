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
import 'package:mobiedu_kids/presentation/pages/manager/menu/widget/empty_menu.dart';
import 'package:mobiedu_kids/presentation/pages/manager/schedule/quick_schedule_review.dart';
import 'package:mobiedu_kids/presentation/pages/manager/schedule/schedule_history_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/schedule/widget/list_schedule.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({super.key});

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
        init: checkbox,
        initState: (state) async {
          await checkbox.scheduleController.fetch(store.getGroupname);
          await checkbox.scheduleReviewController.fetch(store.getGroupname,
          DateFormat('dd/MM/yyyy').format(DateTime.now()));
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
                  'Lịch học',
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
                      Get.to(() => ScheduleHistoryPage());
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
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text( items[checkbox.scheduleController.indexDate.value],
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
                                checkbox.scheduleController.isLoading.value ? 
                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 2,
                                  child: const Center(
                                    child: CircularLoadingIndicator()
                                  ),
                                ) :
                                Container(
                                  padding: const EdgeInsets.only(top: 10, left: 28,right: 28),
                                    child: checkbox.scheduleController.indexDate.value == 0 ? 
                                    checkbox.scheduleController.data.isEmpty ? 
                                    const EmptyData(type: 'schedule') : 
                                    ListSchedule(day: 'monday') : 
                                    checkbox.scheduleController.indexDate.value == 1 ? 
                                    checkbox.scheduleController.data.isEmpty ? 
                                    const EmptyData(type: 'schedule') : 
                                    ListSchedule(day: 'tuesday') : 
                                    checkbox.scheduleController.indexDate.value == 2 ? 
                                    checkbox.scheduleController.data.isEmpty ? 
                                    const EmptyData(type: 'schedule') :
                                    ListSchedule(day: 'wednesday') :
                                    checkbox.scheduleController.indexDate.value == 3 ? 
                                    checkbox.scheduleController.data.isEmpty ? 
                                    const EmptyData(type: 'schedule') :
                                    ListSchedule(day: 'thursday') :
                                    checkbox.scheduleController.indexDate.value == 4 ? 
                                    checkbox.scheduleController.data.isEmpty ? 
                                    const EmptyData(type: 'schedule') :
                                    ListSchedule(day: 'friday') :
                                    checkbox.scheduleController.data.isEmpty ? 
                                    const EmptyData(type: 'schedule') : 
                                    checkbox.scheduleController.is_saturday.value == "0" ? 
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
                                    )
                                  : ListSchedule(day: 'saturday')
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                  child: Obx(() => checkbox.scheduleController.isLoading.value ? 
                                    const SizedBox() : 
                                    checkbox.scheduleReviewController.isLoading.value ? 
                                    const Center(
                                      child: CircularLoadingIndicator(),
                                    ) : 
                                    checkbox.scheduleReviewController.responsefetchData.isEmpty ? 
                                    const Padding(
                                      padding: EdgeInsets.only(top: 30.0),
                                      child: NoData()
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
                                                    value: CheckBoxController.to.scheduleReviewController.check.value.containsValue(false) ? false : true,
                                                    onChanged: (bool? value) {
                                                      CheckBoxController.to.toggleScheduleAll(value);
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
                                            children: List<Widget>.generate(checkbox.scheduleReviewController.responsefetchData.length, (index) {
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
                                                              child: (checkbox.scheduleReviewController.responsefetchData[index].child_picture == '' || checkbox.scheduleReviewController.responsefetchData[index].child_picture == null) ? 
                                                              Image.asset('assets/images/avatar-mac-dinh.png', 
                                                                fit: BoxFit.contain
                                                              ) : 
                                                              CachedNetworkImage(
                                                                imageUrl: '${urlImage()}${checkbox.scheduleReviewController.responsefetchData[index].child_picture}',
                                                                progressIndicatorBuilder: (context,url, downloadProgress) =>Container(),
                                                                errorWidget:(context, url, error) =>const AvatarError(),
                                                                fit: BoxFit.cover
                                                              )
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8.0),
                                                          Text(
                                                            '${index + 1} .${checkbox.scheduleReviewController.responsefetchData[index].child_name}',
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
                                                          value: CheckBoxController.to.scheduleReviewController.check.value[CheckBoxController.to.scheduleReviewController.responsefetchData[index].child_id],
                                                          onChanged: (bool? value) {
                                                            CheckBoxController.to.toggleSchedule(CheckBoxController.to.scheduleReviewController.responsefetchData[index].child_id, value);
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
                                                                child: Row(children: []),
                                                              ),
                                                              SizedBox(
                                                                width: 300,
                                                                child: GestureDetector(
                                                                  onTap: () async {},
                                                                  child: SizedBox(
                                                                    width: 200.0,
                                                                    child: CupertinoTextField(
                                                                      controller: checkbox.scheduleReviewController.textControllers.value[checkbox.scheduleReviewController.responsefetchData[index].child_id],
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
                                                                        border: Border.all(color: AppColors.lightGrey),
                                                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                                                      )
                                                                    ),
                                                                  )
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
                                      const SizedBox(height: 10.0),
                                    ]
                                  )
                                )
                              )
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
                              await checkbox.scheduleReviewController.listName();
                              if (checkbox.scheduleReviewController.chooseChild.value.isNotEmpty) {
                                Get.to(() =>
                                  QuickReviewSchedulePage(
                                    schedule_id: checkbox.scheduleController.id.value,
                                    date: DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day + 
                                    (checkbox.scheduleController.indexDate.value - checkbox.scheduleController.indexDateNow.value))),
                                  )
                                );
                              } else {
                                showSnackbar(
                                    SnackbarType.notice,
                                    "Chưa lựa chọn",
                                    "Chưa chọn trẻ hoặc danh sách trống");
                              }
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
                              await checkbox.scheduleReviewController.listName();
                              if (checkbox.scheduleReviewController.chooseChild.value.isNotEmpty) {
                                var listNote = <String>[];
                                for (var i = 0; i < checkbox.scheduleReviewController.chooseChild.value.length; i++) {
                                  listNote.add(checkbox.scheduleReviewController.textControllers.value[checkbox.scheduleReviewController.chooseChild.value[i].child_id]!.text);
                                }
                                var listId = <String>[];
                                for (var i = 0; i < checkbox.scheduleReviewController.chooseChild.value.length; i++) {
                                  listId.add(checkbox.scheduleReviewController.chooseChild.value[i].child_id ?? "");
                                }
                                await checkbox.scheduleReviewController.review(
                                  store.getGroupname,
                                  DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day +
                                  (checkbox.scheduleController.indexDate.value - checkbox.scheduleController.indexDateNow.value))),
                                  listNote,
                                  checkbox.scheduleController.id.value ??"",
                                  listId,
                                  checkbox.scheduleReviewController.chooseChild.value.length
                                );
                                await checkbox.scheduleController.fetch(store.getGroupname);
                                await checkbox.scheduleReviewController.fetch(
                                  store.getGroupname,
                                  DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day +
                                  (checkbox.scheduleController.indexDate.value - checkbox.scheduleController.indexDateNow.value))),
                                );
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
                    const SizedBox( height: 10.0),
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
                    initialItem: checkbox.scheduleController.indexDate.value,
                  ),
                  onSelectedItemChanged: (int selectedItem) async {
                    checkbox.scheduleController.indexDate.value = selectedItem;
                    await checkbox.scheduleReviewController.fetch(
                      store.getGroupname,
                      DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day +
                      (checkbox.scheduleController.indexDate.value - checkbox.scheduleController.indexDateNow.value))));
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
