import 'package:ancorio_rp/presentation/features/screen/screen_model.dart';
import 'package:ancorio_rp/presentation/features/screen/screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> implements ScreenView {
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
    return ChangeNotifierProvider(
      create: (BuildContext context) => ScreenModel(this),
      child: Consumer<ScreenModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(backgroundColor: Colors.blue,
              title: const Text(
                "I Анкорио-RP I Role Play Minecraft server",
                style: TextStyle(
                  fontSize: 30.0,
                ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            backgroundColor: Colors.blue,
                            onPressed: model.onVkPressed,
                            child: Image.asset(
                              'assets/images/vk.png',

                            ),
                          )
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
