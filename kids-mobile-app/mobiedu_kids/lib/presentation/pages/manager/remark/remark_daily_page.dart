import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/remark/image_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/remark/remark_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/speech_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/remark/remark_page.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

import '../../../../app/config/app_common.dart';

class RemarkDailyPage extends StatelessWidget {
  RemarkDailyPage({super.key});

  final remarkController = Get.find<RemarkController>();
  final sttController = Get.put(STTController());
  final store = Get.find<LocalStorageService>();
  final imageRemarkController = Get.put(ImageRemarkController());

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return WillPopScope(
      onWillPop: () async {
        await remarkController.fetchDaily(
          store.getGroupname,
          DateFormat('dd/MM/yyyy').format(remarkController.dateNow.value)
        );
        await remarkController.fetchMonthly(
          store.getGroupname,
          DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - remarkController.indexDateBegin.value)),
          DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day +(6 - remarkController.indexDateBegin.value))));
        return false;
      },
      child: GetX(
          init: remarkController,
          initState: (controller) async {
            remarkController.quickDailyTextController.text = "";
            remarkController.quickDailyTitleTextController.text = "";
            remarkController.quickImageInfoDaily.value?.source_file = "";
            remarkController.quickImageInfoDaily.value?.file_name = "";
            remarkController.imageInfoDaily.value.forEach((key, value) {
              value.file_name = "";
              value.source_file = "";
            });
            await remarkController.fetchTemplate(store.getGroupname, "day");
          },
            builder: (controller) => Scaffold(
              resizeToAvoidBottomInset: false,
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
                          Navigator.pop(context);
                          await remarkController.fetchDaily(
                            store.getGroupname,
                            DateFormat('dd/MM/yyyy').format(remarkController.dateNow.value)
                          );
                          await remarkController.fetchMonthly(
                            store.getGroupname,
                            DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day - remarkController.indexDateBegin.value)),
                            DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day + (6 - remarkController.indexDateBegin.value)))
                          );
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
                            Obx(
                              () => Text(
                                DateFormat('dd/MM/yyyy').format(
                                    remarkController.dateNow.value),
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ]
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    border: const Border(),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10 + bottomPadding),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Text(
                                        "Áp dụng cho: ",
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:const EdgeInsets.only(left: 20),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (remarkController.remainChild.value.isNotEmpty) {
                                              List<SimpleDialogOption>
                                              items = List.generate(remarkController.remainChild.value.length,  (i) =>
                                                SimpleDialogOption(
                                                  onPressed: () {
                                                    remarkController.checkDaily.value[remarkController.remainChild.value[i].child_id ?? ""] = true;
                                                    remarkController.listName();
                                                    remarkController.update();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(remarkController.listDailyChild.map((e) {
                                                      if (e.child_id == remarkController.remainChild.value[i].child_id) {
                                                        return e.child_name;
                                                      } else {
                                                        return "";
                                                      }
                                                    }).toList().join()
                                                  ),
                                                ),
                                              );
                                              showDialog(
                                                context: context,
                                                builder:(context) => SimpleDialog(
                                                  title: const Text('Lựa chọn thêm học sinh'),
                                                  children:items,
                                                ),
                                              );
                                            }
                                          },
                                          child: GetBuilder<RemarkController>(
                                            init:remarkController,
                                            builder: (_) => Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1, 
                                                  color: AppColors.lightGrey
                                                ), 
                                                borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                              child: remarkController.checkDaily.value.containsValue(false) ? 
                                              Text(
                                                remarkController.chooseChild.value.map((e) {
                                                    for (var i = 0; i < remarkController.listDailyChild.length; i++) {
                                                      if (e.child_id == remarkController.listDailyChild[i].child_id) {
                                                        return remarkController.listDailyChild[i].child_name;
                                                      }
                                                    }
                                                  }).toList().toString().replaceAll('[', '').replaceAll(']', ''),
                                                style: GoogleFonts.raleway(
                                                  textStyle: TextStyle(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ) : 
                                              Text(
                                                "Tất cả học sinh",
                                                style: GoogleFonts.raleway(
                                                  textStyle: TextStyle(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              )
                                            ),
                                          ),
                                        )
                                      )
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        "Thông báo ngay",
                                        style: GoogleFonts.raleway(
                                          textStyle:TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      )
                                    ),
                                    CupertinoSwitch(
                                      value: remarkController.isNotifiedDaily.value,
                                      onChanged: (value) {
                                        remarkController.isNotifiedDaily.value = value;
                                      }
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        "Sử dụng mẫu nhận xét",
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      )
                                    ),
                                    CupertinoSwitch(
                                      value: remarkController.templateUse.value,
                                      onChanged: (value) {
                                        remarkController.templateUse.value = value;
                                      }
                                    )
                                  ],
                                ),
                                remarkController.templateUse.value ? 
                                const SizedBox(height: 20) : 
                                const SizedBox(),
                                remarkController.templateUse.value ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: widthScreen - 56,
                                      child: CupertinoButton(
                                        onPressed: () async {
                                          List<SimpleDialogOption> items = List.generate( remarkController.listTemplate.length, (i) =>
                                            SimpleDialogOption(
                                              onPressed: () {
                                                remarkController.quickDailyTitleTextController.text = remarkController.listTemplate[i]?.title ?? "";
                                                remarkController.quickDailyTextController.text = remarkController.listTemplate[i]?.content ?? "";
                                                Navigator.pop(context);
                                              },
                                              child: Text('Mẫu nhận xét ${i + 1}'),
                                            ),
                                          );
                                          showDialog(
                                            context:context,
                                            builder: (context) => SimpleDialog(
                                              title: const Text('Lựa chọn mẫu nhận xét'),
                                              children: items,
                                            ),
                                          );
                                        },
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: AppColors.grey2,
                                        child: Text(
                                          'Chọn mẫu nhận xét',
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
                                  ]
                                ) : 
                                const SizedBox(),
                                const SizedBox(height: 20.0),
                                Row(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Text(
                                        "Tiêu đề: ",
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: CupertinoTextField(
                                          controller:remarkController.quickDailyTitleTextController,
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          placeholder: "Nhập tiêu đề",
                                          placeholderStyle:GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.lightGrey
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                          ),
                                          // autofocus: true,
                                          autocorrect: false,
                                          keyboardType:TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 10,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Text(
                                        "Nội dung: ",
                                        style: GoogleFonts.raleway(
                                          textStyle:TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: CupertinoTextField(
                                          controller: remarkController.quickDailyTextController,
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          placeholder: "Nhập nội dung",
                                          placeholderStyle: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.lightGrey),
                                            borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                          ),
                                          autocorrect: false,
                                          keyboardType:TextInputType.multiline,
                                          minLines: 5,
                                          maxLines: 10,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        sttController.isListening.value = false;
                                        sttController.toggle(remarkController.quickDailyTextController);
                                        await showModalBottomSheet<void>(
                                          showDragHandle: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                          ),
                                          context: context,
                                          builder: (BuildContext context) {
                                            return  Padding(
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
                                                      builder: (controller) =>
                                                        Center(
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
                                                    const SizedBox(height:24.0),
                                                    Container(
                                                      padding: const EdgeInsets.only(left: 28, right: 28,  bottom: 20),
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
                                                                  style: TextStyle(
                                                                    color: Colors.white
                                                                  ),
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
                                        sttController.toggle(remarkController.quickDailyTextController);
                                        sttController.temp.text = "";
                                        sttController.isListening.value = false;
                                      },
                                      child: const SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: ClipOval(
                                          child: Image(
                                            image: AssetImage('assets/images/micro.png'),
                                            fit: BoxFit.cover
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                       GetBuilder< ImageRemarkController>(
                                        init: ImageRemarkController(),
                                        builder: (controller) => (remarkController.quickImageInfoDaily.value?.source_file != "" &&
                                          remarkController.quickImageInfoDaily.value?.source_file != null && 
                                          remarkController.quickImageInfoDaily.value?.source_file != "null"
                                        ) ? 
                                        Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(12.0),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: CachedNetworkImageProvider("${urlImage()}${remarkController.quickImageInfoDaily.value?.source_file}"), 
                                                    fit: BoxFit.cover
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height:10.0)
                                          ]
                                        ) : 
                                        const SizedBox()
                                      ),
                                      CupertinoButton(
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
                                                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    const SizedBox(height: 20.0),
                                                    Text(
                                                      "Chọn ảnh mới",
                                                      style: GoogleFonts.raleway(
                                                        textStyle: TextStyle(
                                                          color: AppColors.black, 
                                                          fontSize: 20.0, 
                                                          fontWeight: FontWeight.w700
                                                        )
                                                      ),
                                                    ),
                                                    const SizedBox( height: 20.0),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center, 
                                                      children: <Widget>[
                                                        TextButton.icon(
                                                          icon: Icon(
                                                            Icons.camera,
                                                            color: AppColors.pink,
                                                          ),
                                                          onPressed: () async {
                                                            await imageRemarkController.quickchangecameraDailyCert(store.getPagename);
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
                                                            await imageRemarkController.quickchangegalleryDailyCert(store.getPagename);
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
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColors.pink,
                                    child: Center(
                                      child: Text(
                                        'Chọn phiếu bé ngoan',
                                        style: GoogleFonts.raleway(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight:FontWeight.w700
                                          ),
                                        ),
                                      )
                                    )
                                  )
                                ]
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ) ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widthScreen - 56,
                        child: CupertinoButton(
                          onPressed: () async {
                            var listNote = <String?>[];
                            for (var i = 0; i < remarkController.chooseChild.value.length; i++) {
                              listNote.add(remarkController.quickDailyTextController.text);
                            }
                            var listNoteTitle = <String?>[];
                            for (var i = 0; i < remarkController.chooseChild.value.length; i++) {
                              listNoteTitle.add(remarkController.quickDailyTitleTextController.text);
                            }
                            var listId = <String?>[];
                            for (var i = 0; i < remarkController.chooseChild.value.length; i++) {
                              listId.add(remarkController.chooseChild.value[i].child_id ?? "");
                            }
                            var listsource = <String?>[];
                            var listfilename = <String?>[];
                            for (var i = 0; i < remarkController.chooseChild.value.length; i++) {
                              listsource.add(remarkController.quickImageInfoDaily.value != null ? remarkController.quickImageInfoDaily.value!.source_file : "" );
                              listfilename.add(remarkController.quickImageInfoDaily.value != null ? remarkController.quickImageInfoDaily.value!.file_name : "" );
                            }
                            await remarkController.reviewDaily(
                              store.getGroupname,
                              DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value),
                              listNote,
                              listNoteTitle,
                              listId,
                              listsource,
                              listfilename,
                              remarkController.chooseChild.value.length,
                              remarkController.isNotifiedDaily.value ? 1 : 0
                            );
                            Navigator.pop(context);
                            await remarkController.fetchDaily(
                              store.getGroupname, 
                              DateFormat('dd/MM/yyyy').format(remarkController.dateNow.value)
                            );
                            await remarkController.fetchMonthly(
                              store.getGroupname,
                              DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day - remarkController.indexDateBegin.value)),
                              DateFormat("dd/MM/yyyy").format(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + (6 - remarkController.indexDateBegin.value)))
                            );
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
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          )
                        )
                      ),
                    ]
                  )
                ]
              )
            )
          )
        )
      )
    )));
  }
}
