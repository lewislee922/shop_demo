import 'package:flutter/material.dart';

class LoginPageTitle extends StatelessWidget {
  const LoginPageTitle({
    Key? key,
    required this.titlePositionRate,
    required Size size,
    required AnimationController animationController,
  })  : _size = size,
        _animationController = animationController,
        super(key: key);

  final Animation<double> titlePositionRate;
  final Size _size;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: titlePositionRate,
      builder: (context, child) {
        return Positioned(
          left: _size.width * 0.05,
          top: _size.height * (0.15 - titlePositionRate.value),
          child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.2, 0.4, curve: Curves.easeIn))),
              child: child),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Sign In",
            style: TextStyle(fontSize: 36.0, color: Colors.white),
          ),
          SizedBox(height: 16),
          Text(
            "Sign in with your email and password",
            style: TextStyle(fontSize: 13.0, color: Colors.white),
          )
        ],
      ),
    );
  }
}
