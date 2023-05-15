import 'package:flutter/material.dart';

import '../custom_widgets/main_button.dart';
import '../custom_widgets/reuseables.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
