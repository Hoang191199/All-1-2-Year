import 'package:flutter/material.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class AppTextStyles {
  static TextStyle title = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle titleDialog = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle contentDialog =
      const TextStyle(fontSize: 15.0, color: Colors.black);

  static TextStyle actionOKDialog =
      TextStyle(fontSize: 15.0, color: AppColors.primaryBlue);
}
