import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';

import '../../models/merchant.dart';
import '../category_items_screen.dart';
import 'grocery_featured_Item_widget.dart';
// import 'home_banner_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool shouldFetchData = true;
  bool isFiltered = false;
  String searchedKeyword = "";
  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  @override
  Widget build(BuildContext context) {
    // FETCH DATA FROM PRODUCTS TABLE
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: shouldFetchData
          ? FirebaseFirestore.instance.collection('products').snapshots()
          : null, // Pass null to disable the stream
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Loading...'));
        }

        final List<DocumentSnapshot<Map<String, dynamic>>> documents =
            snapshot.data?.docs ?? [];

        // Clear the existing lists
        itemsSayur.clear();
        itemsBuah.clear();

        documents.forEach((document) {
          final Map<String, dynamic>? data = document.data();
          String locationNames =
              List<String>.from(data!['stock']['id-merchant'])
                  .map((id) => getLocationName(id))
                  .join(',\n');
          List<dynamic> stockAmountList =
              List<dynamic>.from(data['stock']['stock-amount']);
          stockAmountList.removeWhere((element) => element == 0);

          // Create a GroceryItem object using the fetched data

          final GroceryItem item = GroceryItem(
            id: int.parse(document.id),
            name: data['name'],
            price: double.parse(data['price'].toString()),
            description: data['quantity'] +
                ", Total stok: " +
                List<dynamic>.from(data['stock']['stock-amount'])
                    .map((string) => string)
                    .toList()
                    .reduce((value, element) => value + element)
                    .toString() +
                "\n$locationNames",
            quantity: data['quantity'],
            imagePath: "assets/images/barang_jualan/" + data['name'] + ".jpg",
            details: Stock(
              merchantIds: List<String>.from(data['stock']['id-merchant']),
              stockAmounts: stockAmountList,
            ),
            type: data['type'],
          );

          if (data['type'] == 'sayur') {
            itemsSayur.add(item);
          } else if (data['type'] == 'buah') {
            itemsBuah.add(item);
          }
        });

        // FETCH DATA FROM MERCHANTS TABLE
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: shouldFetchData
                ? FirebaseFirestore.instance.collection('merchants').snapshots()
                : null, // Pass null to disable the stream
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    merchantSnapshot) {
              if (merchantSnapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (merchantSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Loading...'));
              }

              final List<DocumentSnapshot<Map<String, dynamic>>>
                  merchantDocuments = merchantSnapshot.data?.docs ?? [];

              // Clear previous list to avoid duplicate data
              if (shouldFetchData) {
                daftarToko.clear();
              }

              merchantDocuments.forEach((merchantDocument) {
                final Map<String, dynamic>? merchantData =
                    merchantDocument.data();

                // Create a Toko object using the fetched data
                final Toko toko = Toko(
                  id: merchantDocument.id,
                  nama: merchantData!['nama'],
                  alamat: merchantData['alamat'],
                );

                // Add the Toko object to the list
                daftarToko.add(toko);
              });

              return Scaffold(
                body: SafeArea(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                icon(),
                                SizedBox(
                                  width: 25,
                                ),
                                AppText(
                                  text: "E-PASAR: \nBuah & Sayur",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2A881E),
                                  glowColor: Color(0xFFA8FF8D),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            padded(SearchBarWidget(
                                updateIsFiltered: updateIsFiltered)),
                            SizedBox(
                              height: 25,
                            ),
                            if (!isFiltered)
                              Column(
                                children: [
                                  padded(subTitle("Daftar Katalog", false)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 105,
                                    child: ListView(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () => {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return CategoryItemsScreen(
                                                      productType:
                                                          "Buah-buahan");
                                                },
                                              ),
                                            ),
                                          },
                                          child: GroceryFeaturedCard(
                                            groceryFeaturedItems[0],
                                            color: Color(0xffF8A44C),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () => {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return CategoryItemsScreen(
                                                      productType:
                                                          "Sayur-mayur");
                                                },
                                              ),
                                            ),
                                          },
                                          child: GroceryFeaturedCard(
                                            groceryFeaturedItems[1],
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  padded(subTitle("Buah-buahan", true)),
                                  getHorizontalItemSlider(itemsBuah),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  padded(subTitle("Sayur-mayur", true)),
                                  getHorizontalItemSlider(itemsSayur),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  padded(subTitle(
                                      "Hasil Pencarian '$searchedKeyword'",
                                      false)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SingleChildScrollView(
                                    child: StaggeredGrid.count(
                                      crossAxisCount: 2,
                                      children: filteredItems
                                          .asMap()
                                          .entries
                                          .map<Widget>((e) {
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
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider(List<GroceryItem> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 300,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]);
            },
            child: GroceryItemCardWidget(
              item: items[index],
              heroSuffix: "home_screen",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      ),
    );
  }

  void updateIsFiltered(bool value, String keyword) {
    setState(() {
      isFiltered = value;
      searchedKeyword = keyword;
    });
    print("cek 123: " + keyword);
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
                groceryItem,
                heroSuffix: "home_screen",
              )),
    );
  }

  Widget subTitle(String text, bool showSeeAll) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        if (showSeeAll)
          GestureDetector(
            onTap: () => {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoryItemsScreen(productType: text);
                },
              )),
            },
            child: Text(
              "See All",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
          ),
      ],
    );
  }

  Widget icon() {
    String iconPath = "assets/icons/_app_icon.svg";
    return Container(
      width: 50,
      height: 50,
      child: SvgPicture.asset(
        iconPath,
        width: 96,
        height: 96,
      ),
    );
  }
}
