import 'dart:async';
import 'package:flutter/material.dart';
import 'package:typing_text_animation/typing_text_animation.dart';
import '../../constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/Elenden.png')),
            Text('W E L C O M E',style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 10),
            TypingTextAnimation(
              texts: ["Manage your transactions with ease!"],
              textStyle: TextStyle(color: Colors.white, fontSize: 20.0),
              showCursor: true,
            ),
          ],
        ),
      ),
    );
  }
}
