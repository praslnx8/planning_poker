import 'package:flutter/widgets.dart';
import 'package:planning_poker/utils/resources/english_strings.dart';
import 'package:planning_poker/utils/resources/italian_strings.dart';
import 'package:planning_poker/utils/resources/strings.dart';

class Resources {
  BuildContext _context;

  Resources(this._context);

  Strings get strings {
    Locale locale = Localizations.localeOf(_context);
    switch (locale.languageCode) {
      case 'it':
        return ItalianStrings();
      default:
        return EnglishStrings();
    }
  }

  static Resources of(BuildContext context) {
    return Resources(context);
  }
}
