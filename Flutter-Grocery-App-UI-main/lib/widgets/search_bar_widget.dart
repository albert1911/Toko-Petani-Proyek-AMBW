import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatefulWidget {
  final String searchIcon = "assets/icons/search_icon.svg";

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
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search Store",
          hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7C7C7C),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(end: 18.0),
            child: SvgPicture.asset(widget.searchIcon),
          ),
        ),
        onChanged: (searchText) {
          // Filter the dataList based on the search text and perform further actions
          // List<String> filteredList = dataList
          //     .where((item) =>
          //         item.toLowerCase().contains(searchText.toLowerCase()))
          //     .toList();

          // Do something with the filteredList
          // print(filteredList);
        },
      ),
    );
  }
}
