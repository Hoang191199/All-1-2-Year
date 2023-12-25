import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/user_data.dart';
import 'package:mobiedu_kids/presentation/controllers/profile/profile_controller.dart';

class AccountUser extends StatelessWidget {
   AccountUser({super.key});

  final store = Get.find<LocalStorageService>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(14.0),
          margin: const EdgeInsets.only(top: 36.0, bottom: 46.0),
          height: 65.0,
          width: 128.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightPink2.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0,5),
              ),
            ],
          ),
          child: const ClipRRect(
            child: Image(
              height: 40,
              width: 100,
              image: AssetImage("assets/images/kids_big.png"),
              fit: BoxFit.contain
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                content: editAccount(
                  'Tên đăng nhập hiện tại của bạn là',
                  profileController.data.value?.profile?.user_name ?? '',
                  'Nhập tên đang nhập mới',
                  profileController.username
                ),
                actions: actionChange(context, 'name')
              ),
            );
          },
          child: itemAccount("assets/images/web.png", profileController.data.value?.profile?.user_name ?? '')
        ),
        const Divider(thickness: 1.0),
        GestureDetector(
          onTap: () async {
            profileController.email.text = "";
            await showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                content: editAccount(
                  'Email hiện tại của bạn là',
                  profileController.data.value?.profile?.user_email ?? '',
                  'Nhập email mới',
                  profileController.email
                ),
                actions: actionChange(context, 'email'),
              ),
            );
            profileController.email.text = "";
          },
          child: itemAccount("assets/images/mail.png", profileController.data.value?.profile?.user_email ?? '')
        ),
        const Divider(thickness: 1.0),
        profileController.data.value?.profile?.user_email_activation != null &&
        profileController.data.value?.profile?.user_email_activation != "" ? 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: (widthScreen - 20) / 2,
              child: Text(
                "Email ${profileController.data.value?.profile?.user_email_activation} chưa xác nhận",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: (widthScreen - 20) / 3,
                  child: Text( "Không nhận được mail ?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight:FontWeight.w700
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    profileController.resend();
                  },
                  child: SizedBox(
                    width:(widthScreen - 20) / 3,
                    child: Text(
                      "Gửi lại",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.red,
                          fontSize: 14,
                          fontWeight:FontWeight.w700
                        ),
                      ),
                    ),
                  )
                )
              ]
            )
          ]
        ) : 
        const SizedBox(),
        GestureDetector(
          onTap: () async {
            profileController.email.text = "";
            await showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                content: editAccount(
                  'Số điện thoại hiện tại của bạn là',
                  profileController.data.value?.profile?.user_phone ?? '',
                  'Nhập số điện thoại mới',
                  profileController.telephone
                ),
                actions: actionChange(context, 'phone'),
              ),
            );
            profileController.telephone.text = "";
          },
          child: itemAccount("assets/images/call.png", profileController.data.value?.profile?.user_phone ?? '')
        ),
        const Divider(thickness: 1.0),
      ]
    );
  }

  List<CupertinoDialogAction> actionChange(BuildContext context, String type) {
    return <CupertinoDialogAction>[
      CupertinoDialogAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Hủy',
          style: TextStyle(
            color: AppColors.primaryBlue
          )
        ),
      ),
      CupertinoDialogAction(
        onPressed: () async {
          Navigator.pop(context);
          if(type == 'email'){
            await profileController.updateSingle(
              "email",
              profileController.email.text
            );
          }
          if(type == 'name'){
            await profileController.updateSingle(
              "username",
              profileController.username.text
            );
          }
          if(type == 'phone'){
            await profileController.updateSingle(
              "phone",
              profileController.telephone.text
            );
          }
          if(type == 'email' || type == 'name'){
            final temp = store.userFromStorage;
            store.userToStorage = UserData(
              user_email: type == 'email' ? profileController.email.text : temp?.user_email,
              user_id: temp?.user_id,
              user_fname: temp?.user_fname,
              user_fullname: temp?.user_fullname,
              user_lname: temp?.user_lname,
              user_name: type == 'name' ? profileController.username.text : temp?.user_name,
              user_picture: temp?.user_picture,
              user_token: temp?.user_token,
              is_manager: temp?.is_manager
            );
          }
          await profileController.profile(store.userFromStorage?.user_name ?? "");
        },
        child: Text(
          'Ok',
          style: TextStyle(
            color:AppColors.red
          ),
        ),
      ),
    ];
  }

  Column editAccount(String title1, String title2, String title3, TextEditingController textInfo) {
    return Column(
      children: [
        Text(title1,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: AppColors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        Text(title2,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: AppColors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        Text('$title3 :',
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: AppColors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        CupertinoTextField(
          controller: textInfo
        )
      ],
    );
  }

  Container itemAccount(String image, String data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                child: Image(
                  height: 20,
                  width: 20,
                  image: AssetImage(image),
                  fit: BoxFit.cover
                ),
              ),
              const SizedBox(width: 10.0),
              Text(data,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ],
          ),
          Icon(
            Icons.edit_outlined,
            color: AppColors.grey,
            size: 24.0,
          )
        ],
      )
    );
  }
}