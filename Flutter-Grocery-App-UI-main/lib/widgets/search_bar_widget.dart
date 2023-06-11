import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/grocery_item.dart';

class SearchBarWidget extends StatefulWidget {
  final String searchIcon = "assets/icons/search_icon.svg";
  final Function(bool, String) updateIsFiltered;

  SearchBarWidget({Key? key, required this.updateIsFiltered}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Cari Produk",
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C7C7C),
                ),
              ),
              onSubmitted: (searchText) {
                if (_searchController.text != "") {
                  filterItems(_searchController.text);
                } else {
                  filteredItems = [];
                  widget.updateIsFiltered(filteredItems.isNotEmpty, "");
                }
              },
            ),
          ),
          IconButton(
            onPressed: () {
              if (_searchController.text != "") {
                filterItems(_searchController.text);
              } else {
                filteredItems = [];
                widget.updateIsFiltered(filteredItems.isNotEmpty, "");
              }
            },
            icon: SvgPicture.asset(widget.searchIcon),
          ),
        ],
      ),
    );
  }

  void filterItems(String searchText) {
    setState(() {
      filteredItems = [];
      filteredItems.addAll(itemsSayur.where((item) =>
          item.name.toLowerCase().contains(searchText.toLowerCase())));
      filteredItems.addAll(itemsBuah.where((item) =>
          item.name.toLowerCase().contains(searchText.toLowerCase())));
      widget.updateIsFiltered(filteredItems.isNotEmpty, searchText);
    });
  }
}
