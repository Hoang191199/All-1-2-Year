import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostNewsComment {
  PostNewsComment({
    required this.post_id,
    this.imagePicked,
    required this.commentController,
  });

  String post_id;
  XFile? imagePicked;
  TextEditingController commentController;
}