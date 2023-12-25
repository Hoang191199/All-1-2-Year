import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/shuttle/assignment_shuttle.dart';
import 'package:mobiedu_kids/presentation/pages/manager/shuttle/history_shuttle.dart';
import 'package:mobiedu_kids/presentation/pages/manager/shuttle/list_shuttle.dart';
import 'package:mobiedu_kids/presentation/pages/manager/shuttle/widget/item_shuttle.dart';
import 'package:mobiedu_kids/presentation/pages/manager/shuttle/widget/no_assignment.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class ShuttlePage extends StatelessWidget {
  ShuttlePage({super.key});

  final shuttleController = Get.find<ShuttleController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return GetX(
      init: shuttleController,
      initState: (state) async {
        await shuttleController.fetchData();
      },
      builder: (_) { 
        return CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 19.0),
            leading: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(CupertinoIcons.back,
                  color: AppColors.primary
                ),
              ),
            ),
            middle: Text(
              'Đón muộn',
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
          child: shuttleController.isLoading.value
          ? SizedBox(
            width: widthScreen,
              child: const Center(
                child: CircularLoadingIndicator(),
              ),
            )
          : shuttleController.responseShuttle.value?.data == null 
          ? NoAssignment() 
          : Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.5),
                  height: heightScreen / 3 - 20.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0), 
                      topRight: Radius.circular(6.0)
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/image_shuttle.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text('Trình tự thực hiện',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text('Bước 1: Nhà trường phân lịch giáo viên vào từng lớp đón muộn.',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            height: 1.5
                          ),
                        ),
                      ),
                      Text('Bước 2: Giáo viên thêm học sinh vào lớp đón muộn, đăng ký dịch vụ tương ứng.',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            height: 1.5
                          ),
                        ),
                      ),
                      Text('Bước 3: Bấm “trả học sinh” khi phụ huynh đến đón.',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            height: 1.5
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 24.0),
                ItemShuttle(
                  title: 'Thêm học sinh - Đón học sinh',
                  description: 'Thêm học sinh vào lớp đón muộn và đón trẻ tại đây',
                  icon: 'assets/images/person-add.png',
                  page: ListShuttle(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 28.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightGrey
                      )
                    )
                  ),
                ),
                ItemShuttle(
                  title: 'Lịch sử đón muộn',
                  description: 'Nơi lưu trữ thông tin chi tiết lớp đón muộn tất cả các ngày',
                  icon: 'assets/images/notebook.png',
                  page: HistoryShuttle(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 28.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightGrey
                      )
                    )
                  ),
                ),
                ItemShuttle(
                  title: 'Lịch phân công',
                  description: 'Thời gian và giáo viên được phân công cho từng lớp',
                  icon: 'assets/images/dashboard.png',
                  page: AssignmentShuttle(),
                )
              ]
            ),
          ),
        );
      }
    );
  }
}
