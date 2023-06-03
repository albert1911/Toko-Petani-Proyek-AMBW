import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/screens/account/register_screen.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/_app_text_field.dart';
import '../../widgets/_custom_button.dart';
import '../../widgets/_custom_container.dart';
import '_user_provider.dart';

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

    if (!isError) {
      errorMessage = "Akan anda berhasil dibuat.";
    }

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
      appBarTitle: "Silahkan Lakukan Login",
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      final user = userCredential.user;

      if (user != null) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUserEmail(user.email);
        userProvider.setUserName();

        setState(() {
          errorMessage = '';
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        // errorMessage = e.message!;
        errorMessage = e.code;
      });
    }
  }
}
