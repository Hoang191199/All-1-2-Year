import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;

// ignore: must_be_immutable
class DiaLog extends StatelessWidget {
  DiaLog(
      {super.key,
      required this.remain,
      this.widthScreen,
      this.heightScreen,
      this.idItem,
      this.type});

  final double? widthScreen;
  final double? heightScreen;
  int remain;
  int? idItem;
  String? type;

  final searchController = Get.find<search.SearchController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('confirm-registration'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.kantumruy(
            textStyle: TextStyle(
                color: HexColor('333333'),
                fontSize: 14,
                fontWeight: FontWeight.w700),
          )),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Container(
        padding: const EdgeInsets.only(top: 10.0),
        width: widthScreen,
        height: heightScreen! / 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: HexColor('D9E9F2')),
                borderRadius: BorderRadius.circular(8),
              ),
              child: (Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('quantity'.tr,
                      style: GoogleFonts.kantumruy(
                        textStyle: TextStyle(
                            color: HexColor('333333'),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )),
                  Row(
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          if (searchController.quantity.value > 1) {
                            searchController.quantity.value--;
                          }
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              color: HexColor('D9E9F2'),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            CupertinoIcons.minus,
                            size: 20,
                            color: HexColor('343232'),
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(searchController.quantity.toString(),
                            style: GoogleFonts.kantumruy(
                              textStyle: TextStyle(
                                  color: HexColor('333333'),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            )),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          if (remain > searchController.quantity.value) {
                            searchController.quantity.value++;
                          }
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              color: HexColor('D9E9F2'),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            CupertinoIcons.plus,
                            size: 20,
                            color: HexColor('343232'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ),
            const SizedBox(height: 20),
            Text('date-appointment'.tr,
                style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                      color: HexColor('343232'),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )),
            const SizedBox(height: 10),
            CupertinoTextField(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              readOnly: true, // disable manual text input
              controller: searchController.pickDate,
              style: GoogleFonts.kantumruy(
                textStyle: TextStyle(
                    color: HexColor('343232'),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: HexColor('D9E9F2'),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () async {
                final initialDate = searchController.getDate.value;
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  searchController.pickDate.text =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                }
              },
              suffix: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: widthScreen,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  searchController.register(idItem, type, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: Text('save'.tr,
                    style: GoogleFonts.kantumruy(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
