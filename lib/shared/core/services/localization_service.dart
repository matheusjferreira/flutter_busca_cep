import 'package:flutter/material.dart';

import '../exports/app_exports.dart';

class LocalizationService {
  final AppLocalizations localizations;

  LocalizationService(this.localizations);

  static LocalizationService of(BuildContext context) {
    return LocalizationService(AppLocalizations.of(context)!);
  }
}
