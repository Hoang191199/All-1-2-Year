import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/profile/profile_controller.dart';
import 'package:mobiedu_kids/presentation/pages/profile/customize/widget/item_profile_user.dart';

class PasswordUser extends StatelessWidget {
  const PasswordUser({
    super.key,
    required this.profileController,
    required this.widthScreen,
    required this.store,
  });

  final ProfileController profileController;
  final double widthScreen;
  final LocalStorageService store;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          ItemProfileUser(
            image: "assets/images/mdi_password.png", 
            placeholderText: "Mật khẩu cũ", 
            textController: profileController.oldpassword,
            checkPassword: true,
          ),
          const Divider(thickness: 1.0),
          ItemProfileUser(
            image: "assets/images/mdi_password-check.png", 
            placeholderText: "Mật khẩu mới", 
            textController: profileController.newpassword,
            checkPassword: true,
          ),
          const Divider(thickness: 1.0),
          ItemProfileUser(
            image: "assets/images/mdi_password-reset.png", 
            placeholderText: "Xác nhận mật khẩu", 
            textController: profileController.repassword,
            checkPassword: true,
          ),
          const Divider(thickness: 1.0),
          const Expanded(
            child: SizedBox(),
          ),
          SizedBox(
            width: widthScreen,
            child: CupertinoButton(
              onPressed: () async {
                if (profileController.newpassword.text == profileController.repassword.text) {
                  if (profileController.oldpassword.text == store.passwordFromStorage) {
                    await profileController.password(
                      profileController.oldpassword.text,
                      profileController.newpassword.text,
                      profileController.repassword.text
                    );
                    profileController.oldpassword.text = "";
                    profileController.newpassword.text = "";
                    profileController.repassword.text = "";
                  } else {
                    showAlertDialog(
                      context,
                      "Lỗi",
                      "Vui lòng nhập đúng mật khẩu"
                    );
                  }
                  } else {
                    showAlertDialog(
                      context,
                      "Lỗi",
                      "Vui lòng nhập lại mật khẩu trùng khớp"
                    );
                  }
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
            )
          ]
        ),
      );
  }
}