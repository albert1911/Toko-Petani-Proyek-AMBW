import 'package:grocery_app/models/grocery_item.dart';

class CartItem {
  final List<String> idProducts;
  final String idMerchant;
  final List<double> quantity;

  CartItem({
    required this.idProducts,
    required this.idMerchant,
    required this.quantity,
  });
}

var cartItems = [
  CartItem(idProducts: ["1", "2"], idMerchant: "1", quantity: [3, 3.5]),
  CartItem(idProducts: ["1"], idMerchant: "2", quantity: [3]),
  CartItem(idProducts: ["2"], idMerchant: "3", quantity: [1.25]),
];

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
