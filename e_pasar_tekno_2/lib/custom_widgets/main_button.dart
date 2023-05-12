import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.btnText,
    required this.onTap,
  });

  final String btnText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    TextStyle btnTitle = GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: const Color.fromRGBO(42, 136, 30, 1),
    );

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          backgroundColor: const Color.fromRGBO(254, 255, 181, 1),
          minimumSize: Size(MediaQuery.of(context).size.width - 110, 50)),
      onPressed: onTap,
      child: Text(
        btnText,
        style: btnTitle,
      ),
    );
  }
}
