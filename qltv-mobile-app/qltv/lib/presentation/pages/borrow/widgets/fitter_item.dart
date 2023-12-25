import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_controller.dart';
import 'package:qltv/presentation/controllers/text_main_controller.dart';

class FitterItemBorrow extends StatelessWidget {

  final scrollController = ScrollController();

  FitterItemBorrow({super.key});

  @override
  Widget build(BuildContext context) {
    final borrowController = Get.find<BorrowController>();
    final text = Get.put(TextMainController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end, 
      children: [
      CupertinoSearchTextField(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        placeholder: 'search-request'.tr,
        placeholderStyle: GoogleFonts.kantumruy(
          textStyle: const TextStyle(
            color: Color(0xFF7B858B),
            fontSize: 14,
            fontWeight: FontWeight.w400
          )
        ),
        autofocus: false,
        autocorrect: true,
        itemSize: 20,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white
        ),
        onSuffixTap: () {
          text.searchpagefield.text = "";
          FocusManager.instance.primaryFocus?.unfocus();
          if (borrowController.option.value != '') {
            borrowController.fetchDataBorrow(text.searchpagefield.text, checkDataOption(borrowController.option.value));
          } else {
            borrowController.fetchDataBorrow(text.searchpagefield.text, null);
          }
        },
        onChanged: (value) {
          if (value == "") {
            text.searchpagefield.text = "";
            if (borrowController.option.value != '') {
              borrowController.fetchDataBorrow(text.searchpagefield.text, checkDataOption(borrowController.option.value));
            } else {
              borrowController.fetchDataBorrow(text.searchpagefield.text, null);
            }
          }
        },
        controller: text.searchpagefield,
        onSubmitted: (String value) {
          if (borrowController.option.value != '') {
            borrowController.fetchDataBorrow(value, checkDataOption(borrowController.option.value));
          } else {
            borrowController.fetchDataBorrow(value, null);
          }
        },
      ),
      CupertinoButton(
        padding: const EdgeInsets.only(left: 10),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: borrowController.option.value == '' ? ('status-request'.tr) : borrowController.option.value,
                  style: GoogleFonts.kantumruy(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333)))),
              const WidgetSpan(
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Color(0xFF333333),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
              title: Text(
                'select-status'.tr,
                style: GoogleFonts.kantumruy(
                    textStyle: const TextStyle(
                        fontSize: 16, 
                        color: Color(0xFF333333)
                    )
                  ),
              ),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Text(
                    'approved'.tr,
                    style: GoogleFonts.kantumruy(
                        textStyle: const TextStyle(
                            fontSize: 16, 
                            color: Color(0xFF52C41A)
                          )
                        ),
                  ),
                  onPressed: () {
                    borrowController.option.value = 'approved'.tr;
                    Navigator.pop(context);
                    if (text.searchpagefield.text == '') {
                      borrowController.fetchDataBorrow('', 1);
                    } else {
                      borrowController.fetchDataBorrow(text.searchpagefield.text, 1);
                    }
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text(
                    'not-approved'.tr,
                    style: GoogleFonts.kantumruy(
                        textStyle: const TextStyle(
                            fontSize: 16, 
                            color: Color(0xFFF1B821)
                          )
                        ),
                  ),
                  onPressed: () {
                      borrowController.option.value = 'not-approved'.tr;
                    Navigator.pop(context);
                    if (text.searchpagefield.text == '') {
                      borrowController.fetchDataBorrow('', 0);
                    } else {
                      borrowController.fetchDataBorrow(text.searchpagefield.text, 0);
                    }
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text(
                    'denied'.tr,
                    style: GoogleFonts.kantumruy(
                        textStyle: const TextStyle(
                            fontSize: 16, 
                            color: Color(0xFFF5222D)
                          )
                        ),
                  ),
                  onPressed: () {
                      borrowController.option.value = 'denied'.tr;
                    Navigator.pop(context);
                    if (text.searchpagefield.text == '') {
                      borrowController.fetchDataBorrow('', -1);
                    } else {
                      borrowController.fetchDataBorrow(text.searchpagefield.text, -1);
                    }
                  },
                ),
                // Add more options here
              ],
              cancelButton: CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  borrowController.option.value = '';
                  Navigator.pop(context);
                  if (text.searchpagefield.text == '') {
                    borrowController.fetchDataBorrow('', null);
                  } else {
                    borrowController.fetchDataBorrow(text.searchpagefield.text, null);
                  }
                },
                child: Text('cancel'.tr,
                  style: GoogleFonts.kantumruy(
                    textStyle: const TextStyle(
                    fontSize: 16, color: Color(0xFF333333)
                    )
                  )
                ),
              ),
            ),
          );
        },
      ),
    ]);
  }
}

int checkDataOption(String? status) {
  switch (status) {
    case 'Bị từ chối':
      return -1;
    case 'Chưa duyệt':
      return 0;
    case 'Đã duyệt':
      return 1;
    default:
      return -2;
  }
}
