import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  var colorizeColors = [
    const Color.fromARGB(255, 235, 235, 235),
    Colors.blue,
    Colors.yellow,
    Colors.red,
    const Color.fromARGB(255, 235, 235, 235),
  ];

  var colorizeTextStyle = const TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(141, 58, 229, 1),
              Color.fromRGBO(136, 39, 239, 1),
              Color.fromRGBO(4, 15, 4, 1),
              Color.fromRGBO(4, 15, 4, 1),
              Color.fromRGBO(111, 21, 237, 1),
              Color.fromRGBO(115, 30, 234, 1),
            ],
          )),
          child: Center(
              child: SizedBox(
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText('Splash Screen',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                    speed: const Duration(milliseconds: 200)),
              ],
              isRepeatingAnimation: true,
              repeatForever: true,
              onTap: () {
                print("Tap Event");
              },
            ),
          )),
        ),
      ),
    );
  }
}
