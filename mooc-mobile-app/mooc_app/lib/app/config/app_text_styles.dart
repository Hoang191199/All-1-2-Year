import 'package:flutter/material.dart';
import 'package:mooc_app/app/config/app_colors.dart';

class AppTextStyles {
  static TextStyle title = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle body = const TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );

  static TextStyle titleDialog = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle contentDialog = const TextStyle(
    fontSize: 15.0,
    color: Colors.black
  );

  static TextStyle actionOKDialog = TextStyle(
    fontSize: 15.0, 
    color: AppColors.primaryBlue
  );

  static TextStyle actionCancelDialog = const TextStyle(
    fontSize: 15.0, 
    color: Colors.red
  );

  static TextStyle paymentMethod = const TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    color: Colors.black
  );
}
