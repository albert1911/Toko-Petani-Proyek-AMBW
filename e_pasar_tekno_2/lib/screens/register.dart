import 'package:e_pasar_tekno_2/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../model/user.dart';
import '../custom_widgets.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String errorMessage = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title = "Registrasi";
    String subtitle = "Buat akun baru";

    Widget content = Column(
      children: [
        basicTextField('Nama', nameController, false),
        const SizedBox(height: 12.0),
        basicTextField("Email", emailController, false),
        const SizedBox(height: 12.0),
        basicTextField("Password", passController, true),
        const SizedBox(height: 25),
        CustomButton(
            btnText: "Daftar", onTap: () => createUserWithEmailAndPassword()),
      ],
    );

    Widget subcontent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Sudah punya akun?"),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
          },
          child: const Text(" Masuk disini",
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
      message: errorMessage,
      content: content,
      subcontent: subcontent,
      isError: true,
    );
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passController.text)
          .then((UserCredential userCredential) async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Login(isError: false)));

        // CREATE USER
        String userId = userCredential.user!.uid; // ID of authenticated user
        final docUser = FirebaseFirestore.instance.collection('users').doc();
        final user = MyUser(
            id: docUser.id,
            username: nameController.text,
            address: '',
            authId: userId);
        await docUser.set(user.toJson());
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }
}
