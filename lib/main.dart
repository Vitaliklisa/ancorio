import 'package:ancorio_rp/di/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'ancorio_rp_app.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /// init firebase
  await Firebase.initializeApp();

  /// init dependency injection
  setupLocatorUseCases();
  setupLocatorRepositories();

  /// start project
  runApp(AncorioRpApp());
}
