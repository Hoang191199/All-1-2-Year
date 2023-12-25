import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';

void showAlertDialog(BuildContext context, String? title, String content) {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(title ?? 'info'.tr,
                style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: HexColor('464646')))),
            content: Text(content,
                style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: HexColor('464646')))),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK',
                    style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: HexColor('464646')))),
              ),
            ],
          );
        });
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'info'.tr,
            style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: HexColor('464646')))),
        content: Text(content,
            style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: HexColor('464646')))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            style: TextButton.styleFrom(
                textStyle: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: HexColor('464646')))),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}

void showSnackbar(String type, String title, String content) {
  Get.snackbar(
    title,
    content,
    icon: Icon(
        type == SnackbarType.success
            ? CupertinoIcons.check_mark_circled
            : type == SnackbarType.error
                ? CupertinoIcons.xmark_circle
                : CupertinoIcons.info_circle,
        color: Colors.white),
    snackPosition: SnackPosition.TOP,
    backgroundColor: type == SnackbarType.success
        ? Colors.green
        : type == SnackbarType.error
            ? Colors.red
            : AppColors.primaryBlue,
    borderRadius: 10,
    colorText: Colors.white,
    duration: const Duration(seconds: 2),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(email);
}

List<Widget> getListStarViewOfFive(
    double starFillNumber, Color color, double size) {
  List<Widget> starList = [];
  var starCheck = 0.0;
  if (0 > starFillNumber) {
    starCheck = 0;
  } else if (5 < starFillNumber) {
    starCheck = 5;
  } else {
    starCheck = starFillNumber;
  }
  var starCheckFloor = starCheck.floor();
  var starCheckCeil = starCheck.ceil();
  for (int i = 1; i <= starCheckFloor; i++) {
    starList.add(Icon(Icons.star_rounded, color: color, size: size));
  }
  if (starCheckCeil > starCheckFloor) {
    starList.add(Icon(Icons.star_half_rounded, color: color, size: size));
  }
  for (int i = 1; i <= (5 - starCheckCeil); i++) {
    starList.add(Icon(Icons.star_border_rounded, color: color, size: size));
  }
  return starList;
}

T enumFromIndex<T extends Enum>(List<T> values, dynamic index, {T? def}) {
  if (index is! int) {
    index = def?.index ?? 0;
  }

  if (index > 0 && index < values.length) {
    return values[index];
  }

  return def ?? values.first;
}

NumberFormat getCurrencyFormatVN() {
  return NumberFormat("#,##0", "vi_VN");
}

TimeOfDay convertStringToTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

String convertTimeOfDayToString(TimeOfDay timeOfDay) {
  final hour = timeOfDay.hour.toString().padLeft(2, '0');
  final minute = timeOfDay.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

DateTime convertStringTimeToDateTime(String timeString) {
  final dateTimeString =
      '${DateFormat('dd/MM/yyyy').format(DateTime.now())} $timeString';
  final dateTime = DateFormat('dd/MM/yyyy HH:mm').parse(dateTimeString);
  return dateTime;
}

String convertDateTimeToString(DateTime dateTime) {
  final date = DateFormat('dd/MM/yyyy').format(dateTime);
  return date;
}

DateTime convertStringToDateTime(String dateTime) {
  final date = DateFormat('dd/MM/yyyy').parse(dateTime);
  return date;
}

String convertStringDateToStringTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);

  String time = DateFormat.Hm().format(dateTime);

  return time;
}

String urlImage() {
  return 'https://kids.codeinet.com/content/uploads/';
}

// String urlImage() {
//   return 'https://kids.mobiedu.vn/';
// }

String urlImageNewPost(String url) {
  return 'https://kids.codeinet.com/content/uploads/$url';
}

String getDayOfWeekByWeekday(int? weekday) {
  var dayOfWeek = '';
  if (weekday == null || weekday < 0 || weekday > 6) {
    return dayOfWeek;
  }
  switch (weekday) {
    case 0:
      dayOfWeek = 'Chủ nhật';
      break;
    case 1:
      dayOfWeek = 'Thứ 2';
      break;
    case 2:
      dayOfWeek = 'Thứ 3';
      break;
    case 3:
      dayOfWeek = 'Thứ 4';
      break;
    case 4:
      dayOfWeek = 'Thứ 5';
      break;
    case 5:
      dayOfWeek = 'Thứ 6';
      break;
    case 6:
      dayOfWeek = 'Thứ 7';
      break;
    default:
  }
  return dayOfWeek;
}

String dayAndDate(String time) {
  var dayAndDate = '';
  if (time.isEmpty) {
    return dayAndDate;
  }
  final dateTime = DateTime.parse(time);
  final weekday = dateTime.weekday;
  dayAndDate = getDayOfWeekByWeekday(weekday);
  dayAndDate += ', ${DateFormat('dd/MM/yyyy').format(dateTime)}';
  return dayAndDate;
}

String notiTime(String? receiveTime) {
  if (receiveTime == null || receiveTime.isEmpty) {
    return '';
  } else {
    final currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    final receiveMilliseconds =
        DateTime.parse(receiveTime).millisecondsSinceEpoch;
    final minutesFloor =
        ((currentMilliseconds - receiveMilliseconds) / (1000 * 60)).floor();
    if (minutesFloor == 0) {
      return 'Vài giây trước';
    } else if (minutesFloor > 0 && minutesFloor < 60) {
      return '$minutesFloor phút trước';
    } else if (minutesFloor >= 60 && minutesFloor < 1440) {
      // 24 * 60 = 1440
      return '${(minutesFloor / 60).floor()} giờ trước';
    } else if (minutesFloor >= 1440) {
      return '${(minutesFloor / 1440).floor()} ngày trước';
    }
    return '';
  }
}

// String toUtcDateTime(String dateTimeString) {
//   List<String> dateTimeParts = dateTimeString.split(' ');
//   String datePart = dateTimeParts[0];
//   String timePart = dateTimeParts[1];

//   List<String> timeParts = timePart.split(':');
//   String seconds = timeParts[2];
//   if (seconds.length < 2) {
//     seconds = seconds.padLeft(2, '0');
//   }

//   timePart = '${timeParts[0]}:${timeParts[1]}:$seconds';
//   dateTimeString = '$datePart $timePart';

//   DateTime dateTime = DateTime.parse(dateTimeString);
//   DateTime utcDateTime = dateTime.toUtc();
//   return utcDateTime.toIso8601String();
// }

String toUtcDateTime(String dateTimeString) {
  String time = '';
  if (dateTimeString != '') {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime utcDateTime = dateTime.toUtc();
    time = utcDateTime.toIso8601String();
  }
  return time;
}

bool isValidPhone(String phone) {
  return RegExp(r"^(?:(0|\+84|84)[3|5|7|8|9])?[0-9]{8}$").hasMatch(phone);
}

String getAlbumTitle(String title) {
  if (title.toLowerCase() == 'Cover Photos'.toLowerCase()) {
    return 'Ảnh bìa';
  } else if (title.toLowerCase() == 'Profile Pictures'.toLowerCase()) {
    return 'Ảnh hồ sơ';
  } else if (title.toLowerCase() == 'Timeline Photos'.toLowerCase()) {
    return 'Ảnh dòng thời gian';
  }
  return title;
}
