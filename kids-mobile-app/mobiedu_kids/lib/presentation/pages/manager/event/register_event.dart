import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/event/checkbox_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class RegisterEvent extends StatelessWidget {
  RegisterEvent({super.key, this.event_id});

  final String? event_id;
  final checkBox = Get.put(CheckBoxEventController());

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: checkBox.eventController,
      initState: (state) async {
        await checkBox.eventController.register(event_id ?? "");
      },
      builder: (state) => GestureDetector(
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
              'Đăng ký',
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
          child: Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 20),
            child: checkBox.eventController.isLoadingRegister.value ? 
            const Center(
              child: CircularLoadingIndicator()
            ) : 
            checkBox.eventController.list.isEmpty ? 
            const NoData() : 
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GetBuilder<CheckBoxEventController>(
                          init: CheckBoxEventController(),
                          builder: (controller) => CupertinoCheckbox(
                            checkColor: Colors.white,
                            activeColor: AppColors.green,
                            value: CheckBoxEventController.to.eventController.checkChild.value.containsValue(false) ? false : true,
                            onChanged: (bool? value) {
                              CheckBoxEventController.to.toggleEventChildAll(value);
                            }
                          )
                        ),
                        Text("Tất cả học sinh",
                            style: GoogleFonts.raleway()
                        )
                      ],
                    ),
                    Row(
                      children: [
                        checkBox.eventController.checkParent.value.isNotEmpty ? 
                        GetBuilder<CheckBoxEventController>(
                          init: CheckBoxEventController(),
                          builder: (controller) => CupertinoCheckbox(
                            checkColor: Colors.white,
                            activeColor: AppColors.green,
                            value: CheckBoxEventController.to.eventController.checkParent.value.containsValue(false) ? false : true,
                            onChanged: (bool? value) {
                              CheckBoxEventController.to.toggleEventParentAll(value);
                            }
                          )
                        ) : Container(),
                        checkBox.eventController.checkParent.value.isNotEmpty ? 
                        Text(
                          "Tất cả phụ huynh",
                          style: GoogleFonts.raleway(),
                        ) : Container()
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemCount: checkBox.eventController.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36.0,
                                height: 36.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle
                                ),
                                child: const ClipOval(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/avatar-mac-dinh.png',
                                    ),
                                    fit: BoxFit.cover
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                '${checkBox.eventController.list[index].child_name}',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              GetBuilder<CheckBoxEventController>(
                                init: CheckBoxEventController(),
                                builder: (controller) => CupertinoCheckbox(
                                  checkColor: Colors.white,
                                  activeColor: AppColors.green,
                                  value: CheckBoxEventController.to.eventController.checkChild.value[CheckBoxEventController.to.eventController.list[index].child_id] ?? false,
                                  onChanged: (bool? value) {
                                    CheckBoxEventController.to.toggleEventChild(CheckBoxEventController.to.eventController.list[index].child_id ?? "", value);
                                  }
                                )
                              ),
                            ],
                          ),
                          checkBox.eventController.list[index].parent != null ? 
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: checkBox.eventController.list[index].parent?.length,
                            itemBuilder: (BuildContext context, int ind) {
                              return Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 36.0),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Row(children: []),
                                        ),
                                        Text(
                                          '${checkBox.eventController.list[index].parent?[ind].user_fullname}',
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14.0,
                                              fontWeight:FontWeight.w700
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox()
                                  ),
                                  GetBuilder<CheckBoxEventController>(
                                    init: CheckBoxEventController(),
                                    builder: (controller) => CupertinoCheckbox(
                                      checkColor: Colors.white,
                                      activeColor: AppColors.green,
                                      value: CheckBoxEventController.to.eventController.checkParent.value[CheckBoxEventController.to.eventController.list[index].parent?[ind].user_id] ?? false,
                                      onChanged: (bool? value) {
                                        CheckBoxEventController.to.toggleEventParent(CheckBoxEventController.to.eventController.list[index].parent?[ind].user_id ?? "", value);
                                      }
                                    )
                                  ),
                                ],
                              );
                            }
                          ) : Container()
                        ]
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  )
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10 + bottomPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widthScreen - 56,
                        child: CupertinoButton(
                          onPressed: () async {
                            await checkBox.eventController.savelistAttend(event_id ?? "");
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors.pink,
                          child: Text(
                            'Đăng ký',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          )
                        )
                      ),
                    ]
                  ),
                )
              ]
            )
          )
        )
      )
    );
  }
}
