import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/contact_form_input_item.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';

class SchoolContactPage extends StatelessWidget {
  SchoolContactPage({super.key});

  final showPageController = Get.find<ShowPageController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: HexColor('FFFFFF'),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
          child: Column(
            children: [
              const PageTagTop(tagName: 'Liên hệ'),
              SizedBox(height: context.responsive(22.0)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                child: Column(
                  children: [
                    ContactFormInputItem(
                      label: 'Tên phụ huynh',
                      code: 'parentName',
                      inputController: showPageController.parentTextInputController,
                    ),
                    SizedBox(height: context.responsive(12.0)),
                    ContactFormInputItem(
                      label: 'Điện thoại',
                      code: 'phone',
                      inputController: showPageController.phoneTextInputController,
                    ),
                    SizedBox(height: context.responsive(12.0)),
                    ContactFormInputItem(
                      label: 'Thông tin học sinh',
                      code: 'studentInfo',
                      inputController: showPageController.studentInfoTextInputController,
                    ),
                    SizedBox(height: context.responsive(38.0)),
                    SizedBox(
                      width: widthScreen,
                      height: context.responsive(50.0),
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: showPageController.isSendingContact.value ? null : () {
                            handlePressSendContact(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(context.responsive(10.0)))
                            ),
                            elevation: 0.0,
                            backgroundColor: HexColor('FF9ACE'),
                            disabledBackgroundColor: HexColor('D8D8D8'),
                            textStyle: GoogleFonts.raleway(
                              textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('FFFFFF'))
                            )
                          ),
                          child: const Text('Gửi'),
                        )
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> handlePressSendContact(BuildContext context) async {
    if (showPageController.phoneTextInputController.text.isNotEmpty && isValidPhone(showPageController.phoneTextInputController.text)) {
      await showPageController.contactSchool();
    } else {
      showAlertDialog(context, 'Thông báo', 'Vui lòng điền chính xác số điện thoại!');
    }
  }
}