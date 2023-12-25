import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/profile/image_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/profile/profile_controller.dart';
import 'package:mobiedu_kids/presentation/pages/profile/customize/account_user.dart';
import 'package:mobiedu_kids/presentation/pages/profile/customize/password_user.dart';
import 'package:mobiedu_kids/presentation/pages/profile/customize/profile_user.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class CustomizePage extends StatelessWidget {
  CustomizePage({super.key});

  final store = Get.find<LocalStorageService>();
  final profileController = Get.find<ProfileController>();
  final image = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: profileController,
      initState: (_) async {
        await profileController
            .profile(store.userFromStorage?.user_name ?? "");
      },
      builder: (_) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              padding: const EdgeInsetsDirectional.only(top: 12.0),
              leading: Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColors.primary,
                  ),
                ),
              ),
              middle: Text(
                'Tài khoản',
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
            child: profileController.isLoading.value ? 
            const Center(
              child: CircularLoadingIndicator()
            ) : 
            profileController.data.value != null ? 
            Padding(
              padding: const EdgeInsets.only(top:20.0, left:16.0, right: 16.0),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Container(
                      height: 36,
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: AppColors.primary,
                        labelStyle: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.0,
                          ),
                        ),
                        unselectedLabelStyle: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.0,
                          ),
                        ),
                        indicator: BoxDecoration(
                          borderRadius:BorderRadius.circular(7.0),
                          color: AppColors.primary,
                        ),
                        tabs: const [
                          Tab(
                            child: Text("Hồ sơ"),
                          ),
                          Tab(
                            child: Text("Tài khoản"),
                          ),
                          Tab(
                            child: Text("Mật khẩu"),
                          )
                        ]
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ProfileUser(),
                          AccountUser(),
                          PasswordUser(
                            profileController: profileController, 
                            widthScreen: widthScreen, 
                            store: store
                          )
                          ]
                        )
                      )
                    ]
                  )
                ),
              )
            : const NoData()
          )
        )
      )
    );
  }
}

class ShowDateBirth extends StatelessWidget {
  ShowDateBirth({Key? key}) : super(key: key);
  final profileController = Get.find<ProfileController>();
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
                  profileController.birth.text = DateFormat('yyyy-MM-dd').format(newDateTime);
                },
                initialDateTime: DateFormat('yyyy-MM-dd').parse(profileController.birth.text == "" || profileController.birth.text == "0000-00-00" ? "1990-01-01" : profileController.birth.text),
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

class ShowDateIDIssue extends StatelessWidget {
  ShowDateIDIssue({Key? key}) : super(key: key);
  final profileController = Get.find<ProfileController>();
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
                  profileController.doi.text = DateFormat('dd/MM/yyyy').format(newDateTime);
                },
                initialDateTime: DateFormat('dd/MM/yyyy').parse(profileController.doi.text == "" ? "01/01/1990" : profileController.doi.text),
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
