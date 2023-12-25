import 'package:flutter/cupertino.dart';

class AvatarError extends StatelessWidget {
  const AvatarError({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/avatar-mac-dinh.png', fit: BoxFit.cover);
  }
}