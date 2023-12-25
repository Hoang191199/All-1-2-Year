import 'package:avatar_glow/avatar_glow.dart';
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
import 'package:mobiedu_kids/presentation/controllers/remark/checkbox_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/remark/image_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/remark/remark_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/speech_controller.dart';
import 'package:mobiedu_kids/presentation/pages/init/init_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/remark/remark_daily_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/remark/remark_weekly_page.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class RemarkPage extends StatelessWidget {
  RemarkPage({super.key});

  final remarkController = Get.find<RemarkController>();
  final sttController = Get.put(STTController());
  final store = Get.find<LocalStorageService>();
  final imageRemarkController = Get.put(ImageRemarkController());

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    // double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: remarkController,
      initState: (state) async {
        await remarkController.fetchDaily(
          store.getGroupname,
          DateFormat('dd/MM/yyyy').format(remarkController.dateNow.value)
        );
        await remarkController.fetchMonthly(
          store.getGroupname,
          DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day - remarkController.indexDateBegin.value)),
          DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + (6 - remarkController.indexDateBegin.value)))
        );
      },
      builder: (state) => Scaffold(
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
                    Get.off(() => InitPage());
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColors.primary,
                  ),
                ),
              ),
              middle: GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) =>ShowDateDailyNow()
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 50.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/calendar_page.png',
                        width: 36,
                        height: 36,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        DateFormat('dd/MM/yyyy').format(remarkController.dateNow.value),
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
            child: Container(
              margin: const EdgeInsets.only(top: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      height: 36.0,
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffffdff1)
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: TabBar(
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.primary,
                        labelStyle: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        unselectedLabelStyle: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: AppColors.lightPink,
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              'Nhận xét hàng ngày',
                              style: GoogleFonts.raleway(
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Nhận xét hàng tuần',
                              style: GoogleFonts.raleway(
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                           margin: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: ShapeDecoration(
                                    color: AppColors.lightPink,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.symmetric(vertical: 12.0, horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Text("Bạn đang nhận xét ngày ${DateFormat('dd/MM/yyyy').format(remarkController.dateNow.value)}",
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              onPressed: () async {
                                                await remarkController.listName();
                                                if (remarkController.chooseChild.value.isNotEmpty) {
                                                  Get.to(() => RemarkDailyPage());
                                                } else {
                                                  showSnackbar(
                                                    SnackbarType.notice,
                                                    "Chưa lựa chọn",
                                                    "Chưa chọn trẻ hoặc danh sách trống"
                                                  );
                                                }
                                              },
                                              child: Text("Nhận xét nhanh",
                                                style:GoogleFonts.raleway(
                                                  textStyle: TextStyle(
                                                    color: AppColors.primary,
                                                    decoration: TextDecoration.underline,
                                                    fontSize:14.0,
                                                    fontWeight:FontWeight.w700
                                                  ),
                                                ),
                                              )
                                            ),
                                            CupertinoButton(
                                              onPressed: () async {
                                                await remarkController.listName();
                                                if (remarkController.chooseChild.value.isNotEmpty) {
                                                  var listNote = <String?>[];
                                                  for (var i = 0; i < remarkController.chooseChild.value.length; i++) {
                                                    listNote.add(remarkController.textControllersDaily.value[remarkController.chooseChild.value[i].child_id]!.text);
                                                  }
                                                  var listId =<String?>[];
                                                  for (var i = 0; i < remarkController.chooseChild .value.length; i++) {
                                                    listId.add(remarkController.chooseChild.value[i].child_id ?? "");
                                                  }
                                                  var listsource = <String?>[];
                                                  var listfilename = <String?>[];
                                                  for (var i = 0; i < remarkController.chooseChild.value.length; i++) {
                                                    listsource.add(remarkController.imageInfoDaily.value[remarkController.chooseChild.value[i].child_id] != null ? 
                                                      remarkController.imageInfoDaily.value[remarkController.chooseChild.value[i].child_id]! .source_file : 
                                                      remarkController.listDailyChild.firstWhere((e) => e.child_id == remarkController.chooseChild.value[i].child_id).source_file_cert
                                                    );
                                                    listfilename.add(remarkController.imageInfoDaily.value[remarkController.chooseChild.value[i].child_id] !=  null ? 
                                                      remarkController.imageInfoDaily.value[remarkController.chooseChild.value[i].child_id]!.file_name : 
                                                      remarkController.listDailyChild.firstWhere((e) => e.child_id == remarkController.chooseChild.value[i].child_id).file_name_cert
                                                    );
                                                  }
                                                  await remarkController.reviewDaily(
                                                    store.getGroupname,
                                                    DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value),
                                                    listNote,
                                                    listNote,
                                                    listId,
                                                    listsource,
                                                    listfilename,
                                                    remarkController.chooseChild.value.length,
                                                    0
                                                  );
                                                  await remarkController.fetchDaily(
                                                    store.getGroupname,
                                                    DateFormat('dd/MM/yyyy').format(remarkController.dateNow.value)
                                                  );
                                                } else {
                                                  showSnackbar(
                                                    SnackbarType.notice,
                                                    "Chưa lựa chọn",
                                                    "Chưa chọn trẻ hoặc danh sách trống"
                                                  );
                                                }
                                              },
                                                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                                                borderRadius: BorderRadius.circular( 10.0),
                                                color: AppColors.pink,
                                                child: Text(
                                                  'Cập nhật',
                                                  style: GoogleFonts.raleway(
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                )
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                  const SizedBox(height: 14.0),
                                  remarkController.listDailyChild.isNotEmpty ? 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Row(
                                        children: [
                                          GetBuilder<CheckBoxRemarkController>(
                                            init:CheckBoxRemarkController(),
                                            builder: (controller) =>
                                            CupertinoCheckbox(
                                              checkColor: Colors.white,
                                              activeColor: AppColors.green,
                                              value: CheckBoxRemarkController.to.remarkController.checkDaily.value.containsValue(false) ? false : true,
                                              onChanged: (bool? value) {
                                                CheckBoxRemarkController.to.toggleRemarkAll(value);
                                              }
                                            )
                                          ),
                                        Text(
                                          "Chọn tất cả",
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        )
                                      ]
                                    )
                                  ]
                                ) : 
                                const SizedBox(),
                                Expanded(
                                  child: remarkController.isLoading.value ? 
                                  const Center(
                                    child: CircularLoadingIndicator(),
                                  ) : 
                                  remarkController.listDailyChild.isEmpty ? 
                                  const NoData() : 
                                  ListView.separated(
                                    itemCount: remarkController.listDailyChild.length,
                                    itemBuilder: (context, index) => Column(
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
                                                    child: (remarkController.listDailyChild[index].child_picture == '' || remarkController.listDailyChild[index].child_picture == null)
                                                    ? Image.asset('assets/images/avatar-mac-dinh.png', 
                                                      fit: BoxFit.contain
                                                    ) : 
                                                    CachedNetworkImage(
                                                      imageUrl: '${urlImage()}${remarkController.listDailyChild[index].child_picture}',
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                                      errorWidget: (context, url, error) => Image.asset('assets/images/avatar-mac-dinh.png', fit: BoxFit.contain)
                                                    )
                                                  ),
                                                ),
                                                const SizedBox(width: 8.0),
                                                Text(
                                                  '${index + 1} .${remarkController.listDailyChild[index].child_name}',
                                                  style: GoogleFonts.raleway(
                                                    textStyle: TextStyle(
                                                      color: AppColors.black, 
                                                      fontSize: 14.0, 
                                                      fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GetBuilder<CheckBoxRemarkController>(
                                              init:CheckBoxRemarkController(),
                                              builder: (controller) => CupertinoCheckbox(
                                                checkColor: Colors.white,
                                                activeColor: AppColors.green,
                                                value: CheckBoxRemarkController.to.remarkController.checkDaily.value[CheckBoxRemarkController.to.remarkController.listDailyChild[index].child_id],
                                                onChanged: (bool? value) {
                                                  CheckBoxRemarkController.to.toggleRemark(CheckBoxRemarkController.to.remarkController.listDailyChild[index].child_id ?? "", value);
                                                }
                                              )
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                sttController.isListening.value = false;
                                                sttController.toggle(remarkController.textControllersDaily.value[remarkController.listDailyChild[index].child_id] ?? TextEditingController());
                                                await showModalBottomSheet<void>(
                                                  showDragHandle: true,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                                  ),
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                    child: SingleChildScrollView(
                                                      physics: const ClampingScrollPhysics(),
                                                      child: Column(
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                              "Thêm ghi âm",
                                                              overflow: TextOverflow.ellipsis,
                                                              style: GoogleFonts.raleway(
                                                                textStyle: TextStyle(
                                                                  color: AppColors.primary, 
                                                                  fontSize: 22.0, 
                                                                  fontWeight: FontWeight.w700
                                                                )
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 24.0),
                                                          AvatarGlow(
                                                            endRadius: 100.0,
                                                            animate: true,
                                                            glowColor: AppColors.pink,
                                                            duration: const Duration(milliseconds: 2000),
                                                            repeatPauseDuration: const Duration(milliseconds: 100),
                                                            repeat: true,
                                                            child: Stack(
                                                              alignment: AlignmentDirectional.center,
                                                              children: [        
                                                                Image.asset(
                                                                  'assets/images/Ellipse 2.png',
                                                                  width: 150.0,
                                                                  height: 150.0,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/Ellipse 3.png',
                                                                  width: 100.0,
                                                                  height: 100.0,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/microphone.png',
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(height: 24.0),
                                                          GetBuilder<STTController>(
                                                            init: STTController(),
                                                            builder: (controller) => Center(
                                                              child: Text(
                                                                STTController.to.temp.text,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: GoogleFonts.raleway(
                                                                  textStyle: const TextStyle(
                                                                    fontSize: 15.0, 
                                                                    color: Colors.black
                                                                  )
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 24.0),
                                                          Container(
                                                            padding: const EdgeInsets.only(left: 28, right: 28, bottom: 20),
                                                            child: CupertinoButton(
                                                              pressedOpacity: 0.65,
                                                              color: AppColors.pink,
                                                              borderRadius: const BorderRadius.all(
                                                                Radius.circular(10),
                                                              ),
                                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                              alignment: Alignment.centerLeft,
                                                              child: const Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Lưu",
                                                                        style: TextStyle(color: Colors.white),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                            )
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  );
                                                },
                                              );
                                              sttController.toggle((remarkController.textControllersDaily.value[remarkController.listDailyChild[index].child_id] ?? TextEditingController()));
                                              STTController.to.temp.text = "";
                                              STTController.to.update();
                                              sttController.isListening.value = false;
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(bottom: 0),
                                              child: ClipOval(
                                                child: Image(
                                                  image: AssetImage(
                                                    'assets/images/micro.png',
                                                  ),
                                                  fit: BoxFit.cover
                                                ),
                                              ),
                                            )
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 200.0,
                                                    child: CupertinoTextField(
                                                      controller: remarkController.textControllersDaily.value[remarkController.listDailyChild[index].child_id], 
                                                      minLines: 1, 
                                                      maxLines: 5,
                                                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0), 
                                                      placeholder: "Thêm nhận xét", 
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
                                                ],
                                              ),
                                            )
                                          ),
                                          const SizedBox(width:8.0),
                                          Column(
                                            children: [
                                              GetBuilder<ImageRemarkController>(
                                                init: ImageRemarkController(),
                                                builder: (controller) => (remarkController.imageInfoDaily.value[remarkController.listDailyChild[index].child_id]?.source_file != "" && remarkController.imageInfoDaily.value[remarkController.listDailyChild[index].child_id]?.source_file != null 
                                                && remarkController.imageInfoDaily.value[remarkController.listDailyChild[index].child_id]?.source_file != "null") ? 
                                                Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12.0),
                                                      child: Container(
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: CachedNetworkImageProvider("${urlImage()}${remarkController.imageInfoDaily.value[remarkController.listDailyChild[index].child_id]?.source_file}"), 
                                                            fit: BoxFit.cover
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    )
                                                  ]
                                                ): 
                                                (remarkController.listDailyChild[index].source_file_cert != "" && remarkController.listDailyChild[index].source_file_cert != null 
                                                && remarkController.listDailyChild[index].source_file_cert != "null" && (remarkController.imageInfoDaily.value[remarkController.listDailyChild[index].child_id]?.source_file == "" 
                                                || remarkController.imageInfoDaily.value[remarkController.listDailyChild[index].child_id]?.source_file == null 
                                                || remarkController.imageInfoDaily.value[remarkController.listDailyChild[index].child_id]?.source_file == "null")) ? 
                                                Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12.0),
                                                      child: Container(
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: CachedNetworkImageProvider("${urlImage()}${remarkController.listDailyChild[index].source_file_cert}"), 
                                                            fit: BoxFit.cover
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    )
                                                  ]
                                                ) : 
                                                const SizedBox()
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: CupertinoButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      backgroundColor:Colors.transparent,
                                                      isDismissible: false,
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: ((builder) => GetBuilder<ImageRemarkController>(
                                                        builder: ((_) => imageRemarkController.loading.value ? 
                                                        WillPopScope(
                                                          onWillPop: () async { return false;} , 
                                                          child: Container(
                                                            decoration: const BoxDecoration(color: Colors.transparent),
                                                            child: const Center(
                                                              child: CircularLoadingIndicator()
                                                            ),
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
                                                              Text(
                                                                "Chọn ảnh",
                                                                style: GoogleFonts.raleway(
                                                                  textStyle: TextStyle(
                                                                    color: AppColors.black, 
                                                                    fontSize: 20.0, 
                                                                    fontWeight: FontWeight.w700
                                                                  )
                                                                ),
                                                              ),
                                                              const SizedBox(height: 20.0),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                TextButton.icon(
                                                                  icon: Icon(
                                                                    Icons.camera,
                                                                    color: AppColors.pink,
                                                                  ),
                                                                  onPressed: () async {
                                                                    await imageRemarkController.changecameraCert(store.getPagename, remarkController.listDailyChild[index].child_id ?? "");
                                                                    Navigator.pop(context);
                                                                  },
                                                                  label: Text(
                                                                    "camera".tr,
                                                                    style: TextStyle(color: AppColors.pink),
                                                                  ),
                                                                ),
                                                                TextButton.icon(
                                                                  icon: Icon(
                                                                    Icons.image,
                                                                    color: AppColors.pink,
                                                                  ),
                                                                  onPressed: () async {
                                                                    await imageRemarkController.changegalleryCert(store.getPagename, remarkController.listDailyChild[index].child_id ?? "");
                                                                    Navigator.pop(context);
                                                                  },
                                                                  label: Text(
                                                                    "Thư viện ảnh",
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
                                            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: AppColors.pink,
                                            child: Center(
                                              child: Text( 'Chọn phiếu bé ngoan',
                                              style: GoogleFonts.raleway(
                                                textStyle: const TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 14.0, 
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          )
                                        )
                                      )
                                    ]
                                  )
                                ],
                              )
                            ],
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 1.0,
                            );
                          },
                        )
                      )
                    ],
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: ShapeDecoration(
                          color: AppColors.lightPink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 11.0,  horizontal: 16.0),
                          child: Text(
                            "Bạn đang xem nhận xét tuần thứ ${remarkController.dateNow.value.weekOfMonth} của tháng ${remarkController.dateNow.value.month}",
                             style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                           ),
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      Expanded(
                        child: remarkController.isLoading.value ? 
                        const Center(
                          child:CircularLoadingIndicator(),
                        ) : 
                        remarkController.listMonthlyChild.isEmpty ? 
                        const NoData() : 
                        ListView.separated(
                          itemCount: remarkController.listMonthlyChild.length,
                          itemBuilder: (context, index) =>
                            GestureDetector(
                              onTap: () {
                                Get.to(() => RemarkWeeklyPage(
                                    id: remarkController.listMonthlyChild[index].child_id,
                                    index: index,
                                  )
                                );
                              },
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
                                          child: (remarkController.listMonthlyChild[index].child_picture == '' || remarkController.listMonthlyChild[index].child_picture == null) ? 
                                          Image.asset('assets/images/avatar-mac-dinh.png', fit: BoxFit.contain) : 
                                          CachedNetworkImage(
                                            imageUrl: '${urlImage()}${remarkController.listMonthlyChild[index].child_picture}',
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                            errorWidget: (context, url, error) => Image.asset('assets/images/avatar-mac-dinh.png', fit: BoxFit.contain)
                                          )
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      SizedBox(
                                        width: widthScreen - 56 - 44,
                                        child: Text(
                                          '${index + 1} .${remarkController.listMonthlyChild[index].child_name}',
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black, 
                                              fontSize: 14.0, 
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ),
                            separatorBuilder:  (BuildContext context, int index) {
                              return const Divider(
                                thickness: 1.0,
                              );
                            },
                          )
                        )
                      ],
                    )
                  )
                ]
              )
            )
          ]
        ),
      )
    ),
  )
  )));
  }
}

class ShowDateDailyNow extends StatelessWidget {
  ShowDateDailyNow({Key? key}) : super(key: key);
  final remarkController = Get.find<RemarkController>();
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
                  remarkController.dateNow.value = newDateTime;
                  await remarkController.fetchDaily(
                    store.getGroupname, 
                    DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value)
                  );
                  await remarkController.fetchMonthly(
                    store.getGroupname,
                    DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value.subtract(Duration(days: remarkController.dateNow.value.weekday - 1))),
                    DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value.add(Duration(days: DateTime.daysPerWeek - remarkController.dateNow.value.weekday)))
                  );
                },
                initialDateTime: remarkController.dateNow.value,
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

extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var wom = 0;
    var date = this;

    while (date.month == month) {
      wom++;
      date = date.subtract(const Duration(days: 7));
    }

    return wom;
  }
}
