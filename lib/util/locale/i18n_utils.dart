import 'package:flutter/material.dart';
import 'package:flutter_pro/generated/i18n.dart';
import 'package:flutter_pro/global/global.dart';

class I18nUtils {
  static BuildContext context =GlobalNavigator.navigatorKey.currentState.overlay.context;
  static S of() => S.of(context);
  static GeneratedLocalizationsDelegate delegate = S.delegate;
  
}
