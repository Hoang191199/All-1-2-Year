import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/domain/entities/attendance/detail_temp.dart';
import 'package:mobiedu_kids/presentation/controllers/attendance/attendanceController.dart';
import 'package:mobiedu_kids/presentation/pages/manager/attendance/widget/picked_image_attendance.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';

class StudentInAttendace extends StatelessWidget {
  StudentInAttendace({
    super.key,
    required this.index,
    required this.tabs
  });

  final int index;
  final String tabs;

  final attendanceController = Get.find<AttendanceController>();

  @override
  Widget build(BuildContext context) {

    return GetX(
      init: attendanceController,
      builder: (_) {
        var detailTemp = List<DetailTemp>.from(attendanceController.listDetailCheckIn);
        var detailTempOut = List<DetailTemp>.from(attendanceController.listDetailCheckOut);
        final widthScreen = MediaQuery.of(context).copyWith().size.width;

        return attendanceController.listDetailCheckIn.isNotEmpty ?
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.lightGrey
              )
            )
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
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
                          child: (tabs == "check-in" 
                            ? attendanceController.listDetailCheckIn[index].student?.child_picture == null
                            : attendanceController.listDetailCheckOut[index].student?.child_picture == null)
                              ? const Image(
                                image: AssetImage(
                                  'assets/images/avatar-mac-dinh.png',
                                ),
                                fit: BoxFit.cover
                              )
                              : CachedNetworkImage(
                                  imageUrl: tabs == "check-in"
                                    ? '${attendanceController.listDetailCheckIn[index].student?.child_picture}'
                                    : '${attendanceController.listDetailCheckOut[index].student?.child_picture}',
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                  errorWidget: (context, url, error) => const AvatarError(),
                                )
                              ),
                      ),
                      const SizedBox(width: 8.0),
                      Text('${index + 1}. ${tabs == "check-in" ? (attendanceController.listDetailCheckIn[index].student?.child_name) 
                      : (attendanceController.listDetailCheckOut[index].student?.child_name) }',
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
                    value: tabs == "check-in" ? (attendanceController.listDetailCheckIn[index].check) : (attendanceController.listDetailCheckOut[index].check_back),
                    onChanged: (bool? value) {
                      if(tabs == "check-in"){
                        detailTemp[index].check = value;
                        if(value ==  true) {
                          detailTemp[index].status = '1';
                        }else{
                          detailTemp[index].status = '0';
                          attendanceController.listDetailCheckIn[index].source_file = null;
                        }
                        attendanceController.listDetailCheckIn.value = detailTemp;
                      }else{
                        detailTempOut[index].check_back = value;
                        if(value ==  true) {
                          detailTempOut[index].status_back = '1';
                        }else{
                          attendanceController.listDetailCheckOut[index].source_file = null;
                        }
                        attendanceController.listDetailCheckOut.value = detailTempOut;
                      }
                      if(tabs == "check-in"){
                        attendanceController.toggleShow(index, tabs);
                      }
                    }
                  )
                ] ,
              ),
              Row(
                crossAxisAlignment: tabs == "check-in" ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tabs == "check-in" ?
                          Visibility(
                            visible: attendanceController.listDetailCheckIn[index].show ?? false,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Radio(
                                          value: 0,
                                          groupValue: attendanceController.listDetailCheckIn[index].permission,
                                          onChanged: (val) {
                                            detailTemp[index].permission = val as int;
                                            if(val ==  0) {
                                              detailTemp[index].status = '0';
                                            }else{
                                              detailTemp[index].status = '4';
                                            }
                                            attendanceController.listDetailCheckIn.value = detailTemp;
                                          },
                                          activeColor: const Color(0xFFF67882)
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text('Nghỉ có phép',
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Radio(
                                          value: 4,
                                          groupValue: attendanceController.listDetailCheckIn[index].permission,
                                          onChanged: (val) {
                                            detailTemp[index].permission = val as int;
                                            if(val ==  4) {
                                              detailTemp[index].status = '4';
                                            }else{
                                              detailTemp[index].status = '0';
                                            }
                                            attendanceController.listDetailCheckIn.value = detailTemp;
                                          },
                                          activeColor: const Color(0xFFF67882)
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text('Nghỉ không phép',
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ]
                              ),
                            )
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Text('Giờ về: ',
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 22.0),
                                GestureDetector(
                                  onTap: (){
                                    attendanceController.timeNow = TimeOfDay.now();
                                    _selectTime(context, attendanceController.listDetailCheckOut[index].time_back ?? '', index);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.grey),
                                      borderRadius: const BorderRadius.all(Radius.circular(5.0))
                                    ),
                                    child: Row(
                                      children: [
                                        Text(attendanceController.listDetailCheckOut[index].time_back ?? 'Giờ về', 
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Icon(
                                          CupertinoIcons.time,
                                          size: 14.0,
                                          color: AppColors.grey,
                                        )
                                      ],
                                    )
                                  ),
                                )
                              ]
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _showNote(context, widthScreen, index, tabs);
                            },
                            child: Container(
                              width: 200.0,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: AppColors.lightGrey),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                              child: Text(
                                tabs == "check-in" 
                                ? checkReason(attendanceController.listDetailCheckIn[index].student?.status, index, 
                                (attendanceController.listDetailCheckIn[index].reason)?.text ?? "Thêm ghi chú", tabs)
                                : checkReason(attendanceController.listDetailCheckOut[index].student?.came_back_status ?? '', index, 
                                (attendanceController.listDetailCheckOut[index].came_back_note)?.text ?? "Thêm ghi chú", tabs),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            )
                          )
                        ],
                      ),
                    )
                  ),
                const SizedBox(width: 8.0),
                (attendanceController.listDetailCheckIn[index].show ?? false) && tabs == "check-in" ? const SizedBox() :
                imageWidget(index, context, attendanceController.listDetailCheckIn[index].student?.child_name ?? '')
                ],
              )
            ],
          ),
        ) : const SizedBox();
      } 
    );
  }

  Widget imageWidget(int index, BuildContext context, String nameStudent) {
    final sourceFile = tabs == "check-in" ? attendanceController.listDetailCheckIn[index].source_file : attendanceController.listDetailCheckOut[index].source_file;
    if (sourceFile == null || sourceFile.isEmpty) {
      return CupertinoButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: ((builder) => PickedImageAttendace(
              index: index,
              name: nameStudent
            ))
          ); 
        },
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.pink,
        child: Text(
          'Chụp ảnh',
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w700
            ),
          ),
        )
      );
    } else {
      return SizedBox(
        width: 72.0,
        height: 95.0,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: CachedNetworkImage(
            imageUrl:  tabs == "check-in" ? '${urlImage()}${attendanceController.listDetailCheckIn[index].source_file}' 
            : '${urlImage()}${attendanceController.listDetailCheckOut[index].source_file}',
            progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
            errorWidget: (context, url, error) => const AvatarError(),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  _showNote(context, double widthScreen, int index,String tabs){
    var detailTemp = List<DetailTemp>.from(attendanceController.listDetailCheckIn);
    var detailTempBack = List<DetailTemp>.from(attendanceController.listDetailCheckOut);

    List<TextEditingController> noteControllers = detailTemp.map((detail) => TextEditingController(text: (detail.reason)?.text)).toList();
    List<TextEditingController> noteControllersBack = detailTempBack.map((detail) => TextEditingController(text: (detail.came_back_note)?.text)).toList();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 320),
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Thêm ghi chú',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.primary,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                const SizedBox(height: 28.0),
                CupertinoTextField(
                  controller: tabs == "check-in" ? noteControllers[index] : noteControllersBack[index],
                  placeholder: 'Nội dung',
                  placeholderStyle: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5, 
                      color: AppColors.grey
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0))
                  ),
                  maxLines: 2,
                  maxLength: 400,
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    Obx(() => 
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: AppColors.green,
                        value: attendanceController.checkReasonAll.value,
                        side: const BorderSide(width: 0.5),
                        onChanged: (bool? value) {
                          attendanceController.checkReasonAll.value = value!;
                        }
                      ),
                    ),
                    Text('Cập nhật cho tất cả các trẻ',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ), 
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 22.0),
                SizedBox(
                  width: widthScreen,
                  child: CupertinoButton(
                    onPressed: () {
                      if (attendanceController.checkReasonAll.value) {
                        if (tabs == "check-in") {
                          for (var i = 0; i < attendanceController.listDetailCheckIn.length; i++) {
                            attendanceController.listDetailCheckIn[i].reason = noteControllers[index];
                          }
                        } else {
                          for (var i = 0; i < attendanceController.listDetailCheckOut.length; i++) {
                            attendanceController.listDetailCheckOut[i].came_back_note = noteControllersBack[index];
                          }
                        }
                      } else {
                        if (tabs == "check-in") {
                          attendanceController.listDetailCheckIn[index].reason = noteControllers[index];
                        } else {
                          attendanceController.listDetailCheckOut[index].came_back_note = noteControllersBack[index];
                        }
                      }
                      attendanceController.listDetailCheckIn.value = detailTemp;
                      attendanceController.listDetailCheckOut.value = detailTempBack;
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                    color: AppColors.pink,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Text(
                      'Lưu',
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          height: 1.5
                        ),
                      ),
                    )
                  )
                )
              ],
            )
          ),
        );
      }
    );
  }

  _selectTime(BuildContext context,String timeBack, int index) async {
    var detailTempOut = List<DetailTemp>.from(attendanceController.listDetailCheckOut);

    TimeOfDay? pickedTime = TimeOfDay.now();
    if(timeBack != ""){
      pickedTime = convertStringToTimeOfDay(timeBack);
    }

    pickedTime = await showTimePicker(
      context: context,
      initialTime: pickedTime,
    );

    if (pickedTime != null) {
      detailTempOut[index].time_back = pickedTime.format(context);
      attendanceController.listDetailCheckOut.value = detailTempOut;
    }
  }
}


checkReason(String status, int index, String reason,String tabs) {
  var noteReason = "Thêm ghi chú";
  if(tabs == 'check-in'){
    if (status == '1' && reason != "") {
    noteReason = reason;
    }else if(status != '1' && reason != ""){
      noteReason = reason;
    }
  }else{
    if(reason != ""){
      noteReason = reason;
    }
  }

  return noteReason;
}
