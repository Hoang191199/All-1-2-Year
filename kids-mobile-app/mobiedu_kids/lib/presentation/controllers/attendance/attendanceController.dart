import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/attendance/attendace.dart';
import 'package:mobiedu_kids/domain/entities/attendance/detail_temp.dart';
import 'package:mobiedu_kids/domain/entities/attendance/upload.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/usecases/attendance_use_case.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';

class AttendanceController extends GetxController {
  AttendanceController(
    this.fetch,
    this.uploadImage,
    this.updateCheckIn,
    this.updateCheckOut,
    this.confirm
  );

  final AttendanceUserCase fetch;
  final UploadImageUserCase uploadImage;
  final UpdateUserCase updateCheckIn;
  final UpdateCheckOutUserCase updateCheckOut;
  final ConFirmUserCase confirm;

  var responseAttendance = Rx<ResponseDataObject<Attendance>?>(null);
  var responseUpload = Rx<ResponseDataObject<Upload>?>(null);

  final noteControllers = <TextEditingController>[].obs;
  final isLoading = false.obs;
  final isLoadingUpload = false.obs;
  final isLoadingupdate = false.obs;
  final isLoadingupdateCheckOut = false.obs;
  final selectedImagePath = <String>[].obs;
  final selectedImageSize = <String>[].obs;
  final selectedImageName = <String>[].obs;
  DateTime dateNow = DateTime.now();
  late TimeOfDay timeNow;
  var notAllowed = 0;
  var leavePermission = 0;
  final tabs = 'check-in'.obs;
  final listDetailCheckIn = <DetailTemp>[].obs;
  final listDetailCheckOut = <DetailTemp>[].obs;
  final checkReasonAll = false.obs;
  final imagePathCheckIn = <String>[].obs;
  final imageNameCheckIn = <String>[].obs;
  var indexTabs = 0;
  final store = Get.find<LocalStorageService>();
  final checkState = 0.obs;

  @override
  void onInit() {
    timeNow = TimeOfDay.now();
    super.onInit();
  }

  void getImage(ImageSource imageSource, int index, BuildContext context, String name) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(path: pickedFile.path);
      if(tabs.value == 'check-in'){
        listDetailCheckIn[index].source_file = rotatedImage.path;
        listDetailCheckIn[index].fileName = pickedFile.name;
      }else{
        listDetailCheckOut[index].source_file = rotatedImage.path;
        listDetailCheckOut[index].fileName = pickedFile.name;
      }
      _showImage(context, index, name);
    } else {
      showSnackbar(SnackbarType.notice, "Thất bại", "Ảnh chưa được chụp");
    }
  }

  void pickImageFromGallery(BuildContext context, int index, String name) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
        File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(path: pickedFile.path);
        if (tabs.value == 'check-in') {
          listDetailCheckIn[index].source_file = rotatedImage.path;
          listDetailCheckIn[index].fileName = pickedFile.name;
        } else {
          listDetailCheckOut[index].source_file = rotatedImage.path;
          listDetailCheckOut[index].fileName = pickedFile.name;
        }
      _showImage(context, index, name);
    } else {
      showSnackbar(SnackbarType.notice, "Thất bại", "Ảnh chưa được chọn!");
    }
  }
 
  _showImage(BuildContext context,int index, String name) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    Navigator.pop(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) => Container(
        height: heightScreen,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 50.0,
          left: 28.0,
          right: 28.0
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Chụp ảnh",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            Expanded(
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.file(
                    tabs.value == 'check-in' ? File(listDetailCheckIn[index].source_file ?? '') : File(listDetailCheckOut[index].source_file ?? ''),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: widthScreen,
              child: CupertinoButton(
                onPressed: () {
                  if(isLoadingUpload.value == false){
                    upload(index, context, name);
                  } 
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
        ),
      ),
    );
  }

  _showImageSuccess(BuildContext context,int index, String image, String name) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    Navigator.pop(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) => Container(
        height: heightScreen,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 50.0,
          left: 28.0,
          right: 28.0
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Chụp ảnh",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  urlImage() + image,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Container(
              alignment: Alignment.center,
              width: widthScreen,
              child: Text(tabs.value == 'check-in' ? 'Chào mừng bé $name đã đến lớp lúc ${convertTimeOfDayToString(TimeOfDay.now())}!' : 'Bé $name đã về lúc ${convertTimeOfDayToString(TimeOfDay.now())}!',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                textAlign: TextAlign.center
              )
            )
          ],
        ),
      ),
    );
  }

  void clearImage(int index) {
    selectedImagePath[index] = '';
    selectedImageSize[index] = '';
  }

  void toggleShow(int index, String tabs) {
    if(tabs == 'check-in'){
      listDetailCheckIn[index].show = !(listDetailCheckIn[index].show ?? false);
    }
  }

  void initializeData(int length) {
    selectedImagePath.value = List.generate(length, (_) => '');
    selectedImageSize.value = List.generate(length, (_) => '');
    selectedImageName.value = List.generate(length, (_) => '');
  }

  fetchData(String groupName, String date) async {
    isLoading(true);
    try {
      final response = await fetch.execute(Tuple2(groupName, date));
      responseAttendance.value = response;
      final listTempCheckIn = <DetailTemp>[];
      final listTempCheckOut = <DetailTemp>[];
      listDetailCheckIn.value = [];
      listDetailCheckOut.value = [];

      response.data?.attendance_list?.detail?.forEach((element) { 
        listTempCheckIn.add(element.parseToDetailTemp());
      });
      listDetailCheckIn.addAll(listTempCheckIn);

      response.data?.attendance_back?.detail?.asMap().forEach((index, data) {
        if(response.data?.attendance_back?.detail?[index].status == '1'){
          listTempCheckOut.add(data.parseToDetailTemp());
        }
      });
      listDetailCheckOut.addAll(listTempCheckOut);

     initializeData(tabs.value == 'check-in' 
      ? responseAttendance.value?.data?.attendance_list?.detail?.length ?? 0 
      : responseAttendance.value?.data?.attendance_back?.detail?.length ?? 0
    );
      notAllowed = 0;
      leavePermission = 0;
      if(responseAttendance.value?.data?.attendance_list?.present_count != '0'){
        for (var i = 0 ; i < responseAttendance.value!.data!.attendance_list!.detail!.length; i++) {
          if(responseAttendance.value?.data?.attendance_list?.detail?[i].status  == '4'){
            notAllowed += 1;
          }
          if(responseAttendance.value?.data?.attendance_list?.detail?[i].status  == '0'){
            leavePermission += 1;
          }
        }
      }
    } catch (error) {
      responseAttendance.value = null;
    }
    isLoading(false);
  }

  upload(int index, BuildContext context, String name) async {

    isLoadingUpload(true);
    var detailCheckIn = List<DetailTemp>.from(listDetailCheckIn);
    var detailCheckOut = List<DetailTemp>.from(listDetailCheckOut);

    try {
      final response = await uploadImage.execute(index);
      if (response.code == 200) {
        responseUpload.value = response;
        if(tabs.value == 'check-in'){
          listDetailCheckIn[index].source_file = response.data?.source_file ?? "";
          await _showImageSuccess(context, index, listDetailCheckIn[index].source_file ?? "", name);
          listDetailCheckIn.value = detailCheckIn;
        }else{
          listDetailCheckOut[index].source_file = response.data?.source_file ?? "";
          await _showImageSuccess(context, index, listDetailCheckOut[index].source_file ?? "", name);
          listDetailCheckOut.value = detailCheckOut;
        }
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Lưu ảnh thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Lưu ảnh thất bại!");
    }
    isLoadingUpload(false);
  }

  updateStudents() async {

    isLoadingupdate(true);
    try {
      final response = await updateCheckIn.execute();
      if (response.code == 200) {
        showSnackbar(SnackbarType.success, "Thành công",  "Cập nhật thông tin thành công!");
        await fetchData(store.getGroupname, convertDateTimeToString(dateNow));
        indexTabs = 0;
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Cập nhật thông tin thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Cập nhật thông tin thất bại!");
    }
    isLoadingupdate(false);
  }

  updateCheckOutStudents(BuildContext context) async {
    isLoadingupdateCheckOut(true);
    try {
      final response = await updateCheckOut.execute();
      if (response.code == 200) {
        showSnackbar(SnackbarType.success, "Thành công",  "Cập nhật thông tin thành công!");
        await fetchData(store.getGroupname, convertDateTimeToString(dateNow));
        indexTabs = 1;
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Cập nhật thông tin thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Cập nhật thông tin thất bại!");
    }
    
    isLoadingupdateCheckOut(false);
  }

  confirmRest(String groupName, String childId, String attendanceDetailId) async {
    try {
      final response = await confirm.execute(Tuple3(groupName, childId, attendanceDetailId));
      if (response.code == 200) {
        showSnackbar(SnackbarType.success, "Thành công",  "Xác nhận đơn nghỉ học thành công!");
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Xác nhận đơn nghỉ học thất bại!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Xác nhận đơn nghỉ học thất bại!");
    }
  }
}
