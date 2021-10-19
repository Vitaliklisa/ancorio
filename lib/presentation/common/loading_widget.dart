
import 'package:ancorio_rp/values/app_colors.dart';
import 'package:ancorio_rp/values/app_dimens.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    this.loadingColor,
    this.backgroundColor = Colors.transparent,
    this.height,
  });

  final Animation<Color>? loadingColor;
  final Color backgroundColor;
  final double? height;

  @override
  Widget build(_) {
    return LayoutBuilder(builder: (context, constrains) {
      return Container(
        height: height,
        color: backgroundColor,
        alignment: Alignment.center,
        child: SizedBox(
          height: AppDimens.sizeLoadingIndicator,
          width: AppDimens.sizeLoadingIndicator,
          child: CircularProgressIndicator(
            strokeWidth: 8,
            valueColor: loadingColor ?? AppColors.colorDarkLoading,
            backgroundColor: Colors.black.withOpacity(0.4),
          ),
        ),
      );
    },);
  }
}
