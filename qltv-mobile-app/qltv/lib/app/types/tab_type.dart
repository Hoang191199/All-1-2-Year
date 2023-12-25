import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TabType { home, bookcase, search, borrow, readerCard }

extension TabItem on TabType {
  Icon get icon {
    switch (this) {
      case TabType.home:
        return const Icon(CupertinoIcons.house);
      case TabType.bookcase:
        return const Icon(CupertinoIcons.book);
      case TabType.search:
        return const Icon(CupertinoIcons.search);
      case TabType.borrow:
        return const Icon(Icons.checklist);
      case TabType.readerCard:
        return const Icon(Icons.contact_emergency_outlined);
    }
  }

  Icon get activeIcon {
    switch (this) {
      case TabType.home:
        return const Icon(CupertinoIcons.house_fill);
      case TabType.bookcase:
        return const Icon(CupertinoIcons.book_fill);
      case TabType.search:
        return const Icon(CupertinoIcons.search);
      case TabType.borrow:
        return const Icon(Icons.checklist);
      case TabType.readerCard:
        return const Icon(Icons.contact_emergency_rounded);
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case TabType.home:
        return "home".tr;
      case TabType.bookcase:
        return "bookcase".tr;
      case TabType.search:
        return "search".tr;
      case TabType.borrow:
        return "lending-request".tr;
      case TabType.readerCard:
        return "reader-card".tr;
    }
  }
}
