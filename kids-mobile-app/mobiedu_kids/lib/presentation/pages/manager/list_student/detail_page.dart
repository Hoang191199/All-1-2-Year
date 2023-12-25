import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/presentation/controllers/contact/contact_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/messenger/messenger_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_binding.dart';
import 'package:mobiedu_kids/presentation/pages/manager/list_student/edit_detail_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/list_student/widgets/student_info.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/person_page.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';
// import 'package:mobiedu_kids/presentation/pages/manager/menu/widget/student_in_menu.dart';

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  DetailPage({super.key, this.child_id});

  String? child_id;
  final childController = Get.find<ChildController>();
  final store = Get.find<LocalStorageService>();
  final contactController = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    // double widthScreen = MediaQuery.of(context).size.width;
    // double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: childController,
      initState: (state) async {
        await childController.detail(store.getGroupname, child_id ?? '');
      },
      builder: (state) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 12.0),
            trailing: Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  ChildBinding().dependencies();
                  Get.to(() => EditDetailPage(
                    child_id: child_id,
                  ));
                },
                child: Icon(Icons.edit, size: 24.0, color: AppColors.primary),
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(CupertinoIcons.back, color: AppColors.primary),
              ),
            ),
            middle: Text(
              'Thông tin',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(color: AppColors.primary, fontSize: 22.0, fontWeight: FontWeight.w700),
              ),
            ),
            backgroundColor: Colors.white,
            border: const Border(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 22.0),
              child: childController.isdetailLoading.value
                ? const Center(
                  child: CircularLoadingIndicator()
                )
                : Column(
                  children: [
                    StudentInfo(),
                    const Divider(height: 40, thickness: 1.0),
                    infoStudent("Tên phụ huynh", childController.child_info.value?.parent_name ?? ''),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Điện thoại:",
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          )
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                childController.child_info.value?.parent_phone ?? '',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: AppColors.black),
                                ),
                              ),
                              Row(
                                children: [
                                  childController.child_info.value?.parent_phone != null && (childController.child_info.value?.parent_phone?.isNotEmpty ?? false)
                                    ? GestureDetector(
                                      onTap: () async {
                                        childController.textSMS.text = "";
                                        await _displayTextInputDialog(
                                          context,
                                          childController.child_info.value?.parent_phone ?? ""
                                        );
                                        childController.textSMS.text = "";
                                      },
                                      child: const ClipOval(
                                        child: Image(
                                          height: 24.0,
                                          width: 24.0,
                                          image: AssetImage("assets/images/chat.png"),
                                          fit: BoxFit.cover
                                        ),
                                      )
                                    )
                                    : const SizedBox(),
                                  childController.child_info.value?.parent_phone != null && (childController.child_info.value?.parent_phone?.isNotEmpty ?? false)
                                    ? GestureDetector(
                                      onTap: () async {
                                        final Uri url = Uri(
                                          scheme: 'tel',
                                          path: '${childController.child_info.value?.parent_phone}'
                                        );
                                        if (await UrlLauncher.canLaunchUrl(url)) {
                                          await UrlLauncher.launchUrl(url);
                                        }
                                      },
                                      child: const ClipOval(
                                        child: Image(
                                          height: 24.0,
                                          width: 24.0,
                                          image: AssetImage("assets/images/phone.png"),
                                          fit: BoxFit.cover
                                        ),
                                      )
                                    )
                                    : const SizedBox()
                                ],
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    infoStudent("Email", childController.child_info.value?.parent_email ?? ''),
                    const SizedBox(height: 20.0),
                    infoStudent("Địa chỉ", childController.child_info.value?.address ?? ''),
                    const SizedBox(height: 20.0),
                    infoStudent("Ngày nhập học", childController.child_info.value?.begin_at ?? ''),
                    const Divider(height: 40.0, thickness: 1.0),
                    Expanded(
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        separatorBuilder: (context, index) => const Divider(height: 30, thickness: 1.0),
                        itemCount: childController.child_info.value?.parent?.length != null && childController.child_info.value?.parent != null
                          ? (childController.child_info.value!.parent!.length + 1)
                          : 1,
                        itemBuilder: (context, index) => childController.child_info.value?.parent != null && (childController.child_info.value?.parent?.isNotEmpty ?? false)
                          ? (index != childController.child_info.value?.parent?.length)
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phụ huynh",
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                GestureDetector(
                                  onTap: () {
                                    NewsFeedBinding().dependencies();
                                    ShowPageBinding().dependencies();
                                    ShowGroupBinding().dependencies();
                                    HomePageBinding(childController.child_info.value?.parent?[index].user_name ?? '').dependencies();
                                    SavedPostsBinding().dependencies();
                                    Get.to(
                                      () => PersonPage(
                                        personName: childController.child_info.value?.parent?[index].user_name ?? '',
                                        personFullName: childController.child_info.value?.parent?[index].user_fullname ?? '',
                                      ),
                                      duration: const Duration(milliseconds: 400),
                                      transition: Transition.rightToLeft
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 40.0,
                                              width: 40.0,
                                              child: ClipOval(
                                                child: (childController.child_info.value?.parent?[index].user_picture == null || (childController.child_info.value?.parent?[index].user_picture?.isEmpty ?? false))
                                                  ? Image.asset('assets/images/avatar-mac-dinh.png', fit: BoxFit.contain)
                                                  : CachedNetworkImage(
                                                    imageUrl: childController.child_info.value?.parent?[index].user_picture ?? '',
                                                    errorWidget: (context, url, error) => Image.asset('assets/images/avatar-mac-dinh.png', fit: BoxFit.contain),
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ),
                                            const SizedBox(width: 10.0),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${childController.child_info.value?.parent?[index].user_fullname}",
                                                  style: GoogleFonts.raleway(
                                                    textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: AppColors.black),
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  "${childController.child_info.value?.parent?[index].user_phone}",
                                                  style: GoogleFonts.raleway(
                                                    textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          childController.child_info.value?.parent?[index].user_phone != null && (childController.child_info.value?.parent?[index].user_phone?.isNotEmpty ?? false)
                                            ? GestureDetector(
                                              onTap: () async {
                                                Get.put(MessengerController());
                                                contactController.newChat(
                                                  childController.child_info.value?.parent?[index].user_fullname,
                                                  childController.child_info.value?.parent?[index].user_id,
                                                  childController.child_info.value?.parent?[index].user_email,
                                                  childController.child_info.value?.parent?[index].user_picture,
                                                );
                                              },
                                              child: const ClipOval(
                                                child: Image(
                                                  height: 24.0,
                                                  width: 24.0,
                                                  image: AssetImage("assets/images/chat.png"),
                                                  fit: BoxFit.cover
                                                ),
                                              )
                                            )
                                            : const SizedBox(),
                                          childController.child_info.value?.parent?[index].user_phone != null && (childController.child_info.value?.parent?[index].user_phone?.isNotEmpty ?? false)
                                            ? GestureDetector(
                                              onTap: () async {
                                                final Uri url = Uri(scheme: 'tel', path: '${childController.child_info.value?.parent?[index].user_phone}');
                                                if (await UrlLauncher.canLaunchUrl(url)) {
                                                  await UrlLauncher.launchUrl(url);
                                                }
                                              },
                                              child: const ClipOval(
                                                child: Image(
                                                  height: 24.0,
                                                  width: 24.0,
                                                  image: AssetImage("assets/images/phone.png"),
                                                  fit: BoxFit.cover
                                                ),
                                              ),
                                            )
                                            : const SizedBox()
                                        ],
                                      ),
                                    ],
                                  )
                                )
                              ],
                            )
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mô tả",
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  "${childController.child_info.value?.description}",
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                                  ),
                                ),
                              ]
                            )
                          : Column(
                            children: [
                              Text(
                                "Mô tả",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                "${childController.child_info.value?.description}",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                    ],
                  )
                )
              )
            )
          );
  }

  Row infoStudent(String title, String data) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$title :",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.black),
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          )
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 3,
          child: Text(
            data,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: AppColors.black),
            ),
            overflow: TextOverflow.ellipsis,
          )
        )
      ],
    );
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, String phone) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Soạn tin',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.black,
                ),
              ),
            ),
            content: TextField(
              controller: childController.textSMS,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.black,
                ),
              ),
              decoration: InputDecoration(
                hintText: "Nội dung tin nhắn",
                hintStyle: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    final Uri url = Uri(
                        scheme: 'sms',
                        path: phone,
                        queryParameters: <String, String>{
                          'body':
                              Uri.encodeComponent(childController.textSMS.text),
                        });
                    if (await UrlLauncher.canLaunchUrl(url)) {
                      await UrlLauncher.launchUrl(url);
                    }
                  },
                  child: Text(
                    "Gửi",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ))
            ],
          );
        });
  }
}
