import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/presentation/controllers/contact/contact_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactPage extends StatelessWidget {
  ContactPage ({
    super.key
  });

  final contactController = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: contactController,
      initState: (state) async {
        await contactController.fetchData();
      },
      builder: (_) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                padding: const EdgeInsetsDirectional.only(top: 18.0),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 70.0,
                    color: Colors.transparent,
                    child: Icon(CupertinoIcons.back,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                middle: Text(
                  'Liên hệ',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.primary,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                border: const Border(),
              ),
              child: contactController.isLoading.value ? 
                const SizedBox(
                    child: Center(
                      child: CircularLoadingIndicator(),
                    ),
                  )
                :
              contactController.responseData.value?.data == null ?
                SizedBox(
                width: widthScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/no_assig.png'
                    ),
                    const SizedBox(height: 8.0),
                    Text('Không có dữ liệu', 
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
              ): 
              Container(
                margin: const EdgeInsets.only(top: 15.0),
                width: widthScreen,
                child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: widthScreen,
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColors.lightPink,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Quản lý trường',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: contactController.responseData.value?.data?.school?.admin?.user_picture == '' ?
                                       Image.asset(
                                        'assets/images/avatar-mac-dinh.png',
                                        fit: BoxFit.cover
                                      )
                                    : CachedNetworkImage(
                                        imageUrl:  '${contactController.responseData.value?.data?.school?.admin?.user_picture}',
                                        progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                        errorWidget: (context, url, error) => const AvatarError(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${contactController.responseData.value?.data?.school?.page_title}',
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          maxLines: 1
                                        ),
                                        if(contactController.responseData.value?.data?.school?.telephone != '')
                                        Text('Đường dây nóng: ${contactController.responseData.value?.data?.school?.telephone}',
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          maxLines: 1
                                        ),
                                        Text('Quản lý: ${contactController.responseData.value?.data?.school?.admin?.user_fullname}',
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          maxLines: 1
                                        ),
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    contactController.newChat(
                                      contactController.responseData.value?.data?.school?.admin?.user_fullname, 
                                      contactController.responseData.value?.data?.school?.admin?.user_id, 
                                      contactController.responseData.value?.data?.school?.admin?.user_email,
                                      contactController.responseData.value?.data?.school?.admin?.user_picture,
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.chat_bubble_text,
                                    color:  AppColors.green,
                                    size: 24.0,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                GestureDetector(
                                  onTap: (){
                                    launchCaller(contactController.responseData.value?.data?.school?.telephone ?? '');
                                  },
                                  child: Icon(
                                    CupertinoIcons.phone,
                                    color:  AppColors.green,
                                    size: 24.0,
                                  ),
                                ),
                              ],
                            )
                          ]
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: widthScreen,
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColors.lightPink,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Giáo viên: ${contactController.responseData.value?.data?.classContact?.group_title}',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: contactController.responseData.value?.data?.teacher?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: 
                                          contactController.responseData.value?.data?.teacher?[index].user_picture == '' ?
                                          Image.asset(
                                            'assets/images/avatar-mac-dinh.png',
                                            fit: BoxFit.cover
                                          )
                                        : Image.network(
                                            contactController.responseData.value?.data?.teacher?[index].user_picture ?? '',
                                            fit: BoxFit.cover
                                          )
                                        )
                                      ),
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${contactController.responseData.value?.data?.teacher?[index].user_fullname}',
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              maxLines: 1
                                            ),
                                            Text('${contactController.responseData.value?.data?.teacher?[index].user_phone}',
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              maxLines: 1
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        contactController.newChat(
                                          contactController.responseData.value?.data?.teacher?[index].user_fullname, 
                                          contactController.responseData.value?.data?.teacher?[index].user_id, 
                                          contactController.responseData.value?.data?.teacher?[index].user_email, 
                                          contactController.responseData.value?.data?.teacher?[index].user_picture
                                        );
                                      },
                                      child: Icon(
                                        CupertinoIcons.chat_bubble_text,
                                        color:  AppColors.green,
                                        size: 24.0,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    GestureDetector(
                                      onTap: (){
                                        launchCaller(contactController.responseData.value?.data?.teacher?[index].user_phone ?? '');
                                      },
                                      child: Icon(
                                        CupertinoIcons.phone,
                                        color:  AppColors.green,
                                        size: 24.0,
                                      ),
                                    ),
                                  ],
                                )
                              ]
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: widthScreen,
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColors.lightPink,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Danh sách lớp: ${contactController.responseData.value?.data?.child_list?.length} học sinh',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      if(contactController.responseData.value?.data?.child_list?.isNotEmpty ?? false) 
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: contactController.responseData.value?.data?.child_list?.length,
                        itemBuilder: (context, index) {
                          return 
                          ((contactController.responseData.value?.data?.child_list?[index].parent?.isNotEmpty ?? false) 
                          && contactController.store.getChild?.user_id != contactController.responseData.value?.data?.child_list?[index].parent?[0].user_id) ?
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: contactController.responseData.value?.data?.child_list?[index].parent?[0].user_picture == '' ?
                                          Image.asset(
                                            'assets/images/avatar-mac-dinh.png',
                                            fit: BoxFit.cover
                                          )
                                        : Image.network(
                                            '${contactController.responseData.value?.data?.child_list?[index].parent?[0].user_picture}',
                                            fit: BoxFit.cover
                                          )
                                        )
                                      ),
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${contactController.responseData.value?.data?.child_list?[index].child_name}',
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              maxLines: 1
                                            ),
                                            Text('${contactController.responseData.value?.data?.child_list?[index].parent?[0].user_fullname}',
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              maxLines: 1
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        contactController.newChat(
                                          contactController.responseData.value?.data?.child_list?[index].parent?[0].user_fullname, 
                                          contactController.responseData.value?.data?.child_list?[index].parent?[0].user_id, 
                                          contactController.responseData.value?.data?.child_list?[index].parent_email, 
                                          contactController.responseData.value?.data?.child_list?[index].parent?[0].user_picture
                                        );
                                      },
                                      child: Icon(
                                        CupertinoIcons.chat_bubble_text,
                                        color:  AppColors.green,
                                        size: 24.0,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    GestureDetector(
                                      onTap: (){
                                        launchCaller(contactController.responseData.value?.data?.child_list?[index].parent?[0].user_phone ?? '');
                                      },
                                      child: Icon(
                                        CupertinoIcons.phone,
                                        color:  AppColors.green,
                                        size: 24.0,
                                      ),
                                    ),
                                  ],
                                )
                              ]
                            ),
                          )
                        : const SizedBox();
                        }
                      ),
                    ],
                  ),
                ),
              ),
            )
          )
        );
      }
    );
  }

  launchCaller(String phoneNumber) async {
    if(phoneNumber != ''){
      Uri url = Uri(scheme: "tel", path: phoneNumber);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } 
    }else{
      showSnackbar(SnackbarType.notice, "Thất bại", "Số điện thoại đang được cập nhật. Vui lòng truy cập lại sau!");
    }
  }
}