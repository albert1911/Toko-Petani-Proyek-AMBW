import 'package:e_pasar_tekno_2/screens/home.dart';
import 'package:e_pasar_tekno_2/screens/register.dart';
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
      body: Container(
        margin: const EdgeInsets.only(top: 0, bottom: 0, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                          btnText: "Masuk",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()));
                          }),
                      const Text(
                          "Sementara button diklik bisa langsung masuk Home Screen."),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text("Belum punya akun?"),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Register()));
              },
              child: const Text("Daftar disini",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromRGBO(0, 0, 255, 1),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
