import 'package:ancorio_rp/presentation/features/screen/screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenModel with ChangeNotifier {
  ScreenModel(this._screenView);

  final ScreenView _screenView;

  Future<void> onVkPressed() async {
    await canLaunch('https://vk.com/ancorio')
        ? await launch('https://vk.com/ancorio')
        : _screenView.displayMessage('cannot open vk');
  }
}
