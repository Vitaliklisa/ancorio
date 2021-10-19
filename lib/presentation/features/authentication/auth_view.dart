import 'package:flutter/widgets.dart';

abstract class AuthView {
  void pushHomePage();

  void displayMessage(String message);

  MediaQueryData get mediaData;
}
