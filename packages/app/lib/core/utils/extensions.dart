import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension StringExtension on String {
  String vToTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map(
          (str) => str.isNotEmpty
              ? '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}'
              : str,
        )
        .join(' ');
  }
}
