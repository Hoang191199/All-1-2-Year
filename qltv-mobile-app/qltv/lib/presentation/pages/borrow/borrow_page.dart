import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/domain/entities/borrow.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_controller.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_detail_binding.dart';
import 'package:qltv/presentation/controllers/text_main_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qltv/presentation/pages/borrow/borrow_detail.dart';
import 'package:qltv/presentation/pages/borrow/widgets/borrrow_item.dart';
import 'package:qltv/presentation/pages/borrow/widgets/button_add.dart';
import 'package:qltv/presentation/pages/borrow/widgets/fitter_item.dart';
import 'package:qltv/presentation/pages/borrow/widgets/no_data.dart';

class BorrowPage extends StatelessWidget {

   BorrowPage({Key? key}) : super(key: key);

  final borrowController = Get.find<BorrowController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final text = Get.put(TextMainController());

    void scrollListener() {
      if (scrollController.position.extentAfter < 200) {
        if (text.searchpagefield.text != '' && borrowController.option.value == '') {
          borrowController.loadMore(text.searchpagefield.text, null);
        } else if (text.searchpagefield.text == '' && borrowController.option.value != '') {
          borrowController.loadMore('', checkDataOption(borrowController.option.value));
        } else {
          borrowController.loadMore(text.searchpagefield.text, checkDataOption(borrowController.option.value));
        }
      }
    }

    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: onWillPop,
      child: GetX(
          init: borrowController,
          initState: (state) {
            borrowController.fetchDataBorrow('', null);
            scrollController.addListener(scrollListener);
          },
          didUpdateWidget: (old, newState) {
            scrollController.addListener(scrollListener);
          },
          dispose: (state) {
            scrollController.removeListener(scrollListener);
          },
          builder: (_) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                backgroundColor: AppColors.background,
                resizeToAvoidBottomInset: false,
                body: Container(
                  padding: EdgeInsets.only(
                    top: statusBarHeight + 25.0,
                    bottom: bottomPadding 
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: borrowController.isLoading.value
                  ? Container(
                      width: widthScreen - 28.0 - 28.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/background.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ) :
                  Container(
                    margin: const EdgeInsets.only(left: 28.0, right: 28.0),
                    width: widthScreen - 28.0 - 28.0,
                    child: Column(
                    children: [
                      Center(
                        child: Text('lending-request'.tr,
                          style: GoogleFonts.kantumruy(
                            textStyle: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      (borrowController.paging.value?.total == 0 && text.searchpagefield.text == '' && borrowController.option.value == '') 
                      ? SizedBox(
                        child: DataNull(title: 'no-document-request'.tr),
                      )
                        : Expanded(
                          child: Column(
                            children: [
                              FitterItemBorrow(),
                              borrowController.borrowData.isNotEmpty ? const ButtonAddDocument() : const SizedBox(),
                              const SizedBox(height: 14.0),
                              borrowController.borrowData.isNotEmpty? 
                              Expanded (
                                child:
                                  GridView.count(
                                    controller: scrollController,
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 16.0,
                                    mainAxisSpacing: 16.0,
                                    shrinkWrap: true,
                                    childAspectRatio: widthScreen / 160.0,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                      children: List.generate(borrowController.borrowData.length,(index) => Slidable(
                                        closeOnScroll: false,
                                        enabled : borrowController.borrowData[index]?.status == 1 ? false : true,
                                        key: ValueKey(index),
                                        endActionPane: ActionPane(
                                          motion: const StretchMotion(),
                                          dismissible: DismissiblePane(
                                            onDismissed: () {
                                              borrowController.delete(borrowController.borrowData[index]?.id ??0);
                                            }
                                          ),
                                          children: getListOption(borrowController.borrowData[index]),
                                        ),
                                        child: ItemDocument(
                                          item: borrowController.borrowData[index],
                                          widthItem: widthScreen,
                                          heightItem: heightScreen,
                                        ),
                                      ),
                                      ),
                                    ) 
                                  )
                                  : 
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: DataNull(title: 'search-no-document'.tr)
                                  ),
                                )
                            ],
                          )
                      ),
                      borrowController.isLoadMore == true ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.0),
                        child: CircularProgressIndicator(),
                      ) : const SizedBox()
                    ],
                  ),
                )
                ),
              ),
            );
          }
        ),
    );
  }

  List<Widget> getListOption(Borrow? borrow) {
    List<Widget> optionArr = [];
    if (borrow?.status == 0) {
      optionArr.add(
         SlidableAction(
            onPressed: (context) {
              BorrowDetailBinding().dependencies();
              Get.to(() => BorrowDetail(id: borrow?.id ?? 0, type: 'update'));
            },
            backgroundColor:const Color(0xFFF1B821),
            foregroundColor:Colors.white,
            icon: Icons.edit_square,
            label: 'edit'.tr,
            borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10)
            )
          )
      );
    }
    optionArr.add(
        SlidableAction(
        onPressed: (context) {
          borrowController.delete(borrow?.id ?? 0);
        },
        backgroundColor:const Color(0xFFF5222D),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'delete'.tr,
      )
    );
    return optionArr;
  }
}

String checkStatus(int status) {
  switch (status) {
    case -1:
      return 'denied'.tr;
    case 0:
      return 'not-approved'.tr;
    case 1:
      return 'approved'.tr;
    default:
      return '';
  }
}

Future<bool> onWillPop() async {
  // reloadHomeWhenBackFromOther();
  return false;
}


