import 'package:ancorio_rp/presentation/features/screen/screen.dart';
import 'package:ancorio_rp/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AncorioRpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AncorioRp',
      theme: ThemeData(primarySwatch: AppColors.primarySwatch),
      home: Screen(),
    );
  }
}
