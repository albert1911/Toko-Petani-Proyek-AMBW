import 'package:grocery_app/models/grocery_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartItem {
  final List<String> idProducts;
  final String idMerchant;
  final List<double> quantity;

  CartItem({
    required this.idProducts,
    required this.idMerchant,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      idProducts: List<String>.from(json['idProducts']),
      idMerchant: json['idMerchant'],
      quantity: List<double>.from(json['quantity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idProducts': idProducts,
      'idMerchant': idMerchant,
      'quantity': quantity,
    };
  }
}

List<CartItem> cartItems = [];

Future<void> saveCart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> cartItemsJson =
      cartItems.map((item) => item.toJson()).toList();
  String cartItemsString = jsonEncode(cartItemsJson);
  await prefs.setString("cart", cartItemsString);

  print('Data saved successfully.');
}

Future<List<CartItem>> loadCart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? cartItemsString = prefs.getString("cart");
  if (cartItemsString != null) {
    List<dynamic> cartItemsJson = jsonDecode(cartItemsString);
    List<CartItem> loadedCartItems =
        cartItemsJson.map((json) => CartItem.fromJson(json)).toList();
    return loadedCartItems;
  } else {
    return [];
  }
}

Future<void> clearCart() async {
  cartItems.clear();
  saveCart();
}

GroceryItem getGroceryItemById(String id) {
  GroceryItem foundItem = itemsSayur.firstWhere(
      (item) => item.id == int.parse(id),
      orElse: () => unknownProduct);

  if (foundItem == unknownProduct) {
    foundItem = itemsBuah.firstWhere((item) => item.id == int.parse(id),
        orElse: () => unknownProduct);
  }

  return foundItem;
}
