import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/attendance/hygiene_temp.dart';
import 'package:mobiedu_kids/presentation/controllers/hygiene/hygiene_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/sleep/sleep_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';

class ItemStudent extends StatelessWidget {
  ItemStudent({
    super.key,
    this.data,
    required this.index,
    required this.type
  });

  final HygieneTemp? data;
  final int index;
  final String type;

  final hygieneController =  Get.find<HygieneController>();
  final sleepController = Get.find<SleepController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: type == 'hygiene' ? hygieneController : sleepController,
      builder: (_) {
        var hygieneTemp = type == 'hygiene' ? List<HygieneTemp>.from(hygieneController.listHygieneTemp) :  List<HygieneTemp>.from(sleepController.listSleepTemp);
        String using = '0';
        String beginTime = '11:30';
        String endTime = '14:00';
        if(type == 'hygiene'){
         using = (data?.metadata ?? '0').replaceAll(RegExp(r'[^0-9]'), '');
        }else{
          String jsonString = '{"begin":"11:30","end":"14:00"}';
          Map<String, dynamic> jsonMap = json.decode(data?.metadata == "" ? jsonString : data?.metadata ?? jsonString);
          beginTime = jsonMap['begin']; 
          endTime = jsonMap['end'];   
        }
        
        return data == [] ?
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
          )
      :Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.lightGrey, 
              )
            )
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36.0,
                        height: 36.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: 
                          data?.student?.child_picture == null ?
                          const Image(
                            image: AssetImage(
                              'assets/images/avatar-mac-dinh.png',
                            ),
                            fit: BoxFit.cover
                          )
                        : CachedNetworkImage(
                            imageUrl: urlImageNewPost(data?.student?.child_picture ?? ''),
                            progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                            errorWidget: (context, url, error) => const AvatarError(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text('${index + 1}. ${data?.student?.child_name}',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      )
                    ],
                  ),
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: AppColors.green,
                    value: data?.check,
                    onChanged: (bool? value) {
                      data?.check = value!;
                      type == 'hygiene' ? hygieneController.listHygieneTemp.value = hygieneTemp : sleepController.listSleepTemp.value = hygieneTemp;
                      type == 'hygiene' ? hygieneController.showCheckAll(value!) : sleepController.showCheckAll(value!);
                      if(value == false) {
                        type == 'hygiene' ? hygieneController.checkAll.value = false : sleepController.checkAll.value = false;
                      }
                    }
                  )
                ]
              ),
              Container(
                margin: const EdgeInsets.only(left: 44.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    type == 'hygiene' ?
                    Row(
                      children: [
                        Text('Số lần poo:',
                            style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                hygieneController.decreaseUsing(using, index);   
                                hygieneController.listHygieneTemp.value = hygieneTemp;  
                                },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
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
                              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 18.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5, 
                                  color:  AppColors.lightGrey
                                )
                              ),
                              child: Text(using,
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
                              onTap: (){
                                hygieneController.increaseUsing(using, index);   
                                hygieneController.listHygieneTemp.value = hygieneTemp;    
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
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
                    )
                  : Row(
                      children: [
                        Text('Giờ ngủ:',
                            style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(2.0))
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _selectTime(context, beginTime, index, 'start');
                                },
                                child: Text(beginTime,
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
                                  _selectTime(context, endTime, index, 'end');
                                },
                                child: Text(endTime,
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
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    CupertinoTextField(
                      controller: data?.note,
                      placeholder: "Thêm ghi chú",
                      placeholderStyle: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1, 
                          color: AppColors.lightGrey
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                      ),
                      minLines: 2,
                      maxLines: 5,
                      suffix : GestureDetector(
                        onTap: (){
                          data?.note = TextEditingController();
                          type == 'hygiene' ? hygieneController.listHygieneTemp.value = hygieneTemp : sleepController.listSleepTemp.value = hygieneTemp;
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 6.0),
                          child: Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.grey,
                            size: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              )
            ]
          )
        );
      }
    );
  }

  _selectTime(BuildContext context,String timeBack, int index, String typeTime) async {
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
      String timeBegin = '11:30';
      String timeEnd = '14:00';
      String jsonString = '{"begin":"11:30","end":"14:00"}';
      Map<String, dynamic> jsonMap = json.decode(data?.metadata ?? jsonString);
      timeBegin = jsonMap['begin'];
      timeEnd = jsonMap['end'];

      if(typeTime == 'start'){
        timeBegin = pickedTime.format(context);
      }else{
        timeEnd = pickedTime.format(context);
      }
      TimeOfDay converTimeBegin = convertStringToTimeOfDay(timeBegin);
      TimeOfDay converTimeEnd = convertStringToTimeOfDay(timeEnd);
      int checkBegin = convertToMinutes(converTimeBegin);
      int checkEnd = convertToMinutes(converTimeEnd);
      if(checkBegin > checkEnd){
        showSnackbar(SnackbarType.notice, "Thất bại", "Thời gian bắt đầu phải nhỏ hơn thời gian kết thúc!");
        timeBegin = '11:30';
        timeEnd = '14:00';
      }

      data?.metadata = '{"begin":"$timeBegin","end":"$timeEnd"}'; 
      sleepController.listSleepTemp.value = sleepTemp;
    }
  }

  int convertToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }
}
