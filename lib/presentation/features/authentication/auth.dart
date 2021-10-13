import 'package:ancorio_rp/presentation/common/loading_widget.dart';
import 'package:ancorio_rp/presentation/features/authentication/auth_model.dart';
import 'package:ancorio_rp/presentation/features/authentication/auth_view.dart';
import 'package:ancorio_rp/presentation/features/screen/screen.dart';
import 'package:ancorio_rp/presentation/utils/screen_size.dart';
import 'package:ancorio_rp/values/app_dimens.dart';
import 'package:ancorio_rp/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> implements AuthView {
  @override
  MediaQueryData get mediaData => MediaQuery.of(context);

  @override
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void pushHomePage() {
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => Screen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => AuthModel(this),
        child: Consumer<AuthModel>(
          builder: (context, model, widget) {
            model.initView();
            return _buildAuthPage(model);
          },
        ),
      ),
    );
  }

  Widget _buildAuthPage(AuthModel model) {
    // init view
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Center(
        // moves content a bit higher from center
        heightFactor: 1,
        child: AspectRatio(
          //controls how much picture will be visible on top of auth card
          aspectRatio: 5/ 2,
          child: _buildAuthCard(model),
        ),
      ),
    );
  }

  Widget _buildAuthCard(AuthModel model) {
    final ScreenSize screenSize = getScreenSizeByWidth(context);
    final bool isSmall = screenSize == ScreenSize.small;
    return Container(height: 100,
      alignment: Alignment.center,
      decoration: AppStyles.shadowDecoration,
      margin: isSmall
          ? const EdgeInsets.symmetric(horizontal: 32,vertical: 32)
          : const EdgeInsets.symmetric(horizontal: 500,vertical: 100),
      child: Column(
        // the arrangement of the column content to center
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // build title
          Text(
            'authorization',
            style: isSmall
                ? Theme.of(context).textTheme.bodyText1
                : Theme.of(context).textTheme.subtitle1,
          ),

          _buildSubtitle(model),

          if (model.isLoading)
            const LoadingWidget()
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGoogleIconButton(model),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildGoogleIconButton(AuthModel model) {
    final ScreenSize screenSize = getScreenSizeByWidth(context);
    final bool isSmallScreen = screenSize == ScreenSize.small;
    final double iconSize =
        isSmallScreen ? AppDimens.sizeAuthIcon : AppDimens.sizeAuthIcon * 2;
    return IconButton(
      iconSize: iconSize,
      icon: SvgPicture.asset(
        "assets/images/pic_google.svg",
        width: iconSize,
        height: iconSize,
      ),
      onPressed: model.onGoogleIconPressed,
    );
  }

  Widget _buildSubtitle(AuthModel model) {
    final bool isSmall = model.screenWidth.size == ScreenSize.small;
    return Row(children: <Widget>[
      const Expanded(
          child: Divider(
        color: Colors.grey,
        indent: AppDimens.dividerIndent * 10,
        endIndent: AppDimens.dividerIndent,
      ),),
      Text(
        'social_network',
        style: isSmall
            ? Theme.of(context).textTheme.subtitle2
            : Theme.of(context).textTheme.subtitle1,
      ),
      const Expanded(
          child: Divider(
        indent: AppDimens.dividerIndent,
        endIndent: AppDimens.dividerIndent * 10,
        color: Colors.grey,
      ),),
    ],);
  }
}
