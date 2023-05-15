import 'package:e_pasar_tekno_2/screens/home.dart';
import 'package:e_pasar_tekno_2/screens/login.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/main_button.dart';
import '../custom_widgets/reuseables.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(),
      body: Container(
          // DISINI TEMPAT MASUKIN KE SCREEN
          ),
      bottomNavigationBar: bottomBar(context, "Home"),
    );
  }
}
