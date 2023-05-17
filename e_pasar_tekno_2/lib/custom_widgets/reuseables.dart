import 'package:e_pasar_tekno_2/screens/account.dart';
import 'package:e_pasar_tekno_2/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/home.dart';

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
