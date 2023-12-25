import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FeatureType { active, saleOff, combo, hot }

extension FeatureTypeItem on FeatureType {
  Icon get icon {
    switch (this) {
      case FeatureType.active:
        return const Icon(Icons.lock_open, color: Colors.white, size: 42);
      case FeatureType.saleOff:
        return const Icon(CupertinoIcons.percent, color: Colors.white, size: 42);
      case FeatureType.combo:
        return const Icon(CupertinoIcons.square_stack_3d_up, color: Colors.white, size: 42);
      case FeatureType.hot:
        return const Icon(CupertinoIcons.flame, color: Colors.white, size: 42);
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case FeatureType.active:
        return AppLocalizations.of(context)!.active;
      case FeatureType.saleOff:
        return AppLocalizations.of(context)!.discount;
      case FeatureType.combo:
        return AppLocalizations.of(context)!.combo;
      case FeatureType.hot:
        return AppLocalizations.of(context)!.selling;
    }
  }

  String get type {
    switch (this) {
      case FeatureType.active:
        return Feature.featureActive;
      case FeatureType.saleOff:
        return Feature.featureSaleOff;
      case FeatureType.combo:
        return Feature.featureCombo;
      case FeatureType.hot:
        return Feature.featureHot;
    }
  }

  get color {
    switch (this) {
      case FeatureType.active:
        return Colors.lightBlue[800];
      case FeatureType.saleOff:
        return Colors.purple[600];
      case FeatureType.combo:
        return Colors.green[500];
      case FeatureType.hot:
        return Colors.red[800];
    }
  }
}
