import 'package:ancorio_rp/values/app_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppStyles {
  // decorations
  static final Decoration shadowDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: AppDimens.radiusBorderRoundedCorner,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4),
        spreadRadius: 2,
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
