import 'package:ancorio_rp/di/locator.dart';
import 'package:ancorio_rp/domain/usecases/account_use_cases.dart';
import 'package:ancorio_rp/presentation/features/authentication/auth_view.dart';
import 'package:ancorio_rp/presentation/utils/screen_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthModel with ChangeNotifier {
  AuthModel(this._view) {
    initView();
  }

  final AuthView _view;
  final AccountUseCases _accountUseCases = locator<AccountUseCases>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  double _screenWidth = double.maxFinite;

  double get screenWidth => _screenWidth;

  bool _isPortrait = true;

  bool get isPortrait => _isPortrait;

  /// returns null if device is a phone, which makes width as wide as screen,
  /// and makes some horizontal paddings if device is not a phone
  double? get contentWidth {
    if (_screenWidth.size == ScreenSize.large) {
      if (_isPortrait) {
        return _screenWidth * 0.8;
      } else {
        return _screenWidth * 0.52;
      }
    }
  }

  void initView() {
    final MediaQueryData mediaData = _view.mediaData;
    _screenWidth = mediaData.size.width;
    _isPortrait = mediaData.orientation == Orientation.portrait;
  }

  Future<void> onGoogleIconPressed() async {
    _isLoading = true;
    notifyListeners();

    await _accountUseCases.signInWithGoogle().catchError((error) {
      _isLoading = false;
      notifyListeners();
    });

    await _finishAuthentication();
  }

  Future<void> _finishAuthentication() async {
    if (FirebaseAuth.instance.currentUser != null) {
      // navigating to home page
      _view.pushHomePage();
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }
}
