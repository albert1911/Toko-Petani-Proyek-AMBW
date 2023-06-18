import 'package:shared_preferences/shared_preferences.dart';

class GroceryItem {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final String quantity;

  final Stock? details;
  final String? type;

  GroceryItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.quantity,
    this.details,
    this.type,
  });
}

class Stock {
  final List<String> merchantIds;
  final List<String> stockAmounts;

  Stock({
    required this.merchantIds,
    required this.stockAmounts,
  });
}

var demoItems = [
  GroceryItem(
      id: 1,
      name: "Organic Bananas",
      description: "7pcs, Priceg",
      price: 4.99,
      imagePath: "assets/images/grocery_images/banana.png",
      quantity: "-/sisir",
      details: Stock(merchantIds: ["1", "2"], stockAmounts: ["5", "5"]),
      type: "buah"),
  GroceryItem(
      id: 2,
      name: "Red Apple",
      description: "1kg, Priceg",
      price: 4.99,
      imagePath: "assets/images/grocery_images/apple.png",
      quantity: "-/1kg",
      details: Stock(merchantIds: ["2", "3"], stockAmounts: ["4", "7"]),
      type: "buah"),
  GroceryItem(
      id: 3,
      name: "Bell Pepper Red",
      description: "1kg, Priceg",
      price: 4.99,
      imagePath: "assets/images/grocery_images/pepper.png",
      quantity: "-/1kg",
      details: Stock(merchantIds: ["1", "3"], stockAmounts: ["3", "2"]),
      type: "sayur"),
  GroceryItem(
      id: 4,
      name: "Fresh Tomato",
      description: "1kg, Priceg",
      price: 4.99,
      imagePath: "assets/images/grocery_images/beef.png",
      quantity: "-/buah",
      details: Stock(merchantIds: ["1", "3"], stockAmounts: ["3", "2"]),
      type: "sayur"),
];

var exclusiveOffers = [demoItems[0], demoItems[1]];
var bestSelling = [demoItems[2], demoItems[3]];
var groceries = [demoItems[4], demoItems[5]];
var beverages = demoItems;

var unknownProduct = GroceryItem(
    name: "Unknown",
    description: "description",
    price: 0,
    imagePath: "assets/images/barang_jualan/unknown.jpg",
    quantity: "quantity");

final List<GroceryItem> itemsSayur = [];
final List<GroceryItem> itemsBuah = [];
List<GroceryItem> filteredItems = [];

List<String> favoriteItems = [];

Future<void> saveFavorite() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('favorite', favoriteItems);

  print(favoriteItems);
}

Future<List<String>> loadFavorite() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    List<String>? loadedFavoriteItems = prefs.getStringList('favorite');
    if (loadedFavoriteItems != null) {
      return loadedFavoriteItems;
    }
  } catch (e) {
    print("Error loading favorite: $e");
  }

  return [];
}
