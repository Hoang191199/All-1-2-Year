import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/block/block_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/login/log_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class BlockPage extends StatelessWidget {
  BlockPage({super.key});
  final logincontroller = Get.find<LogController>();
  final blockController = Get.find<BlockController>();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return GetX(
      init: blockController,
      initState: (_) async {
        await blockController.list(0);
      },
      builder: (_) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 12.0),
            leading: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.primary,
                ),
              ),
            ),
            middle: Text(
              'Tài khoản',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            backgroundColor: Colors.white,
            border: const Border(),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Sau khi chặn người dùng, học sẽ không nhìn thấy những gì bạn đăng trên tường. Chú ý: Không bao gồm ứng dụng, game hoặc nhóm mà bạn tham gia.",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: blockController.isLoading.value ? 
                    const Center(
                      child: CircularLoadingIndicator()
                    ) : 
                    blockController.listBlockUser.isEmpty ? 
                    const NoData() : 
                    ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      itemCount: blockController.listBlockUser.length,
                      itemBuilder: (BuildContext context, int index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 36.0,
                            height: 36.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const ClipOval(
                              child: Image(
                                image: AssetImage('assets/images/avatar-mac-dinh.png'),
                                fit: BoxFit.cover
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          SizedBox(
                            width: widthScreen - 56 - 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: widthScreen - 56 - 150,
                                      child: Text(
                                        "${blockController.listBlockUser[index].user_fullname}",
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      )
                                    ),
                                    const Expanded(
                                      child: SizedBox()
                                    ),
                                  ]
                                )
                              ],
                            )
                          ),
                          const Expanded(
                            child: SizedBox()
                          ),
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grey.withOpacity(0.3),
                                  spreadRadius: 1, 
                                  blurRadius: 1,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: CupertinoButton(
                              onPressed: () async {
                                await blockController.unblock(blockController.listBlockUser[index].user_id ?? "");
                                await blockController.list(0);
                              },
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              child: Text(
                                'Bỏ chặn',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 14.0,
                                    fontWeight:FontWeight.w700
                                  ),
                                ),
                              )
                            )
                          ),
                        ],
                      ),
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10);
                      },
                    )
                  )
                )
              ]
            ),
          )
        )
      )
    );
  }
}
