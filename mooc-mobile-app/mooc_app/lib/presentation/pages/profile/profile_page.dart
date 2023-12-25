import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_colors.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/login_controller.dart';
import 'package:mooc_app/presentation/controllers/profile/fetch_profile_controller.dart';
import 'package:mooc_app/presentation/pages/profile/widgets/profile_item.dart';
import '../../controllers/init_page_tab_controller.dart';

class ProfilePage extends GetView<AuthController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final auth = Get.find<AuthController>();
    final initPageTabController = Get.put(InitPageTabController());
    final loginController = Get.put(LoginController());
    final profile = Get.find<FetchProfileController>();
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      navigationBar: const CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text('Tài khoản'),
      ),
      child: Container(
          padding: EdgeInsets.only(
              top: (statusBarHeight +
                      const CupertinoNavigationBar().preferredSize.height) +
                  10.0,
              left: 30.0,
              right: 30.0),
          child: Obx(
            () => auth.isLoggedIn.value
                ? Column(
                    children: [
                      const ProfileItem(
                          titleItem: "Cập nhật hồ sơ", typeItem: 'profile'),
                      const ProfileItem(
                          titleItem: "Hộp thư thông báo", typeItem: 'notice'),
                      // const ProfileItem(
                      //     titleItem: 'Lộ trình học tập', typeItem: 'learning_path'),
                      const ProfileItem(
                          titleItem: "Lịch sử giao dịch",
                          typeItem: 'order_history'),
                      const ProfileItem(
                          titleItem: "Hỗ trợ khách hàng", typeItem: 'support'),
                      const ProfileItem(
                          titleItem: "Cài đặt và bảo mật", typeItem: 'setting'),
                      const ProfileItem(
                          titleItem: "Đánh giá ứng dụng", typeItem: 'rate'),
                      profile.isLoading.value == false
                          ? Container(
                              margin: const EdgeInsets.only(top: 50),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    topLeft: Radius.circular(50.0)),
                                image: profile.profile.value?.data?.avatar
                                            ?.isNotEmpty ??
                                        false
                                    ? DecorationImage(
                                        // image: NetworkImage(courseItem?.image_url ?? ''),
                                        image: CachedNetworkImageProvider(
                                            profile.profile.value?.data
                                                    ?.avatar ??
                                                ""),
                                        fit: BoxFit.cover)
                                    : const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/course_image.png'),
                                        fit: BoxFit.cover),
                                // borderRadius: const BorderRadius.only(
                                //     topLeft: Radius.circular(8.0),
                                //     topRight: Radius.circular(8.0)),
                              ),
                            )
                          : Container(),
                      GestureDetector(
                          onTap: () {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Đăng xuất ?'),
                                    content: const Text(
                                        'Bạn có chắc muốn đăng xuất ?'),
                                    actions: [
                                      // The "Yes" button
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          auth.logout();
                                          Navigator.of(context).pop();
                                        },
                                        isDefaultAction: true,
                                        isDestructiveAction: true,
                                        child: const Text('Xác nhận'),
                                      ),
                                      // The "No" button
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        isDefaultAction: false,
                                        isDestructiveAction: false,
                                        child: const Text('Không'),
                                      )
                                    ],
                                  );
                                });
                            // auth.logout();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Text(
                              'Đăng xuất'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: const Text('Mooc App',
                            style: TextStyle(fontSize: 14.0)),
                      ))
                    ],
                  )
                : Column(
                    children: [
                      // const ProfileItem(
                      //     titleItem: 'Hộp thư thông báo', typeItem: 'notice'),
                      // const ProfileItem(
                      //     titleItem: 'Lộ trình học tập',
                      //     typeItem: 'learning_path'),
                      const ProfileItem(
                          titleItem: 'Hỗ trợ khách hàng', typeItem: 'support'),
                      const ProfileItem(
                          titleItem: 'Lấy link giới thiệu', typeItem: 'link'),
                      const ProfileItem(
                          titleItem: 'Đánh giá ứng dụng', typeItem: 'rate'),
                      GestureDetector(
                          onTap: () async {
                            // Get.to(() => const LoginPage());
                            await loginController.authenticate();
                            if (initPageTabController
                                    .cupertinoTabController.index ==
                                3) {
                              profile.fetchDataInit();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Text(
                              'Đăng nhập'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: const Text('Mooc App',
                            style: TextStyle(fontSize: 14.0)),
                      )
                    ],
                  ),
          )),
    );
  }
}
