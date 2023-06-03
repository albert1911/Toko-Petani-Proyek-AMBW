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

class Toko {
  final int id;
  final String name;
  final String alamat;

  Toko({
    required this.id,
    required this.name,
    required this.alamat,
  });
}

// List temporary digunakan agar akses ke database tidak kena limit saat melakukan debugging
var daftarToko = [
  Toko(id: 1, name: "Pasar Mekar", alamat: "Jl. Semar 234"),
  Toko(id: 2, name: "Jaya Makmur", alamat: "Jl. Merdeka 123"),
  Toko(id: 3, name: "Pasar Enam Juni", alamat: "Jl. Pancasila 36"),
];

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
  // GroceryItem(
  //   id: 4,
  //   name: "Ginger",
  //   description: "250gm, Priceg",
  //   price: 4.99,
  //   imagePath: "assets/images/grocery_images/ginger.png",
  // ),
  // GroceryItem(
  //   id: 5,
  //   name: "Meat",
  //   description: "250gm, Priceg",
  //   price: 4.99,
  //   imagePath: "assets/images/grocery_images/beef.png",
  // ),
  // GroceryItem(
  //   id: 6,
  //   name: "Chikken",
  //   description: "250gm, Priceg",
  //   price: 4.99,
  //   imagePath: "assets/images/grocery_images/chicken.png",
  // ),
];

var exclusiveOffers = [demoItems[0], demoItems[1]];
var bestSelling = [demoItems[2], demoItems[3]];
var groceries = [demoItems[4], demoItems[5]];
var beverages = demoItems;

final List<GroceryItem> itemsSayur = [];
final List<GroceryItem> itemsBuah = [];

String getLocationName(String locationId) {
  Toko? selectedToko = daftarToko.firstWhere(
    (toko) => toko.id == int.parse(locationId),
    orElse: () => Toko(id: 0, name: "Unknown", alamat: ""),
  );

  return selectedToko.name;
}