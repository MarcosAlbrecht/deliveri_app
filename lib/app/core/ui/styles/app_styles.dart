import 'package:delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static AppStyles? _instance;
  // Avoid self instance
  AppStyles._();
  static AppStyles get i => _instance ??= AppStyles._();

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(7),
    ),
    backgroundColor: ColorsApp.i.primary,
    textStyle: TextStyles.i.textButtonLabel,
  );
}

extension AppStylesExtensions on BuildContext {
  AppStyles get appStyles => AppStyles.i;
}
