import 'package:ancorio_rp/presentation/features/authentication/auth.dart';
import 'package:ancorio_rp/presentation/features/screen/screen_model.dart';
import 'package:ancorio_rp/presentation/features/screen/screen_view.dart';
import 'package:ancorio_rp/presentation/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Screen extends StatefulWidget {
  Screen({required this.isAuth});

  final bool isAuth;

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> implements ScreenView {
  @override
  void pushAuthPage() {
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => Auth()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScreenSize screenSize = getScreenSizeByWidth(context);
    final bool isLarge = screenSize == ScreenSize.large;
    return ChangeNotifierProvider(
      create: (BuildContext context) => ScreenModel(this),
      child: Consumer<ScreenModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                isLarge
                    ? "I Анкорио-RP I Role Play Minecraft server"
                    : 'I Анкорио-RP I Role Play\nMinecraft server',
                style: const TextStyle(fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: RawScrollbar(
              thumbColor: const Color(0xFF1667CB),
              isAlwaysShown: true,
              radius: const Radius.circular(20),
              thickness: 5,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: widget.isAuth
                            ? model.onLogoutPressed
                            : model.onLoginPressed,
                        child: Text(widget.isAuth ? 'Log out' : 'Log in'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            backgroundColor: Colors.blue,
                            onPressed: model.onVkPressed,
                            child: Image.asset(
                              'assets/images/vk.png',
                            ),
                          ),
                          FloatingActionButton(
                            backgroundColor: Colors.red,
                            onPressed: model.onYouTubePressed,
                            child: SvgPicture.asset(
                              'assets/images/YouTube.svg',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text(
                            'Сервер по майнкрафту',
                            style: TextStyle(
                              fontSize: 45.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
