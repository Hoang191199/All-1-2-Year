import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/checkbox_controller.dart';

class QuickReviewMenuPage extends StatelessWidget {
  QuickReviewMenuPage({
    super.key, 
    this.menu_id, 
    this.date, 
    this.day
  });

  final String? menu_id;
  final String? date;
  final String? day;

  final store = Get.find<LocalStorageService>();
  final checkbox = Get.put(CheckBoxController());

  final List<String> model = [
    "Bé hôm nay đã ăn hết suất cơm của mình! Bố mẹ hãy nhớ khen bé khi bé về nhà nhé!",
    "Bé hôm nay ăn ít và đã bỏ lại nửa bát cơm! Bố mẹ chú ý đừng cho bé ăn vặt quá nhiều nhé! "
  ];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GestureDetector(
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(top: 12.0),
          leading: Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                checkbox.menuReviewController.quickTextController.text = "";
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
          padding: EdgeInsets.only(top: 20, bottom: bottomPadding + 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              children: [
                Expanded( 
                  child: ListView(
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
                              padding: const EdgeInsets.only(left: 20),
                              child: GestureDetector(
                                onTap: () {
                                  if (checkbox.menuReviewController.remainChild.value.isNotEmpty) {
                                    List<SimpleDialogOption> items = List.generate(
                                    checkbox.menuReviewController.remainChild.value.length,
                                      (i) => SimpleDialogOption(
                                        onPressed: () {
                                          checkbox.menuReviewController.check.value[checkbox.menuReviewController.remainChild.value[i].child_id ?? ""] = true;
                                          checkbox.menuReviewController.listName();
                                          checkbox.update();
                                          Navigator.pop(context);
                                        },
                                        child: Text(checkbox.menuReviewController.responsefetchData.map((e) {
                                          if (e.child_id == checkbox.menuReviewController.remainChild.value[i].child_id) {
                                              return e.child_name;
                                            } else {
                                              return "";
                                            }
                                          }).toList().join()),
                                      ),
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                        title: const Text(
                                            'Lựa chọn thêm học sinh'),
                                        children: items,
                                      ),
                                    );
                                  }
                                },
                                child: GetBuilder<CheckBoxController>(
                                  init: checkbox,
                                  builder: (_) => Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: AppColors.lightGrey
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                    child: checkbox.menuReviewController.check.value.containsValue(false) ? 
                                      Text(checkbox.menuReviewController.chooseChild.value.map((e) {
                                        for (var i = 0; i < checkbox.menuReviewController.responsefetchData.length; i++) {
                                            if (e.child_id == checkbox.menuReviewController.responsefetchData[i].child_id) {
                                              return checkbox.menuReviewController.responsefetchData[i].child_name;
                                            }
                                        }
                                      }).toList().toString().replaceAll('[', '').replaceAll(']', ''),
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: AppColors.black,
                                        ),
                                      )) : 
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
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 75,
                            child: Text(
                              "Ghi chú: ",
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
                                controller: checkbox.menuReviewController.quickTextController,
                                placeholder: "Nhập ghi chú cho các bé đã chọn",
                                placeholderStyle: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.black,
                                  ),
                                ),
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.black,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1, 
                                    color: AppColors.lightGrey
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                ),
                                autofocus: true,
                                autocorrect: false,
                                keyboardType: TextInputType.multiline,
                                minLines: 5,
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
                              "Mẫu nhận xét: ",
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
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1, 
                                    color: AppColors.lightGrey
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        checkbox.menuReviewController.quickTextController.text = checkbox.menuReviewController.quickTextController.text + model[0];
                                      },
                                      child: Text(
                                        model[0],
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      )
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        checkbox.menuReviewController.quickTextController.text = checkbox.menuReviewController.quickTextController.text + model[1];
                                      },
                                      child: Text(
                                        model[1],
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      )
                                    ),
                                  ],
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                    ]
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: widthScreen - 56,
                      child: CupertinoButton(
                        onPressed: () async {
                          var listNote = <String>[];
                          for (var i = 0; i < checkbox.menuReviewController.chooseChild.value.length; i++) {
                            listNote.add(checkbox.menuReviewController.quickTextController.text);
                          }
                          var listId = <String>[];
                          for (var i = 0; i < checkbox.menuReviewController.chooseChild.value.length; i++) {
                            listId.add(checkbox.menuReviewController.chooseChild.value[i].child_id ?? "");
                          }
                          await checkbox.menuReviewController.review(
                            store.getGroupname,
                            date ?? "",
                            day ?? "",
                            listNote,
                            menu_id ?? "",
                            listId,
                            checkbox.menuReviewController.chooseChild.value.length
                          );
                          await checkbox.menuController.fetch(store.getGroupname);
                          if (checkbox.menuController.data.isNotEmpty) {
                            await checkbox.menuReviewController.fetch(
                              store.getGroupname,
                              DateFormat("dd/MM/yyyy").format(
                              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + (checkbox.menuController.indexDate.value -checkbox.menuController.indexDateNow.value))),
                              checkbox.menuController.data[0]?.meal_time ?? ""
                            );
                          }
                          checkbox.menuReviewController.quickTextController.text = "";
                          Navigator.pop(context);
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
                      )
                    ),
                  ]
                )
              ]
            ),
          )
        )
      )
    );
  }
}
