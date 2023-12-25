import 'package:image_picker/image_picker.dart';

class ImageVideoPicked {
  ImageVideoPicked({
    required this.id,
    required this.type,
    required this.file,
  });

  int id;
  String type;
  XFile file;
}