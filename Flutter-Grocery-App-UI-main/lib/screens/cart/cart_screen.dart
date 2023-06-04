import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/models/cart_item.dart';
import 'package:grocery_app/models/merchant.dart';
import 'package:grocery_app/widgets/chart_item_widget.dart';
import 'package:collection/collection.dart';

import 'checkout_bottom_sheet.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Toko merchant = daftarToko[int.parse(cartItems[0].idMerchant)];
  int checked = 0;
  List<double> totalPriceList = [];

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
                "My Cart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: List<Widget>.generate(cartItems.length, (cartIndex) {
                  final cartItem = cartItems[cartIndex];
                  final merchant =
                      daftarToko[int.parse(cartItem.idMerchant) - 1];
                  double totalPrice = calculateTotalPrice(cartIndex);

                  if (totalPriceList.length <= cartIndex) {
                    totalPriceList.add(totalPrice);
                  } else {
                    totalPriceList[cartIndex] = totalPrice;
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: cartIndex == checked,
                              onChanged: (value) {
                                setState(() {
                                  checked = cartIndex;
                                  calculateTotalPrice(cartIndex);
                                });
                              }),
                          Text(
                            merchant.nama,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                      Text(merchant.alamat),
                      Column(
                        children: getChildrenWithSeperator(
                          addToLastChild: false,
                          widgets: cartItem.idProducts.mapIndexed((index, e) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              width: double.maxFinite,
                              child: ChartItemWidget(
                                item: getGroceryItemById(e),
                                quantity: cartItem.quantity[index],
                                onUpdateQuantity: (newQuantity) {
                                  updateCartItemQuantity(
                                      newQuantity, cartIndex, index);
                                },
                              ),
                            );
                          }).toList(),
                          seperator: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ),
                      ),
                      getButtonPriceWidget(cartIndex),
                      SizedBox(height: 50),
                    ],
                  );
                }),
              ),
              Divider(
                thickness: 1,
              ),
              getButtonPriceWidget(checked),
              getCheckoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCheckoutButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: AppButton(
        label: "Lakukan Check Out",
        fontWeight: FontWeight.w600,
        padding: EdgeInsets.symmetric(vertical: 30),
        onPressed: () {
          showBottomSheet(context);
        },
      ),
    );
  }

  Widget getButtonPriceWidget(int cartIndex) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "Harga Total: Rp. ${totalPriceList[cartIndex].toStringAsFixed(3)}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet();
        });
  }

  void updateCartItemQuantity(double quantity, int cartindex, int index) {
    setState(() {
      cartItems[cartindex].quantity[index] = quantity;
      calculateTotalPrice(cartindex);
    });
  }

  double calculateTotalPrice(int cartindex) {
    double total = 0.0;

    for (var i = 0; i < cartItems[cartindex].idProducts.length; i++) {
      total += getGroceryItemById(cartItems[cartindex].idProducts[i]).price *
          cartItems[cartindex].quantity[i];
    }

    return total;
  }
}
