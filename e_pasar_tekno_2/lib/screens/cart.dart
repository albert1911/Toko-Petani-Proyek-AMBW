import 'package:flutter/material.dart';

import '../custom_widgets.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(),
      body: Container(
        // DISINI TEMPAT MASUKIN KE SCREEN
        child: const Text("cart.dart"),
      ),
      bottomNavigationBar: bottomBar(context, "Cart"),
    );
  }
}
