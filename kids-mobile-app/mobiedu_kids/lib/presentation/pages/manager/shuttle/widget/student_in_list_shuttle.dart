import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/data_student.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/shuttle/widget/list_buttom_shuttle.dart';

class StudentInListShuttle extends StatelessWidget {
  StudentInListShuttle({super.key, this.data, this.stt});

  final DataStudent? data;
  final int? stt;

  final shuttleController = Get.find<ShuttleController>();

  @override
  Widget build(BuildContext context) {

    return GetX(
      init: shuttleController,
      initState: (state) async {
        await shuttleController.listclass();
      },
      builder: (_) { 
      return  data != null ?
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.lightGrey
              )
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  shuttleController.toggleShow(stt!);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '${stt! + 1}. ${data?.student?.child_name}  ',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            height: 1.5
                          ),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${data?.student?.birthday}',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                height: 1.5
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      firstChild: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.0,
                        color: AppColors.primary,
                      ),
                      secondChild: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30.0,
                        color: AppColors.primary,
                      ),
                      crossFadeState: shuttleController.isShow[stt!].value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    ),
                  ],
                ),
              ),
              Text('Lớp: ${data?.student?.group_title}',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    height: 1.5
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Visibility(
                visible: shuttleController.isShow[stt!].value,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ghi chú: ',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              height: 1.5
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: CupertinoTextField(
                            controller: data?.description,
                            maxLines: 3,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: const BorderRadius.all(Radius.circular(10.0))
                            ),
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                height: 1.5
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                    data?.student?.status != '0' && data?.student?.pickup_at != '' ?
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Đón lúc: ',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                height: 1.5
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectTime(context, data?.student?.pickup_at ?? '17:00', stt!);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFF4FA),
                                borderRadius: BorderRadius.all(Radius.circular(6.0))
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                shuttleController.selectedTimes[stt]?.format(context) ?? (data?.student?.pickup_at ?? '17:00'),
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    height: 1.5
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ) 
                    : const SizedBox(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data?.student?.services?.length,
                      itemBuilder: (context, index) {
                        final isChecked = (data?.student?.services?[index].service_usage_id != null).obs;
                        final serviceId = data?.student?.services?[index].service_id;
                        final price = data?.student?.services?[index].price;
                        if (isChecked.value) {
                          while(shuttleController.serviceIds.length <= stt!) {
                            shuttleController.serviceIds.add([]);
                            shuttleController.price.add([]);
                          }
                          if (!shuttleController.serviceIds[stt!].contains(serviceId)) {
                            if (!shuttleController.selectedServices[stt!].contains(serviceId)) {
                              shuttleController.selectedServices[stt!].add(serviceId ?? '0');
                              shuttleController.selectedPrice[stt!] += [price ?? '0'];
                            }
                          }
                        }else {
                          if (stt! < shuttleController.serviceIds.length) {
                            shuttleController.serviceIds[stt!].remove(serviceId);
                          }
                        }
                        return 
                          (data?.student?.services?.isNotEmpty ?? false) ?
                            Row(
                              children: [
                                Obx(() => Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: AppColors.green,
                                    value: isChecked.value,
                                    onChanged: (bool? value) {
                                      isChecked.value = value ?? false;
                                      shuttleController.toggleService(stt!, serviceId ?? '0', price ?? '0' , isChecked.value);
                                    },
                                  )
                                ),
                                Text(data?.student?.services?[index].service_name ??'',
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            )
                            : const SizedBox();
                        }
                      ),
                    const SizedBox(height: 14.0),
                    ListButtonShuttle(
                      status: data?.student?.status,
                      time: data?.student?.pickup_at, 
                      pickup_id: int.parse(data?.student?.pickup_id ?? '0'), 
                      child_id: int.parse(data?.student?.child_id ?? '0'),
                      late_pickup_free: '0',
                      total_amount: shuttleController.toltal,
                      pickup_at: shuttleController.selectedTimes[stt]?.format(context)  ?? (data?.student?.pickup_at ?? '17:00'),
                      stt: stt!,
                      service: shuttleController.selectedServices[stt!],
                    )
                  ],
                )
              )
            ],
          )
        )
        :const SizedBox();
      }
    );
  }
}

Future<void> _selectTime(BuildContext context, String time, int index) async {
  final shuttleController = Get.find<ShuttleController>();
  final timeOfDay = convertStringToTimeOfDay(time);

  TimeOfDay? pickedTime = timeOfDay;

  pickedTime = await showTimePicker(
    context: context,
    initialTime: shuttleController.selectedTimes[index] ?? timeOfDay,
  );

  if (pickedTime != null) {
    shuttleController.setSelectedTime(pickedTime, index);
  }
}

