import 'package:e_pasar_tekno_2/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom_widgets.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(),
      body: CustomButton(
          btnText: "LOG OUT",
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) {
              debugPrint("Signed out!");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            }).onError((error, stackTrace) {
              debugPrint("Error: ${error.toString()}");
            });
          }),
      bottomNavigationBar: bottomBar(context, "Account"),
    );
  }
}
