import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/shuttle/widget/add_student_to_shuttle.dart';
import 'package:mobiedu_kids/presentation/pages/manager/shuttle/widget/student_in_list_shuttle.dart';

class ListShuttle extends StatelessWidget {
  ListShuttle({super.key});

  final shuttleController = Get.find<ShuttleController>();

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final dateNow = convertDateTimeToString(date);
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 19.0),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 70.0,
                color: Colors.transparent,
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.primary,
                ),
              ),
            ),
            middle: Text(
              'Danh sách',
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
          child: Obx(
            () => Container(
                margin: const EdgeInsets.only(top: 26.0),
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ngày $dateNow',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5
                                ),
                              ),
                            ),
                            Text('${shuttleController.responseShuttle.value?.data?.pickup_class_name}',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5
                                ),
                              ),
                            ),
                            Text('Tổng số: ${shuttleController.responseShuttle.value?.data?.late_pickup?.length}',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5
                                ),
                              ),
                            ),
                            Text('Đã trả: ${shuttleController.responseShuttle.value?.data?.picked_up} học sinh',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5
                                ),
                              ),
                            ),
                          ],
                        ),
                        CupertinoButton(
                          onPressed: ()async {
                            await shuttleController.listclass();
                            shuttleController.nameClass.value = shuttleController.responseListClass.value?.data?.classes?[0].group_title ?? "";
                            shuttleController.classId.value = shuttleController.responseListClass.value?.data?.classes?[0].group_id ?? "";
                            await shuttleController.listchild();
                            Get.to(() => AddStudentToShuttle());
                          },
                          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                          color: AppColors.pink,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          child: Text('Thêm học sinh',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                height: 1.5
                              ),
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    shuttleController.listStudent.isNotEmpty ?
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: shuttleController.listStudent.length,
                        itemBuilder: (context, index) => StudentInListShuttle(
                          data: shuttleController.listStudent[index],
                          stt: index,
                        )
                      )
                    )
                  : Expanded(
                      child: SizedBox(
                        width: widthScreen,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/no_assig.png'
                            ),
                            const SizedBox(height: 8.0),
                            Text('Không có học sinh', 
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            )
                          ]
                        ),
                      ),
                    )
                  ]
                ),
              )
          )
        )
      )
    );
  }
}
