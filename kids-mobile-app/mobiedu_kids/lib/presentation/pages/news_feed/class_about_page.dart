import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/user.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/contact/contact_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/contact/contact_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/person_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class ClassAboutPage extends StatelessWidget {
  ClassAboutPage({
    super.key,
    required this.className,
  });

  final String className;

  final showGroupController = Get.find<ShowGroupController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    double heightScreen = MediaQuery.of(context).size.height;

    return GetX(
      init: showGroupController,
      initState: (state) async {
        showGroupController.showGroupAboutMembers(className, context.responsive(heightScreen - 100.0), context.responsive(44.0));
        scrollController.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) {
        return Scaffold(
          backgroundColor: HexColor('FFFFFF'),
          body: showGroupController.isLoadingAbout.value && !showGroupController.isRefresh.value
            ? const Center(
              child: CircularLoadingIndicator(),
            )
            : Container(
              padding: EdgeInsets.only(
                top: statusBarHeight + context.responsive(10.0), 
                bottom: bottomPadding + context.responsive(20.0)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageTagTop(tagName: 'Giới thiệu'),
                  SizedBox(height: context.responsive(12.0)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                    child: Container(
                      height: context.responsive(36.0),
                      decoration: BoxDecoration(
                        color: HexColor('FFFDFD'),
                        border: Border.all(color: HexColor('FFDFF1')),
                        borderRadius: BorderRadius.all(Radius.circular(context.responsive(10.0))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          aboutTypeItem(context, AboutType.intro),
                          aboutTypeItem(context, AboutType.member)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.responsive(20.0)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                      child: showGroupController.aboutType.value == AboutType.intro
                        ? Text(
                          showGroupController.infoGroupData.value?.group_title ?? '',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w700, color: HexColor('783199'))
                          ),
                        )
                        : RefreshIndicator(
                          color: AppColors.pink,
                          onRefresh: () async {
                            showGroupController.refreshGroupAboutMembers(className, context.responsive(heightScreen - 100.0), context.responsive(44.0));
                          },
                          child: ListView.separated(
                            controller: scrollController,
                            physics: const ClampingScrollPhysics(),
                            padding: EdgeInsets.only(top: 0.0, bottom: context.responsive(50.0)),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => SizedBox(height: context.responsive(8.0)), 
                            itemCount: showGroupController.isLoadMoreMember.value 
                              ? showGroupController.memberGroupData.length + 1 
                              : showGroupController.memberGroupData.length,
                            itemBuilder: (context, index) {
                              if (index < showGroupController.memberGroupData.length) {
                                final member = showGroupController.memberGroupData[index];
                                return InkWell(
                                  onTap: () {
                                    handlePressMemberItem(member);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          NewsFeedAvatar(
                                            imageNetwork: member.user_picture,
                                            radius: context.responsive(18.0),
                                            sizeAsset: context.responsive(24.0),
                                          ),
                                          SizedBox(width: context.responsive(12.0)),
                                          Text(
                                            member.user_fullname ?? '',
                                            style: GoogleFonts.raleway(
                                              textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                                            ),
                                          )
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          handlePressChatMember(member);
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.facebookMessenger, 
                                          size: context.responsive(24.0), 
                                          color: member.connection == ConnectionUser.me ? HexColor('D8D8D8') : HexColor('5DD89D')
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularLoadingIndicator(),
                                );
                              }
                            },
                          )
                        ),
                    )
                  )
                ],
              ),
            ),
        );
      }
    );
  }

  Widget aboutTypeItem(BuildContext context, String aboutType) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(context.responsive(3.0)),
        child: InkWell(
          onTap: () {
            showGroupController.aboutType.value = aboutType;
          },
          borderRadius: BorderRadius.all(Radius.circular(context.responsive(7.0))),
          child: Container(
            decoration: aboutType == showGroupController.aboutType.value
              ? BoxDecoration(
                color: HexColor('FFF4FA'),
                borderRadius: BorderRadius.all(Radius.circular(context.responsive(7.0))),
              )
              : null,
            child: Center(
              child: Text(
                aboutType == AboutType.intro ? 'Giới thiệu' : 'Thành viên',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: context.responsive(14.0), 
                    fontWeight: aboutType == showGroupController.aboutType.value ? FontWeight.w700 : FontWeight.w500, 
                    color: HexColor('783199')
                  )
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  void scrollListener() {
    if (showGroupController.canLoadMoreGroupMember.value) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        showGroupController.loadMoreShowGroupAboutMembers(className);
      }
    }
  }

  void handlePressChatMember(User member) {
    ContactBinding().dependencies();
    final contactController = Get.find<ContactController>();
    contactController.newChat(member.user_fullname, member.user_id, null, member.user_picture);
  }
  
  void handlePressMemberItem(User member) {
    HomePageBinding(member.user_name ?? '').dependencies();
    Get.to(
      () => PersonPage(
        personName: member.user_name ?? '',
        personFullName: member.user_fullname ?? '',
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}