import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/domain/entities/attendance/hygiene_temp.dart';
import 'package:mobiedu_kids/presentation/controllers/hygiene/hygiene_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/sleep/sleep_controller.dart';

class QuickReview extends StatelessWidget {
  QuickReview({super.key, required this.page});

  final String page;
  final hygieneController = Get.find<HygieneController>();
  final sleepController = Get.find<SleepController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double hightScreen = MediaQuery.of(context).size.height;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(top: 19.0),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              if(page == 'hygiene'){
                hygieneController.noteAll.text = '';
                hygieneController.selectedComment.value = List.generate(hygieneController.commentFormHygiene.length, (index) => '');
                hygieneController.checkComment.value = List.generate(hygieneController.commentFormHygiene.length, (index) => false);
              }else{
                sleepController.selectedComment.value = List.generate(sleepController.commentFormSleep.length, (_) => '');
                sleepController.checkComment.value = List.generate(sleepController.commentFormSleep.length, (_) => false);
                sleepController.noteAll.text = '';
              }
              
            },
            child: Container(
              width: 70.0,
              color: Colors.transparent,
              child: Icon(
                CupertinoIcons.back,
                color: AppColors.primary,
              ),
            ),
          ),
          middle: Text(
            'Nhận xét nhanh',
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
        child: Container(
          margin: const EdgeInsets.only(top: 19.0),
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: widthScreen / 4,
                    child: Text('Áp dụng cho:',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Obx(() => 
                    Expanded(
                      child: CupertinoTextField(
                        controller: TextEditingController(text: page == 'hygiene' ? hygieneController.selectedStudent.value :  sleepController.selectedStudent.value),
                        placeholder: 'Chọn học sinh',
                        placeholderStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                        maxLines: page == 'hygiene' ? (hygieneController.selectedStudent.value == '' ? 1 : 3) : (sleepController.selectedStudent.value == '' ? 1 : 3),
                        readOnly: true,
                        onTap:() {
                          _selectStudent(context, hightScreen);
                        },
                      )
                    )
                  )
                ],
              ),
              Obx(() => 
               validateWidget(context, widthScreen)
              ),
              const SizedBox(height: 24.0),
              page == 'hygiene' ?
              Obx(() => 
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widthScreen / 4,
                          child: Text('Số lần poo:',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                hygieneController.decreaseUsingAll();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5, 
                                    color:  AppColors.lightGrey
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    bottomLeft: Radius.circular(4.0),
                                  )
                                ),
                                child: Icon(
                                  CupertinoIcons.minus,
                                  color: AppColors.grey,
                                  size: 12.0,
                                ),
                              )
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5, 
                                  color:  AppColors.lightGrey
                                ),
                              ),
                              child: Text(hygieneController.numberUsing.value.toString(),
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                  hygieneController.increaseUsingAll();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5, 
                                    color:  AppColors.lightGrey
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(4.0),
                                    bottomRight: Radius.circular(4.0),
                                  )
                                ),
                                child: Icon(
                                  CupertinoIcons.plus,
                                  color: AppColors.grey,
                                  size: 12.0,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    hygieneController.valiteUsePoo.value != '' ? const SizedBox(height: 8.0) :const SizedBox(),
                    hygieneController.valiteUsePoo.value != '' ?
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widthScreen / 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0), 
                          child: Text(hygieneController.valiteUsePoo.value,
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.pink,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          )
                        )
                      ],
                    )
                    :const SizedBox()
                  ],
                ),
              )
              :  
                Row(
                  children: [
                    SizedBox(
                      width: widthScreen / 4,
                      child:
                      Text('Giờ ngủ:',
                          style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightGrey
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(2.0))
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                      child: 
                      Obx(() => 
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _selectTime(context, '11:30', 'start');
                              },
                              child: Text(convertTimeOfDayToString(sleepController.begin.value),
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Icon(
                              CupertinoIcons.arrow_right,
                              color: AppColors.lightGrey,
                              size: 16.0,
                            ),
                            const SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () {
                                _selectTime(context, '14:00', 'end');
                              },
                              child: Text(convertTimeOfDayToString(sleepController.end.value),
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 9.5),
                            Icon(
                              CupertinoIcons.time,
                              color: AppColors.lightGrey,
                              size: 16.0,
                            )
                          ],
                        ),
                      ), 
                    )
                  ],
                ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: widthScreen,
                child: CupertinoButton(
                  onPressed: () async {
                    showComment(context, widthScreen, hightScreen, page);
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.grey2,
                  child: Text(
                    'Chọn mẫu nhận xét',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  )
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: widthScreen / 4,
                    child: Text('Ghi chú:',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoTextField(
                      controller: page == 'hygiene' ? hygieneController.noteAll : sleepController.noteAll,
                      placeholder: 'Nhập ghi chú cho các bé đã chọn',
                      placeholderStyle: TextStyle(
                        color: AppColors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                      onChanged: (value) {
                        if(page == 'hygiene'){
                          final tempCheckHygiene = <bool>[];
                          tempCheckHygiene.add(value.contains(hygieneController.commentFormHygiene[0]));
                          tempCheckHygiene.add(value.contains(hygieneController.commentFormHygiene[1]));
                          hygieneController.checkComment.value = tempCheckHygiene;
                        }else{
                          final tempCheckSleep = <bool>[];
                          tempCheckSleep.add(value.contains(sleepController.commentFormSleep[0]));
                          tempCheckSleep.add(value.contains(sleepController.commentFormSleep[1]));
                          sleepController.checkComment.value = tempCheckSleep;
                        }
                      },
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                      maxLines: 5,
                    )
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: bottomPadding + 10.0),
                    width: widthScreen,
                    child: CupertinoButton(
                      onPressed: () {
                        if(page == 'hygiene'){
                          hygieneController.addDataToStudent();
                        }else{
                          sleepController.addDataToStudent();
                        }
                      },
                      color: AppColors.pink,
                      child: Text(
                        'Lưu',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                )
              )
            ]
          ),
        )
      )
    );
  }

  Widget validateWidget(BuildContext context, double widthScreen){
    final validate = page == "hygiene" ? hygieneController.validateSelectedStudent.value : sleepController.validateStudent.value;
    if(validate != ''){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: widthScreen / 4,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0), 
            child: Text(validate,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.pink,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              )
            )
          )
        ],
      );
    }else{
      return const SizedBox();
    }
  }

  _selectStudent(BuildContext context, double height){
    showDialog(
      context: context,
      builder: (BuildContext context)  {
        return Dialog(
          shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(20.0)),
          child: Container(
            constraints: BoxConstraints(maxHeight: height / 3),
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                Text('Danh sách học sinh',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Obx(() =>
                  selectedStudent(context, height)
                )
              ]
            ),
          )
        );
      }
    );
  }

  Widget selectedStudent(BuildContext context, double height){
    var checkPage = page == 'hygiene' ? hygieneController.listHygieneTemp.where((element) => element.check == false).toList().length : sleepController.listSleepTemp.where((element) => element.check == false).toList().length;
    if (checkPage != 0){
      return Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 20.0,
          shrinkWrap: true,
          childAspectRatio: 4,
          physics: const ClampingScrollPhysics(),
          children: List.generate(page == 'hygiene' ? 
          hygieneController.listHygieneTemp.where((element) => element.check == false).toList().length 
        : sleepController.listSleepTemp.where((element) => element.check == false).toList().length, 
            (index) {
              return Obx(() {
                return 
                  GestureDetector(
                    onTap: (){
                      if(page == 'hygiene'){
                        final selectedTemp = hygieneController.listHygieneTemp.where((element) => element.check == false).toList()[index];
                        final updatedList = hygieneController.listHygieneTemp.map((temp) {
                          if (temp == selectedTemp) {
                            temp.check = true;
                          }
                          return temp;
                        }).toList();
                        hygieneController.listHygieneTemp.clear();
                        hygieneController.listHygieneTemp.addAll(updatedList);
                        hygieneController.listName();
                      }else{
                        final selectedTemp = sleepController.listSleepTemp.where((element) => element.check == false).toList()[index];
                        final updatedList = sleepController.listSleepTemp.map((temp) {
                          if (temp == selectedTemp) {
                            temp.check = true;
                          }
                          return temp;
                        }).toList();
                        sleepController.listSleepTemp.clear();
                        sleepController.listSleepTemp.addAll(updatedList);
                        sleepController.listName();
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.add_circled,
                          color: AppColors.grey,
                          size: 16.0,
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            page == 'hygiene' ? '${hygieneController.listHygieneTemp.where((element) => element.check == false).toList()[index].student?.child_name}'
                          : '${sleepController.listSleepTemp.where((element) => element.check == false).toList()[index].student?.child_name}',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )
                  );
                } 
              );
            } 
          ),
        )
      );
    }else{
      return SizedBox(
        height: height / 5,
        child: Align(
          alignment: Alignment.center, 
          child: Text(
            'Học sinh đã được chọn hết!',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        )
      );
    }
  }

  _selectTime(BuildContext context,String timeBack, String typeTime) async {
    var sleepTemp = List<HygieneTemp>.from(sleepController.listSleepTemp);

    TimeOfDay? pickedTime = TimeOfDay.now();
    if(timeBack != ""){
      pickedTime = convertStringToTimeOfDay(timeBack);
    }

    pickedTime = await showTimePicker(
      context: context,
      initialTime: pickedTime,
    );
    if (pickedTime != null) {
      if(typeTime == 'start'){
        sleepController.begin.value = pickedTime;
      }else{
        sleepController.end.value = pickedTime;
      }
      sleepController.time.value = '{"begin":"${convertTimeOfDayToString(sleepController.begin.value)}","end":"${convertTimeOfDayToString(sleepController.end.value)}"}'; 
      sleepController.listSleepTemp.value = sleepTemp;
    }
  }

  showComment(context, double widthScreen, double heightScreen, String page){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(20.0)),
            child: Container(
            constraints: const BoxConstraints(maxHeight: 250),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('Chọn mẫu nhận xét',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: page == 'hygiene' ? hygieneController.commentFormHygiene.length : sleepController.commentFormSleep.length,
                      itemBuilder: (content, index) {
                        return GestureDetector(
                          onTap: () {
                            if(page == 'hygiene'){
                              hygieneController.toggleComment(index, hygieneController.commentFormHygiene[index]);
                            }
                            else{
                              sleepController.toggleComment(index, sleepController.commentFormSleep[index]);
                            }
                          },
                          child: Obx(() {
                            return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: AppColors.lightGrey
                                            )
                                          )
                                        ),
                                      child: Text(
                                        page == 'hygiene' ? hygieneController.commentFormHygiene[index] : sleepController.commentFormSleep[index]
                                      ),
                                    ),
                                  ),
                                  (page == 'hygiene' ? hygieneController.checkComment[index] == true : sleepController.checkComment[index] == true ) ?
                                  Icon(
                                    Icons.done_sharp,
                                    color: AppColors.green,
                                  )
                                : const SizedBox()
                                ],
                              );
                            }
                          )
                        );
                      }
                    ),
                  ),
                ],
              )
          ),
        );
      }
    );
  }
}

