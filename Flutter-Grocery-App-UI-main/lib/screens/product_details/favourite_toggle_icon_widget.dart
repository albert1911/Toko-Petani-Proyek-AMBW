import 'package:flutter/material.dart';
import 'package:grocery_app/models/grocery_item.dart';

class FavoriteToggleIcon extends StatefulWidget {
  const FavoriteToggleIcon(
      {Key? key, required this.productName})
      : super(key: key);
  final String productName;
  @override
  _FavoriteToggleIconState createState() => _FavoriteToggleIconState();
}

class _FavoriteToggleIconState extends State<FavoriteToggleIcon> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          favorite = !favorite;

        });
       if(!favorite){
          favoriteItems.add(widget.productName);
       }else{
            favoriteItems.removeWhere((element) => element==widget.productName);
       }
        
      },
      child: Icon(
        favorite ? Icons.favorite : Icons.favorite_border,
        color: favorite ? Colors.red : Colors.blueGrey,
        size: 30,
      ),
    );
  }
}
