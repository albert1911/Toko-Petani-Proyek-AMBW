import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextField basicTextField(
    String text, TextEditingController controller, bool isPassword) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
      filled: true,
    ),
    obscureText: isPassword,
  );
}

AppBar appBarKu() {
  TextStyle appTitle = GoogleFonts.inriaSans(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: const Color.fromRGBO(42, 136, 30, 1),
  );

  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 35,
          height: 35,
          child: Image.asset(
            'images/icon.png',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 25),
        Text(
          'E-PASAR',
          style: appTitle,
        ),
      ],
    ),
    backgroundColor: Colors.white,
    elevation: 4.0,
    centerTitle: true,
  );
}
