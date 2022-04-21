import 'package:flutter/material.dart';

class LoginPageCircle extends StatelessWidget {
  const LoginPageCircle({
    Key? key,
    required this.circlePositionRate,
    required Size size,
    required AnimationController animationController,
  })  : _size = size,
        _animationController = animationController,
        super(key: key);

  final Animation<double> circlePositionRate;
  final Size _size;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: circlePositionRate,
      builder: (context, child) {
        return Positioned(
          left: -_size.height * (0.43 + circlePositionRate.value),
          top: -_size.height * 0.06,
          child: FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0.1, 0.5, curve: Curves.easeIn))),
              child: child),
        );
      },
      child: Container(
        height: _size.height * 0.8,
        width: _size.height * 0.8,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 73, 80, 243),
                Color.fromARGB(255, 73, 50, 243),
                Color.fromARGB(255, 73, 30, 243)
              ]),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
