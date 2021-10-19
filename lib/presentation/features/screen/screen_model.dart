import 'package:ancorio_rp/presentation/features/screen/screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenModel with ChangeNotifier {
  ScreenModel(this._screenView);

  final ScreenView _screenView;
  Future<void> onLogoutPressed()  async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
  void onLoginPressed()  {
    _screenView.pushAuthPage();
  }
  Future<void> onVkPressed() async {
    await canLaunch('https://vk.com/ancorio')
        ? await launch('https://vk.com/ancorio')
        : _screenView.displayMessage('cannot open vk');
  }

  Future<void> onYouTubePressed() async {
    await canLaunch('https://www.youtube.com/c/NiceArchitectureRostislawZ')
        ? await launch('https://www.youtube.com/c/NiceArchitectureRostislawZ')
        : _screenView.displayMessage('cannot open youtube');
  }
}
