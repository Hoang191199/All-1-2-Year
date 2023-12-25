import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/view_image_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';
import 'package:mobiedu_kids/presentation/widgets/circle_contain_asset.dart';

class TypeImage {
  static const String avatar = 'avatar';
  static const String cover = 'cover';
}

class TypeOption {
  static const String changeAvatar = 'change_avatar';
  static const String changeCover = 'change_cover';
  static const String view = 'view';
  static const String cancel = 'cancel';
}

class PageInfo extends StatelessWidget {
  PageInfo({
    super.key,
    required this.from,
    this.personName,
  });

  final String from;
  final String? personName;

  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    
    final homePageController = Get.find<HomePageController>(tag: personName);

    Future<void> handlePressSubmitImage(String typeImage) async {
      if (from == PostNewsFrom.schoolPage) {
        final typeStr = typeImage == TypeImage.avatar ? TypeCreatePost.picturePage : TypeCreatePost.covePage;
        await showPageController.changeAvatarCoverImagePage(typeStr);
      } else if (from == PostNewsFrom.classPage) {
        final typeStr = typeImage == TypeImage.avatar ? TypeCreatePost.pictureGroup : TypeCreatePost.coverGroup;
        await showGroupController.changeAvatarCoverImageGroup(typeStr);
      } else if (from == PostNewsFrom.personPage) {
        final typeStr = typeImage == TypeImage.avatar ? TypeCreatePost.pictureUser : TypeCreatePost.coverUser;
        await homePageController.changeAvatarCoverImageHome(typeStr);
      }
    }

    Widget dialogChangeAvatarCover(String typeImage) {
      return Dialog(
        backgroundColor: HexColor('FFFFFF'),
        child: Container(
          padding: EdgeInsets.all(context.responsive(20.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                typeImage == TypeImage.avatar ? 'Thay đổi ảnh đại diện' : 'Thay đổi ảnh bìa',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                ),
              ),
              SizedBox(height: context.responsive(20.0)),
              Image.file(
                typeImage == TypeImage.avatar
                  ? (from == PostNewsFrom.schoolPage
                    ? File(showPageController.imageAvatarPicked.value?.path ?? '')
                    : from == PostNewsFrom.classPage
                      ? File(showGroupController.imageAvatarPicked.value?.path ?? '')
                      : File(homePageController.imageAvatarPicked.value?.path ?? ''))
                  : (from == PostNewsFrom.schoolPage
                    ? File(showPageController.imageCoverPicked.value?.path ?? '')
                    : from == PostNewsFrom.classPage
                      ? File(showGroupController.imageCoverPicked.value?.path ?? '')
                      : File(homePageController.imageCoverPicked.value?.path ?? '')),
                width: context.responsive(200.0),
                height: context.responsive(200.0),
                fit: BoxFit.cover,
              ),
              SizedBox(height: context.responsive(20.0)),
              ElevatedButton(
                onPressed: () {
                  handlePressSubmitImage(typeImage);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(context.responsive(10.0)))
                  ),
                  elevation: 0.0,
                  backgroundColor: HexColor('FF9ACE'),
                  textStyle: GoogleFonts.raleway(
                    textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('FFFFFF'))
                  )
                ),
                child: Text(
                  typeImage == TypeImage.avatar ? 'Đặt làm ảnh đại diện' : 'Đặt làm ảnh bìa'
                )
              )
            ],
          ),
        )
      );
    }

    Future<void> handlePressItemOption(String typeImage, String option) async {
      switch (option) {
        case TypeOption.changeAvatar:
          Navigator.of(context).pop();
          if (from == PostNewsFrom.schoolPage) {
            await showPageController.pickImageAvatarPageFromGallery();
            if (showPageController.imageAvatarPicked.value != null) {
              Get.dialog(
                dialogChangeAvatarCover(typeImage)
              );
            }
          } else if (from == PostNewsFrom.classPage) {
            await showGroupController.pickImageAvatarGroupFromGallery();
            if (showGroupController.imageAvatarPicked.value != null) {
              Get.dialog(
                dialogChangeAvatarCover(typeImage)
              );
            }
          } else if (from == PostNewsFrom.personPage) {
            await homePageController.pickImageAvatarHomeFromGallery();
            if (homePageController.imageAvatarPicked.value != null) {
              Get.dialog(
                dialogChangeAvatarCover(typeImage)
              );
            }
          }
          break;
        case TypeOption.changeCover:
          Navigator.of(context).pop();
          if (from == PostNewsFrom.schoolPage) {
            await showPageController.pickImageCoverPageFromGallery();
            if (showPageController.imageCoverPicked.value != null) {
              Get.dialog(
                dialogChangeAvatarCover(typeImage)
              );
            }
          } else if (from == PostNewsFrom.classPage) {
            await showGroupController.pickImageCoverGroupFromGallery();
            if (showGroupController.imageCoverPicked.value != null) {
              Get.dialog(
                dialogChangeAvatarCover(typeImage)
              );
            }
          } else if (from == PostNewsFrom.personPage) {
            await homePageController.pickImageCoverHomeFromGallery();
            if (homePageController.imageCoverPicked.value != null) {
              Get.dialog(
                dialogChangeAvatarCover(typeImage)
              );
            }
          }
          break;
        case TypeOption.view:
          var imageNetworkUrl = '';
          if (from == PostNewsFrom.schoolPage) {
            if (typeImage == TypeImage.avatar) {
              imageNetworkUrl = showPageController.infoPageData.value?.page_picture ?? '';
            } else if (typeImage == TypeImage.cover) {
              imageNetworkUrl = showPageController.infoPageData.value?.page_cover ?? '';
            }
          } else if (from == PostNewsFrom.classPage) {
            if (typeImage == TypeImage.avatar) {
              imageNetworkUrl = showGroupController.infoGroupData.value?.group_picture ?? '';
            } else if (typeImage == TypeImage.cover) {
              imageNetworkUrl = showGroupController.infoGroupData.value?.group_cover ?? '';
            }
          } else if (from == PostNewsFrom.personPage) {
            if (typeImage == TypeImage.avatar) {
              imageNetworkUrl = homePageController.profileData.value?.user_picture ?? '';
            } else if (typeImage == TypeImage.cover) {
              imageNetworkUrl = homePageController.profileData.value?.user_cover ?? '';
            }
          }
          Navigator.of(context).pop();
          if (imageNetworkUrl.isNotEmpty) {
            Get.to(
              () => ViewImagePage(imageNetworkUrlArr: [imageNetworkUrl]),
              duration: const Duration(milliseconds: 400),
              transition: Transition.rightToLeft
            );
          }
          break;
        case TypeOption.cancel:
          Navigator.of(context).pop();
          break;
        default:
          break;
      }
    }

    Widget itemOptionImagePage(BuildContext context, String typeImage, String option) {
      var optionName = '';
      switch (option) {
        case TypeOption.changeAvatar:
          optionName = 'Thay đổi ảnh đại diện';
          break;
        case TypeOption.changeCover:
          optionName = 'Thay đổi ảnh bìa';
          break;
        case TypeOption.view:
          optionName = 'Xem ảnh';
          break;
        case TypeOption.cancel:
          optionName = 'Hủy';
          break;
        default:
          break;
      }
      return InkWell(
        onTap: () {
          handlePressItemOption(typeImage, option);
        },
        child: Container(
          padding: EdgeInsets.all(context.responsive(10.0)),
          width: double.infinity,
          child: Text(
            optionName,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
            )
          ),
        ),
      );
    }

    Widget dialogOptionImage(String typeImage) {
      return Dialog(
        backgroundColor: HexColor('FFFFFF'),
        child: Container(
          padding: EdgeInsets.all(context.responsive(20.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              typeImage == TypeImage.avatar
                ? itemOptionImagePage(context, typeImage, TypeOption.changeAvatar)
                : itemOptionImagePage(context, typeImage, TypeOption.changeCover),
              itemOptionImagePage(context, typeImage, TypeOption.view),
              itemOptionImagePage(context, typeImage, TypeOption.cancel),
            ],
          ),
        ),
      );
    }

    void handlePressAvatar() {
      if (from == PostNewsFrom.schoolPage) {
        if (showPageController.infoPageData.value?.i_admin ?? false) {
          Get.dialog(
            dialogOptionImage(TypeImage.avatar)
          );
        }
      } else if (from == PostNewsFrom.classPage) {
        if (showGroupController.infoGroupData.value?.i_admin ?? false) {
          Get.dialog(
            dialogOptionImage(TypeImage.avatar)
          );
        }
      } else if (from == PostNewsFrom.personPage) {
        if (homePageController.profileData.value?.is_admin ?? false) {
          Get.dialog(
            dialogOptionImage(TypeImage.avatar)
          );
        }
      }
    }
    
    void handlePressCoverImage() {
      if (from == PostNewsFrom.schoolPage) {
        if (showPageController.infoPageData.value?.i_admin ?? false) {
          Get.dialog(
            dialogOptionImage(TypeImage.cover)
          );
        }
      } else if (from == PostNewsFrom.classPage) {
        if (showGroupController.infoGroupData.value?.i_admin ?? false) {
          Get.dialog(
            dialogOptionImage(TypeImage.cover)
          );
        }
      } else if (from == PostNewsFrom.personPage) {
        if (homePageController.profileData.value?.is_admin ?? false) {
          Get.dialog(
            dialogOptionImage(TypeImage.cover)
          );
        }
      }
    }

    return GestureDetector(
      onTap: () {
        handlePressCoverImage();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: from == PostNewsFrom.personPage ? context.responsive(90.0) : context.responsive(40.0)),
                child: Obx(
                  () => Container(
                    width: widthScreen,
                    height: context.responsive(220.0),
                    decoration: (from == PostNewsFrom.schoolPage 
                      ? (showPageController.infoPageData.value?.page_cover?.isNotEmpty ?? false)
                      : from == PostNewsFrom.classPage
                        ? (showGroupController.infoGroupData.value?.group_cover?.isNotEmpty ?? false)
                        : (homePageController.profileData.value?.user_cover?.isNotEmpty ?? false))
                          ? BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                from == PostNewsFrom.schoolPage
                                  ? showPageController.infoPageData.value?.page_cover ?? ''
                                  : from == PostNewsFrom.classPage
                                    ? showGroupController.infoGroupData.value?.group_cover ?? ''
                                    : homePageController.profileData.value?.user_cover ?? ''
                              ),
                              fit: BoxFit.cover
                            ),
                          )
                          : BoxDecoration(
                            color: HexColor('FFDFF1'),
                          )
                  )
                ),
              ),
              Positioned(
                left: from == PostNewsFrom.personPage ? context.responsive(widthScreen / 2 - 100.0) : context.responsive(28.0),
                bottom: 0.0,
                child: GestureDetector(
                  onTap: () {
                    handlePressAvatar();
                  },
                  child: CircleAvatar(
                    radius: from == PostNewsFrom.personPage ? context.responsive(100.0) : context.responsive(75.0),
                    backgroundColor: HexColor('FFFFFF'),
                    child: Obx(
                      () => NewsFeedAvatar(
                        imageNetwork: from == PostNewsFrom.schoolPage
                          ? showPageController.infoPageData.value?.page_picture
                          : from == PostNewsFrom.classPage
                            ? showGroupController.infoGroupData.value?.group_picture
                            : homePageController.profileData.value?.user_picture,
                        radius: from == PostNewsFrom.personPage ? context.responsive(95.0) : context.responsive(70.0),
                        backgroundColor: from == PostNewsFrom.personPage ? 'D8D8D8' : 'FFF4FA',
                        linkAsset: from == PostNewsFrom.personPage ? 'assets/images/person.png' : 'assets/images/news-feed-page-group.png',
                        sizeAsset: from == PostNewsFrom.personPage ? context.responsive(80.0) : context.responsive(40.0),
                      )
                    ),
                  ),
                )
              ),
              if (
                from == PostNewsFrom.schoolPage 
                  ? (showPageController.infoPageData.value?.i_admin ?? false)
                  : from == PostNewsFrom.classPage
                    ? (showGroupController.infoGroupData.value?.i_admin ?? false)
                    : (homePageController.profileData.value?.is_admin ?? false)
              )
                Positioned(
                  left: from == PostNewsFrom.personPage ? context.responsive(widthScreen / 2 + 55.0) : context.responsive(130.0),
                  bottom: from == PostNewsFrom.personPage ? context.responsive(20.0) : context.responsive(6.0),
                  child: CircleContainAsset(
                    radius: context.responsive(10.0),
                    backgroundColor: 'D8D8D8',
                    linkAsset: 'assets/images/edit.png',
                    sizeAsset: context.responsive(14.0),
                  )
                ),
              if (
                from == PostNewsFrom.schoolPage 
                  ? (showPageController.infoPageData.value?.i_admin ?? false)
                  : from == PostNewsFrom.classPage
                    ? (showGroupController.infoGroupData.value?.i_admin ?? false)
                    : (homePageController.profileData.value?.is_admin ?? false)
              )
                Positioned(
                  right: context.responsive(18.0),
                  bottom: from == PostNewsFrom.personPage ? context.responsive(108.0) : context.responsive(58.0),
                  child: CircleContainAsset(
                    radius: context.responsive(10.0),
                    backgroundColor: 'D8D8D8',
                    linkAsset: 'assets/images/edit.png',
                    sizeAsset: context.responsive(14.0),
                  )
                )
            ],
          ),
          SizedBox(height: context.responsive(8.0)),
          from == PostNewsFrom.personPage
            ? Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
              child: Center(
                child: Text(
                  homePageController.profileData.value?.user_fullname ?? '',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(fontSize: context.responsive(22.0), fontWeight: FontWeight.w700, color: HexColor('783199'))
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
            : Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
              child: Text(
                from == PostNewsFrom.schoolPage
                  ? showPageController.infoPageData.value?.page_title ?? ''
                  : showGroupController.infoGroupData.value?.group_title ?? '',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(fontSize: context.responsive(22.0), fontWeight: FontWeight.w700, color: HexColor('783199'))
                ),
              ),
            ),
          SizedBox(height: context.responsive(5.0)),
          if (from == PostNewsFrom.schoolPage)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: showPageController.infoPageData.value?.page_likes ?? '0',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                      ),
                      children: [
                        TextSpan(
                          text: ' lượt thích',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
                          )
                        )
                      ]
                    )
                  ),
                  SizedBox(width: context.responsive(16.0)),
                  RichText(
                    text: TextSpan(
                      text: showPageController.infoPageData.value?.views_in_thirty_days ?? '0',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                      ),
                      children: [
                        TextSpan(
                          text: ' lượt xem/tháng',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
                          )
                        )
                      ]
                    )
                  ),
                ],
              ),
            ),
          if (from == PostNewsFrom.classPage)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Thành viên: ${showGroupController.infoGroupData.value?.group_members ?? ''}',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
                        ),
                      ),
                      SizedBox(width: context.responsive(5.0)),
                      Icon(CupertinoIcons.lock_fill, size: context.responsive(16.0), color: HexColor('D8D8D8'))
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      handlePressGroupJoin(context);
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: context.responsive(4.0), horizontal: context.responsive(10.0)),
                      decoration: BoxDecoration(
                        color: showGroupController.infoGroupData.value?.i_joined == GroupIJoin.pending
                          ? Colors.orange[300]
                          : showGroupController.infoGroupData.value?.i_joined == GroupIJoin.approved 
                            ? HexColor('5DD89D') 
                            : HexColor('F67882'),
                        borderRadius: const BorderRadius.all(Radius.circular(100.0))
                      ),
                      child: Text(
                        showGroupController.infoGroupData.value?.i_joined == GroupIJoin.pending
                          ? 'Chờ xác nhận'
                          : showGroupController.infoGroupData.value?.i_joined == GroupIJoin.approved 
                            ? 'Đã tham gia' 
                            : 'Tham gia',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('FFFFFF'))
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      )
    );
  }
  
  Future<void> handlePressGroupJoin(BuildContext context) async {
    if (showGroupController.infoGroupData.value?.i_joined == GroupIJoin.approved) {
      showDialog(
        context: context, 
        builder: (context) {
          return Dialog(
            backgroundColor: HexColor('FFFFFF'),
            child: Container(
              padding: EdgeInsets.fromLTRB(
                context.responsive(30.0), 
                context.responsive(30.0), 
                context.responsive(20.0), 
                context.responsive(20.0)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bạn chắc chắn muốn rời nhóm?',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w700, color: HexColor('333333'))
                    ),
                  ),
                  SizedBox(height: context.responsive(20.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: context.responsive(10.0), horizontal: context.responsive(20.0)),
                          child: Text(
                            'Không'.toUpperCase(),
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('333333'))
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: context.responsive(10.0)),
                      InkWell(
                        onTap: () {
                          handlePressSubmitLeaveGroup(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: context.responsive(6.0), horizontal: context.responsive(12.0)),
                          child: Text(
                            'Có'.toUpperCase(),
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('333333'))
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    } else if (showGroupController.infoGroupData.value?.i_joined == GroupIJoin.notJoined 
      || showGroupController.infoGroupData.value?.i_joined == GroupIJoin.notFalse
    ) {
      await showGroupController.pageConnectJoin(ActionGroupConnect.groupJoin);
    }
  }
  
  Future<void> handlePressSubmitLeaveGroup(BuildContext context) async {
    await showGroupController.pageConnectJoin(ActionGroupConnect.groupLeave);
  }
}