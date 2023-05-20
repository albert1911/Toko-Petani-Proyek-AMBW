import 'package:e_pasar_tekno_2/screens/account.dart';
import 'package:e_pasar_tekno_2/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home.dart';

AppBar topBar() {
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
    automaticallyImplyLeading: false, // Removes back button
    centerTitle: true,
  );
}

Container bottomBar(BuildContext context, String currentPage) {
  var isHomePage = false, isCartPage = false, isAccountPage = false;

  switch (currentPage) {
    case "Home":
      {
        isHomePage = true;
      }
      break;
    case "Cart":
      {
        isCartPage = true;
      }
      break;
    case "Account":
      {
        isAccountPage = true;
      }
      break;

    default:
  }
  return Container(
    height: 64,
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(
          color: Colors.grey, // Set the color of the border here
          width: 1.0, // Set the width of the border here
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          enableFeedback: false,
          onPressed: () {
            if (!isHomePage) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            }
          },
          icon: Icon(
            Icons.home,
            color: isHomePage ? Colors.yellow : Colors.black,
            size: 35,
          ),
        ),
        IconButton(
          enableFeedback: false,
          onPressed: () {
            if (!isCartPage) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cart()),
              );
            }
          },
          icon: Icon(
            Icons.shopping_cart,
            color: isCartPage ? Colors.yellow : Colors.black,
            size: 35,
          ),
        ),
        IconButton(
          enableFeedback: false,
          onPressed: () {
            if (!isAccountPage) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Account()),
              );
            }
          },
          icon: Icon(
            Icons.person,
            color: isAccountPage ? Colors.yellow : Colors.black,
            size: 35,
          ),
        ),
      ],
    ),
  );
}

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

class CustomButton extends StatelessWidget {
  const CustomButton({
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

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.message,
    required this.content,
    required this.subcontent,
    required this.isError,
  });

  final String title;
  final String subtitle;
  final String message;
  final Widget content;
  final Widget subcontent;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    TextStyle errorStyle = GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: isError ? Colors.red : Colors.green,
    );

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 0, bottom: 0, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(subtitle),
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
                    child: content),
              ),
            ),
            const SizedBox(height: 25),
            subcontent,
            const SizedBox(height: 15),
            Text(message, style: errorStyle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
