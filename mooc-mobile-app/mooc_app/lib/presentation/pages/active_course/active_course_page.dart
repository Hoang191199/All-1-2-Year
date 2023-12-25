import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/presentation/controllers/active_course/active_course_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mooc_app/presentation/controllers/init_page_tab_controller.dart';
import 'package:mooc_app/presentation/pages/init/init_page.dart';

class ActiveCoursePage extends StatelessWidget {
  ActiveCoursePage({super.key});

  final activeCourseController = Get.find<ActiveCourseController>();
  final codeInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: onWillPop,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(AppLocalizations.of(context)!.activeCourse),
          ),
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(AppLocalizations.of(context)!.codeActive, 
                     style: const TextStyle(fontSize: 16.0, color: Colors.black)),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: TextField(
                        controller: codeInputController,
                        decoration:  InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: '${AppLocalizations.of(context)!.exam} : EDM567',
                          hintStyle: const TextStyle(fontSize: 16.0, color: Colors.black38),
                          contentPadding: const EdgeInsets.all(10.0)
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: activeCourseController.isLoading.value ? null : () {
                            handlePressActive(context, codeInputController.text.trim());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                            ),
                          child: Text(AppLocalizations.of(context)!.active),
                        )
                      ),
                    )
                  ],
                )
              )
            ),
          )
        )
      ), 
    );
  }

  Future<bool> onWillPop() async {
    reloadHomeWhenBackFromOther();
    return true;
  }

  void handlePressActive(BuildContext context, String codeInput) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (codeInput.isEmpty) {
      if (context.mounted) {
        showAlertDialog(context, AppLocalizations.of(context)!.notifications, AppLocalizations.of(context)!.noCodeActiveCourse);
      }
    } else {
      try {
        await activeCourseController.activeCourse(codeInput);
        if (!(activeCourseController.responseData.value?.error ?? false)) {
          codeInputController.clear();
          final initPageTabController = Get.put(InitPageTabController());
          initPageTabController.changeIndexTab(2);
          if (context.mounted) {
            await refreshAfterRegisterSuccess(context);
          }
          Get.to(() => InitPage());
          if (context.mounted) {
            showSnackbar(SnackbarType.success, AppLocalizations.of(context)!.course, AppLocalizations.of(context)!.activeCourseSuccess);
          }
        } else {
          if (activeCourseController.responseData.value?.code == ResponseCode.loginSession) {
            if (context.mounted) {
              showLoginSessionDialog(context);
            }
          } else {
            if (context.mounted) {
              showSnackbar(SnackbarType.error, AppLocalizations.of(context)!.course, AppLocalizations.of(context)!.activeCourseFalse);
            }
          }
        }
      } catch (error) {
        activeCourseController.setLoadingComplete();
        if (context.mounted) {
          showSnackbar(SnackbarType.error, "Error", AppLocalizations.of(context)!.error);
        }
      }
    }
  }

  refreshAfterRegisterSuccess(BuildContext context) async {
    if (context.mounted) {
      await handleRidirectToLearningCoursePage(context);
    }
  }
}
