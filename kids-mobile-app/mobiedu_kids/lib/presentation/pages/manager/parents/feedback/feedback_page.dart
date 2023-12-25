import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/presentation/controllers/feedback/feedback_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/init_page_tab_controller.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({super.key});
  final store = Get.find<LocalStorageService>();
  final feedbackController = Get.find<FeedbackController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    // double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: feedbackController,
      initState: (_) {
        feedbackController.isIncognito.value = false;
        feedbackController.content.text = "";
      },
      builder: (_) => GestureDetector(
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
            middle: Text(
              'Đóng góp ý kiến',
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
            padding: EdgeInsets.only(left: 28, right: 28, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          child: Image(
                            height: (widthScreen - 56.0 - 50),
                            width: (widthScreen - 56.0 - 50),
                            image: const AssetImage("assets/images/object.png"),
                            fit: BoxFit.cover
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Center(
                          child: Text(
                            'Trường ${store.getSchoolname} cảm ơn ý kiến đóng góp của bạn !',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                "Chế độ ẩn danh",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              )
                            ),
                            CupertinoSwitch(
                              value: feedbackController.isIncognito.value,
                              onChanged: (value) {
                                feedbackController.isIncognito.value = value;
                              }
                            )
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        CupertinoTextField(
                          controller: feedbackController.content,
                          style: GoogleFonts.raleway(
                            fontSize: 14.0,
                          ),
                          placeholder: "Nội dung góp ý",
                          placeholderStyle: GoogleFonts.raleway(
                            color: AppColors.lightGrey,
                            fontSize: 14.0,
                          ),
                          minLines: 5,
                          maxLines: 10,
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: widthScreen - 56,
                          child: CupertinoButton(
                            onPressed: () async {
                              await feedbackController.create(
                                feedbackController.isIncognito.value ? "on" : "off",
                                store.getChild?.child_id ?? "",
                                feedbackController.content.text
                              );
                              feedbackController.content.text = "";
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
                  )
                ]
              )
            ),
          )
        )
      )
    );
  }
}
