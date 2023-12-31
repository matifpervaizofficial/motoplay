// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:motplay/screens/dashboard.dart';
import 'package:motplay/utils/custom_appbar.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Set the duration of the fade animation
    );

    // Navigate to the next screen after the animation is complete
    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, Dashboard.routeName);
      }
    });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);

    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromRGBO(0, 87, 150, 1) , Color.fromRGBO(255, 107, 0, 1) ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: _animation!,
              child: Image.asset("assets/images/logo.png")
            ),
          ),
        ),
      ),
    );
  }
}