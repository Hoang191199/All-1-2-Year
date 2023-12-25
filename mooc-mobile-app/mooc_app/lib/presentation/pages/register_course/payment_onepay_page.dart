import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_controller.dart';
import 'package:mooc_app/presentation/controllers/checkout_courses/checkout_courses_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_combo_detail_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_scroll_controller.dart';
import 'package:mooc_app/presentation/controllers/course_detail/register_course_controller.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_combo_controller.dart';
import 'package:mooc_app/presentation/controllers/init_page_tab_controller.dart';
import 'package:mooc_app/presentation/controllers/learning/learning_course_list_controller.dart';
import 'package:mooc_app/presentation/pages/init/init_page.dart';
import 'package:mooc_app/presentation/widgets/circular_loading_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentOnepayPage extends StatefulWidget {
  const PaymentOnepayPage({
    super.key,
    required this.paymentURL,
    this.listCourseCart,
  });

  final String paymentURL;
  final List<Course>? listCourseCart;

  @override
  State<PaymentOnepayPage> createState() => _PaymentOnepayPageState();
}

class _PaymentOnepayPageState extends State<PaymentOnepayPage> {
  var loadingPercentage = 0;
  late WebViewController webViewController;

  final checkoutCoursesController = Get.find<CheckoutCoursesController>();

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
      }, onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      }, onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
        });
      }, onNavigationRequest: (NavigationRequest request) async {
        if (request.url.startsWith(OnepayCallbackUrl.redirectTest)) {
          final params = Uri.parse(request.url).queryParameters;
          try {
            await checkoutCoursesController
                .validateCheckout(params['data'] ?? '');
            if (!(checkoutCoursesController.responseValidate.value?.error ??
                false)) {
              final cartController = Get.find<CartController>();
              cartController.deleteCoursesInCart(widget.listCourseCart ?? []);
              final initPageTabController = Get.put(InitPageTabController());
              initPageTabController.changeIndexTab(2);
              await refreshAfterPaymentSuccess();
              Get.to(() => InitPage());
              showSnackbar(
                  SnackbarType.success,
                  "Thanh toán",
                  checkoutCoursesController.responseValidate.value?.message ??
                      "Thanh toán thành công");
            } else {
              if (checkoutCoursesController.responseValidate.value?.code ==
                  ResponseCode.loginSession) {
                if (context.mounted) {
                  showLoginSessionDialog(context);
                }
              } else {
                showSnackbar(
                    SnackbarType.error,
                    "Thanh toán",
                    checkoutCoursesController.responseValidate.value?.message ??
                        "Thanh toán không thành công");
              }
            }
          } catch (error) {
            showSnackbar(
                SnackbarType.error, "Error", "Có lỗi xảy ra, vui lòng thử lại");
          }
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }))
      ..loadRequest(Uri.parse(widget.paymentURL));

    super.initState();
  }

  refreshAfterPaymentSuccess() async {
    await Get.delete<CourseDetailController>();
    await Get.delete<CourseComboDetailController>();
    await Get.delete<CourseDetailScrollController>();
    await Get.delete<CourseComboController>();
    await Get.delete<RegisterCourseController>();
    await Get.delete<CheckoutCoursesController>();
    await Get.delete<LearningCourseListController>();
    // LearningCourseListBinding().dependencies();
    // final learningCourseListController = Get.find<LearningCourseListController>();
    // await learningCourseListController.fetchData();
    if (context.mounted) {
      await handleRidirectToLearningCoursePage(context);
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Thanh toán'),
        ),
        child: Container(
          padding: EdgeInsets.only(
              top: (statusBarHeight +
                  const CupertinoNavigationBar().preferredSize.height)),
          child: Stack(
            children: [
              WebViewWidget(controller: webViewController),
              loadingPercentage < 100
                  ? const Center(
                      child: CircularLoadingIndicator(),
                    )
                  : Container()
            ],
          ),
        ));
  }
}
