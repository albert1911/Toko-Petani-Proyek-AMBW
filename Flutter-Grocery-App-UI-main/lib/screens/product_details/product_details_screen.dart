import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/cart_item.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
import 'package:grocery_app/widgets/item_counter_widget.dart';

import '../../models/merchant.dart';
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
                              amount = newAmount.toInt();
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
                            containsNumber(widget.groceryItem.quantity) &&
                                    widget.groceryItem.quantity != "-/100g"
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
                      onPressed: () {
                        double cartAmount = amount.toDouble();
                        switch (currentQuantity) {
                          case "-/250g":
                            cartAmount /= 0.25;
                            break;
                          case "-/500g":
                            cartAmount /= 0.5;
                            break;
                          default:
                            print('Selected quantity is not recognized');
                        }
                        if (checkProductStock(selectedLocation!,
                            widget.groceryItem.id.toString(), cartAmount)) {
                          updateCartItems(
                            selectedLocation!,
                            widget.groceryItem.id.toString(),
                            cartAmount,
                          );
                          saveCart();
                          showCartDialog(false);
                        } else {
                          showCartDialog(true);
                        }
                      },
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

  /* NEW FUNCTIONS */

  void showCartDialog(bool isExceed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text(
            isExceed ? "GAGAL" : "SUKSES",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
                child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isExceed
                      ? Container(
                          height: 150,
                          child:
                              SvgPicture.asset("assets/icons/failed_icon.svg"),
                        )
                      : Container(
                          height: 250,
                          child: SvgPicture.asset(
                              "assets/icons/order_accepted_icon.svg"),
                        ),
                  Text(
                    isExceed
                        ? "Produk gagal ditambahkan ke keranjang dikarenakan barang yang dimasukkan melebihi stok yang tersedia, mohon periksa kembali kuantitas barang yang akan dibeli."
                        : 'Produk Anda telah berhasil ditambahkan ke keranjang.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )),
          ),
          actions: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  !isExceed
                      ? AppButton(
                          label: "Lakukan Check Out",
                          onPressed: () => {
                            Navigator.pop(context),
                            Navigator.pop(context),
                            Navigator.of(context)
                                .pushReplacement(new MaterialPageRoute(
                              builder: (BuildContext context) {
                                return DashboardScreen(initialIndex: 2);
                              },
                            )),
                          },
                          padding: EdgeInsets.zero,
                        )
                      : AppButton(
                          label: "Periksa Keranjang Belanja",
                          onPressed: () => {
                            Navigator.pop(context),
                            Navigator.pop(context),
                            Navigator.of(context)
                                .pushReplacement(new MaterialPageRoute(
                              builder: (BuildContext context) {
                                return DashboardScreen(initialIndex: 2);
                              },
                            )),
                          },
                          padding: EdgeInsets.zero,
                        ),
                  SizedBox(height: 10),
                  AppButton(
                    label: "Kembali Belanja",
                    onPressed: () => {
                      Navigator.pop(context),
                      Navigator.pop(context),
                      Navigator.of(context)
                          .pushReplacement(new MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DashboardScreen(initialIndex: 0);
                        },
                      )),
                    },
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void updateCartItems(
      String idMerchantCart, String idProductCart, double quantityCart) {
    bool foundMerchant = false;

    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].idMerchant == idMerchantCart) {
        foundMerchant = true;

        int existingProductIndex = -1;
        for (int j = 0; j < cartItems[i].idProducts.length; j++) {
          if (cartItems[i].idProducts[j] == idProductCart) {
            existingProductIndex = j;
            break;
          }
        }

        if (existingProductIndex != -1) {
          cartItems[i].quantity[existingProductIndex] += quantityCart;
        } else {
          cartItems[i].idProducts.add(idProductCart);
          cartItems[i].quantity.add(quantityCart);
        }

        break;
      }
    }

    if (!foundMerchant) {
      cartItems.add(
        CartItem(
          idProducts: [idProductCart],
          idMerchant: idMerchantCart,
          quantity: [quantityCart],
        ),
      );
    }
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

  bool checkProductStock(
      String idMerchantCart, String idProductCart, double quantityCart) {
    double requiredStock = quantityCart;
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].idMerchant == idMerchantCart) {
        int existingProductIndex =
            cartItems[i].idProducts.indexOf(idProductCart);

        if (existingProductIndex != -1) {
          double existingQuantity = cartItems[i].quantity[existingProductIndex];
          requiredStock += existingQuantity;
        }
      }
    }

    double availableStock = 0;
    for (int x = 0; x < widget.groceryItem.details!.merchantIds.length; x++) {
      if (idMerchantCart == widget.groceryItem.details!.merchantIds[x]) {
        availableStock =
            double.parse(widget.groceryItem.details!.stockAmounts[x]);
        break;
      }
    }

    print("Available Stock = " + availableStock.toString());
    print("Required Stock = " + requiredStock.toString());

    return availableStock >= requiredStock;
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
