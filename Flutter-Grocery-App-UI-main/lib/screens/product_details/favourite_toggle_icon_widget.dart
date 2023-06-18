import 'package:flutter/material.dart';
import 'package:grocery_app/models/grocery_item.dart';

class FavoriteToggleIcon extends StatefulWidget {
  const FavoriteToggleIcon({Key? key, required this.productName})
      : super(key: key);
  final String productName;
  @override
  _FavoriteToggleIconState createState() => _FavoriteToggleIconState();
}

class _FavoriteToggleIconState extends State<FavoriteToggleIcon> {
  bool favorite = false;

  @override
  void initState() {
    super.initState();

    loadFavoriteData();
  }

  Future<void> loadFavoriteData() async {
    if (favoriteItems.isEmpty) {
      List<String> loadedFavoriteItems = await loadFavorite();
      setState(() {
        favoriteItems = loadedFavoriteItems;
      });
    }

    if (favoriteItems.contains(widget.productName)) {
      setState(() {
        favorite = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (favoriteItems.contains(widget.productName)) {
          print("cek123 toggle");
        }

        if (!favorite) {
          favoriteItems.add(widget.productName);
          debugPrint("cek123: " + favoriteItems[0]);
        } else {
          favoriteItems.removeWhere((element) => element == widget.productName);
          debugPrint("cek123: unfavorite");
        }

        setState(() {
          favorite = !favorite;
        });

        saveFavorite();
        print(favoriteItems);
      },
      child: Icon(
        favorite ? Icons.favorite : Icons.favorite_border,
        color: favorite ? Colors.red : Colors.blueGrey,
        size: 30,
      ),
    );
  }
}
