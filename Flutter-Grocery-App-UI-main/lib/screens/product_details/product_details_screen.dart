import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/widgets/item_counter_widget.dart';

import '_edit_data_dialog.dart';
import 'favourite_toggle_icon_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final GroceryItem groceryItem;
  final String? heroSuffix;

  const ProductDetailsScreen(this.groceryItem, {this.heroSuffix});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int amount = 1; // Default product's quantity
  String? selectedLocation; // Default selected location
  String? locationName;
  String? currentQuantity;

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.groceryItem.details?.merchantIds[0].toString();
    locationName = getLocationName(selectedLocation!);
    currentQuantity = "-/1kg";
  }

  void updateSelectedLocation(String locationId) {
    setState(() {
      selectedLocation = locationId;
      locationName = getLocationName(locationId);
    });
  }

  void updateSelectedQuantity(String quantityAmount) {
    setState(() {
      currentQuantity = quantityAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getImageHeaderWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        widget.groceryItem.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      subtitle: AppText(
                        text: widget.groceryItem.description,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff7C7C7C),
                      ),
                      trailing: FavoriteToggleIcon(),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        ItemCounterWidget(
                          onAmountChanged: (newAmount) {
                            setState(() {
                              amount = newAmount;
                            });
                          },
                        ),
                        Spacer(),
                        Text(
                          "Rp. ${calculateTotalPrice(currentQuantity).toStringAsFixed(3)}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Divider(thickness: 1),
                    getProductDataRowWidget("Toko", true,
                        customWidget: detailsWidget(locationName.toString())),
                    Divider(thickness: 1),
                    getProductDataRowWidget("Kuantitas", false,
                        customWidget:
                            containsNumber(widget.groceryItem.quantity)
                                ? detailsWidget(currentQuantity.toString())
                                : detailsWidget(widget.groceryItem.quantity)),
                    Divider(thickness: 1),
                    getProductDataRowWidget(
                      "Review",
                      false,
                      customWidget: ratingWidget(),
                    ),
                    Spacer(),
                    AppButton(
                      label: "Masukkan ke Keranjang",
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF).withOpacity(0.1),
              const Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Hero(
        tag: "GroceryItem:" +
            widget.groceryItem.name +
            "-" +
            (widget.heroSuffix ?? ""),
        child: Image(
          image: AssetImage(widget.groceryItem.imagePath),
        ),
      ),
    );
  }

  Widget getProductDataRowWidget(String label, bool isLocation,
      {Widget? customWidget}) {
    return GestureDetector(
      onTap: () => isLocation == true
          ? showEditLocationDialog(context, selectedLocation!)
          : label != "Review" && containsNumber(widget.groceryItem.quantity)
              ? showEditQuantityDialog(context, currentQuantity!)
              : () => {},
      child: Container(
        margin: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Row(
          children: [
            AppText(text: label, fontWeight: FontWeight.w600, fontSize: 16),
            Spacer(),
            if (customWidget != null) ...[
              customWidget,
              SizedBox(
                width: 20,
              )
            ],
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget detailsWidget(String textDetail) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: textDetail,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  Widget ratingWidget() {
    Widget starIcon() {
      return Icon(
        Icons.star,
        color: Color(0xffF3603F),
        size: 20,
      );
    }

    return Row(
      children: [
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
      ],
    );
  }

  double getTotalPrice() {
    return amount * widget.groceryItem.price;
  }

  void showEditLocationDialog(BuildContext context, String selectedLocation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDataDialog(
          currentLocation: widget.groceryItem.details!
              .merchantIds[int.parse(selectedLocation) - 1],
          locationOptions: widget.groceryItem.details!.merchantIds,
          stockAmounts: widget.groceryItem.details!.stockAmounts,
          onLocationSelected: updateSelectedLocation,
          editType: "location",
        );
      },
    );
  }

  void showEditQuantityDialog(BuildContext context, String currentQuantity) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditDataDialog(
              currentLocation: currentQuantity,
              locationOptions: ["-/250g", "-/500g", "-/1kg"],
              stockAmounts: [],
              onLocationSelected: updateSelectedQuantity,
              editType: "quantity");
        });
  }

  bool containsNumber(String? input) {
    if (input == null) return false;
    return RegExp(r'\d').hasMatch(input);
  }

  double calculateTotalPrice(productAmount) {
    switch (productAmount) {
      case "-/1kg":
        return getTotalPrice();
      case "-/500g":
        return getTotalPrice() * 0.5;
      case "-/250g":
        return getTotalPrice() * 0.25;
      default:
        return getTotalPrice();
    }
  }
}
