import 'package:ancorio_rp/presentation/features/screen/screen.dart';
import 'package:ancorio_rp/values/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AncorioRpApp extends StatefulWidget {
  @override
  State<AncorioRpApp> createState() => _AncorioRpAppState();
}

class _AncorioRpAppState extends State<AncorioRpApp> {
  @override
  Widget build(BuildContext context) {
    final WidgetsBinding? _widgetsBinding = WidgetsBinding.instance;
    return MaterialApp(
      title: 'AncorioRp',
      theme: ThemeData(primarySwatch: AppColors.primarySwatch),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Screen(isAuth: true);
          } else if (snapshot.hasError) {
            _widgetsBinding?.addPostFrameCallback((callback) {
              return _displayError(context, snapshot.error.toString());
            });
            return const SizedBox();
          }
          //В это случий пользиватель не зарегестрирован
          return Screen(isAuth: false);
        },
      ),
    );
  }

  void _displayError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
