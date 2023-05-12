import 'package:flutter/material.dart';

import '../custom_widgets/main_button.dart';
import '../custom_widgets/reuseables.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBarKu(),
      body: Container(
        margin: const EdgeInsets.only(top: 50, bottom: 25, left: 30, right: 30),
        child: Column(
          children: [
            const Text(
              "Selamat Datang!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text("Masuk menggunakan Username & Password"),
            const SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(1, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 25, bottom: 25, left: 25, right: 25),
                  child: Column(
                    children: [
                      basicTextField('Username', userController, false),
                      const SizedBox(height: 12.0),
                      basicTextField("Password", passController, true),
                      const SizedBox(height: 25),
                      MainButton(
                          btnText: "Masuk", onTap: () => debugPrint('temp')),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text("Belum punya akun? Daftar disini"),
          ],
        ),
      ),
    );
  }
}
