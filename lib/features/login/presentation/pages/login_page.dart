import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/features/login/presentation/bloc/login_bloc.dart';
import 'package:shop_demo/features/shop_home/presentation/pages/shop_home_page.dart';
import 'package:shop_demo/providers.dart';

import '../widgets/login_page_circle.dart';
import '../widgets/login_page_title.dart';
import '../widgets/login_status_dialog.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with SingleTickerProviderStateMixin {
  String username = "";
  String password = "";
  late AnimationController _animationController;
  late Animation<double> circlePositionRate;
  late Animation<double> titlePositionRate;
  late Animation<double> textFieldPositionRate;
  late Animation<double> buttonPositionRate;

  Animation<double> _generatePositionRate(
      double begin, double end, double? rate) {
    double? _rate = rate;
    if (rate == null) {
      _rate = 0.1;
    }
    return Tween<double>(begin: _rate, end: 0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(begin, end, curve: Curves.easeIn)));
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    circlePositionRate = _generatePositionRate(0.1, 0.5, 0.1);
    titlePositionRate = _generatePositionRate(0.2, 0.4, 0.01);
    textFieldPositionRate = _generatePositionRate(0.3, 0.5, 0.01);
    buttonPositionRate = _generatePositionRate(0.4, 0.6, 0.01);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          FittedBox(
            fit: BoxFit.fill,
            child: Opacity(
                opacity: 0.10,
                child: Image.asset(
                  "assets/images/login.jpg",
                )),
          ),
          LoginPageCircle(
              circlePositionRate: circlePositionRate,
              size: _size,
              animationController: _animationController),
          LoginPageTitle(
              titlePositionRate: titlePositionRate,
              size: _size,
              animationController: _animationController),
          AnimatedBuilder(
            animation: textFieldPositionRate,
            builder: (context, child) {
              return Positioned(
                right: _size.width * 0.06,
                top: _size.height * (0.30 + textFieldPositionRate.value),
                child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(0.3, 0.5,
                                curve: Curves.easeIn))),
                    child: child),
              );
            },
            child: Container(
              width: _size.width * 0.8,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  TextField(
                      decoration: const InputDecoration(
                          hintText: "Email",
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          border: InputBorder.none),
                      onChanged: ((value) => username = value)),
                  const Divider(thickness: 2.0),
                  TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          border: InputBorder.none),
                      onChanged: (value) => password = value),
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: buttonPositionRate,
            builder: (context, child) {
              return Positioned(
                left: _size.width * 0.14,
                top: _size.height * (0.47 + buttonPositionRate.value),
                child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(0.4, 0.6,
                                curve: Curves.easeIn))),
                    child: child),
              );
            },
            child: SizedBox(
              width: _size.width * 0.45,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () async {
                    final result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          if (username == "" || password == "") {
                            return LoginStatusDialog(
                                title: "Error",
                                message:
                                    "Please enter your username and password");
                          }
                          return BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginSuccess) {
                                Navigator.pop(context, true);
                              }
                              if (state is LoginFailure) {
                                return LoginStatusDialog(
                                    title: "Error", message: state.message);
                              }
                              return const LoginStatusDialog(
                                  title: "Processing", processing: true);
                            },
                            bloc: ref.watch<LoginBloc>(loginBloc)
                              ..add(LogInEvent(username, password)),
                          );
                        });
                    if (result == true) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ShopHomePage(
                                    parameters: {"id": 1, "getAll": true},
                                  )),
                          (route) => false);
                    }
                  },
                  child: const Text("Sign in")),
            ),
          )
        ],
      ),
    );
  }
}
