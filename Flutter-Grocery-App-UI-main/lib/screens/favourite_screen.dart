import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';

import '../models/grocery_item.dart';
import '../widgets/grocery_item_card_widget.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isFavoriteEmpty = true;

  @override
  void initState() {
    super.initState();
    loadFavoriteItems();
  }

  Future<void> loadFavoriteItems() async {
    List<String> loadedFavoriteItems = await loadFavorite();
    setState(() {
      favoriteItems = loadedFavoriteItems;
      if (favoriteItems.isNotEmpty) {
        isFavoriteEmpty = false;
      } else {
        isFavoriteEmpty = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "Produk Favorit",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              isFavoriteEmpty
                  ? Container(
                      child: Center(
                        child: AppText(
                          text: "No Favorite Items",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7C7C7C),
                        ),
                      ),
                    )
                  : itemsFavorite(context),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemsFavorite(BuildContext context) {
    // Get product by name
    final List<GroceryItem> itemKu = [];

    for (String favoriteItem in favoriteItems) {
      for (GroceryItem sayurItem in itemsSayur) {
        if (sayurItem.name == favoriteItem) {
          itemKu.add(sayurItem);
          print('cek123 Found a matching item: ${sayurItem.name}');
        }
      }

      for (GroceryItem buahItem in itemsBuah) {
        if (buahItem.name == favoriteItem) {
          itemKu.add(buahItem);
          print('cek123 Found a matching item: ${buahItem.name}');
        }
      }
    }

    return SingleChildScrollView(
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        children: itemKu.asMap().entries.map<Widget>((e) {
          GroceryItem groceryItem = e.value;
          return GestureDetector(
            onTap: () {
              onItemClicked(context, groceryItem);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: GroceryItemCardWidget(
                item: groceryItem,
                heroSuffix: "explore_screen",
              ),
            ),
          );
        }).toList(),
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 0.0,
      ),
    );
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          groceryItem,
          heroSuffix: "explore_screen",
        ),
      ),
    );
  }
}
