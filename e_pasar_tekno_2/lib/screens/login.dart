import 'package:e_pasar_tekno_2/screens/home.dart';
import 'package:e_pasar_tekno_2/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom_widgets.dart';

class Login extends StatefulWidget {
  final bool? isError;
  const Login({super.key, this.isError});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String errorMessage = '';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title = "Selamat Datang!";
    String subtitle = "Masuk menggunakan Username & Password";
    bool? isError = widget.isError ?? true;

    Widget content = Column(
      children: [
        basicTextField('Email', emailController, false),
        const SizedBox(height: 12.0),
        basicTextField("Password", passController, true),
        const SizedBox(height: 25),
        CustomButton(
            btnText: "Masuk", onTap: () => signInWithEmailAndPassword()),
      ],
    );

    Widget subcontent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Belum punya akun?"),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Register()));
          },
          child: const Text(" Daftar disini",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromRGBO(0, 0, 255, 1),
              )),
        ),
      ],
    );

    return CustomContainer(
      title: title,
      subtitle: subtitle,
      content: content,
      subcontent: subcontent,
      message: errorMessage,
      isError: isError,
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passController.text)
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home())));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }
}
