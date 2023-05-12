import 'package:flutter/material.dart';

import '../custom_widgets/main_button.dart';
import '../custom_widgets/reuseables.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController tempController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBarKu(),
      body: Container(
        margin: const EdgeInsets.only(top: 0, bottom: 0, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Registrasi",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text("Buat akun baru"),
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
                      basicTextField('Nama', tempController, false),
                      const SizedBox(height: 12.0),
                      basicTextField("Email", tempController, false),
                      const SizedBox(height: 12.0),
                      basicTextField("Password", tempController, true),
                      const SizedBox(height: 25),
                      MainButton(
                          btnText: "Daftar", onTap: () => debugPrint('temp')),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text("Sudah punya akun? Masuk disini"),
          ],
        ),
      ),
    );
  }
}
