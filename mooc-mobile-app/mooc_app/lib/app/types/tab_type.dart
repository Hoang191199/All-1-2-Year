import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum TabType { home, search, learning,
  // favorite,
  profile }

extension TabItem on TabType {
  Icon get icon {
    switch (this) {
      case TabType.home:
        return const Icon(CupertinoIcons.home, size: 25);
      case TabType.search:
        return const Icon(CupertinoIcons.search, size: 25);
      case TabType.learning:
        return const Icon(CupertinoIcons.book, size: 25);
      // case TabType.favorite:
      //   return const Icon(CupertinoIcons.heart, size: 25);
      case TabType.profile:
        return const Icon(CupertinoIcons.person, size: 25);
    }
  }

  Icon get activeIcon {
    switch (this) {
      case TabType.home:
        return const Icon(CupertinoIcons.house_fill, size: 25);
      case TabType.search:
        return const Icon(CupertinoIcons.search, size: 25);
      case TabType.learning:
        return const Icon(CupertinoIcons.book_fill, size: 25);
      // case TabType.favorite:
      //   return const Icon(CupertinoIcons.heart_fill, size: 25);
      case TabType.profile:
        return const Icon(CupertinoIcons.person_fill, size: 25);
    }
  }

  String  title(BuildContext context) {
    switch (this) {
      case TabType.home:
        return AppLocalizations.of(context)!.course;
      case TabType.search:
        return AppLocalizations.of(context)!.search;
      case TabType.learning:
        return AppLocalizations.of(context)!.learning;
      // case TabType.favorite:
      //   return "Yêu thích";
      case TabType.profile:
        return AppLocalizations.of(context)!.user;
    }
  }
  
}
