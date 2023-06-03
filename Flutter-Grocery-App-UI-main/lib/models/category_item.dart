class CategoryItem {
  final int? id;
  final String name;
  final String imagePath;

  CategoryItem({this.id, required this.name, required this.imagePath});
}

var categoryItemsDemo = [
  CategoryItem(
    name: "Sayur-mayur",
    imagePath: "assets/images/barang_jualan/_katalog-sayur.png",
  ),
  CategoryItem(
    name: "Buah-buahan",
    imagePath: "assets/images/barang_jualan/_katalog-buah.png",
  ),
];
