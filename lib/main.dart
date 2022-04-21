import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shop_demo/features/login/presentation/pages/login_page.dart';
import 'package:shop_demo/features/shop_home/data/datasources/product_remote_data_source.dart';
import 'package:shop_demo/features/shop_home/data/datasources/user_remote_data_source.dart';
import 'package:shop_demo/features/shop_home/data/repositories/product_data_repository_impl.dart';
import 'package:shop_demo/features/shop_home/domain/repositories/user_data_repository.dart';
import 'package:shop_demo/features/shop_home/presentation/bloc/product_bloc/shop_home_bloc.dart';
import 'package:shop_demo/features/shop_home/presentation/pages/shop_home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
