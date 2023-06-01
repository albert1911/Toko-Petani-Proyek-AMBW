import 'package:flutter/material.dart';
import 'package:grocery_app/screens/account/_user_provider.dart';
import 'package:grocery_app/screens/splash_screen.dart';
import 'package:grocery_app/styles/theme.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
      child: MaterialApp(
        theme: themeData,
        home: SplashScreen(),
      ),
    );
  }
}
