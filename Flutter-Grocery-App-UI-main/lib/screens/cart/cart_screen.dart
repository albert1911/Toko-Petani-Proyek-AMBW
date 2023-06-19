import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/models/cart_item.dart';
import 'package:grocery_app/models/history_entry.dart';
import 'package:grocery_app/models/merchant.dart';
import 'package:grocery_app/widgets/chart_item_widget.dart';
import 'package:collection/collection.dart';

import '../../models/grocery_item.dart';
import '../../models/user.dart';
import '../../widgets/_confirmation_dialog.dart';
import '../dashboard/dashboard_screen.dart';
import '../order_accepted_screen.dart';
import '../order_failed_dialog.dart';
import 'checkout_bottom_sheet.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Toko merchant;
  bool isCartEmpty = false;
  int checked = 0;
  List<double> totalPriceList = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    List<CartItem> loadedCartItems = await loadCart();
    setState(() {
      cartItems = loadedCartItems;
      if (cartItems.isNotEmpty) {
        merchant = daftarToko[int.parse(cartItems[0].idMerchant)];
        isCartEmpty = false;
      } else {
        isCartEmpty = true;
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
                "Keranjang Belanja",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              getCartItems(),
              SizedBox(
                height: 20,
              ),
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
        onPressed: () async {
          if (userEmailKu == "") {
            userEmailKu = await loadUser();
            if (userEmailKu != "") isLoggedIn = true;
          }

          if (isLoggedIn) {
            showBottomSheet(context);
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return OrderFailedDialogue();
                });
          }
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
        totalPriceList.isNotEmpty
            ? "Harga Total: Rp. ${totalPriceList[cartIndex].toStringAsFixed(3)}"
            : "",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
      ),
    );
  }

  Widget getEmptyCartButton() {
    return !isCartEmpty
        ? ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ConfirmationDialog(
                    title: 'Kosongkan Keranjang',
                    message: 'Anda yakin ingin mengosongkan keranjang?',
                    buttonAFunction: () {
                      Navigator.pop(context);
                      clearCart();
                      loadCart();
                      setState(() {
                        isCartEmpty = true;
                        totalPriceList.clear();
                      });
                    },
                    buttonBFunction: () {
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                "Kosongkan Keranjang",
                style: TextStyle(fontSize: 14),
              ),
            ),
          )
        : SizedBox(height: 1);
  }

  Widget getCartItems() {
    return isCartEmpty
        ? Center(
            child: Column(
            children: [
              Image.asset(
                'assets/images/keranjang_kosong.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text('Keranjang belanja masih kosong',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Silahkan masukkan produk sayur & buah favorit anda.'),
              SizedBox(height: 25),
              Container(
                width: 200,
                child: AppButton(
                  label: "Belanja Sekarang",
                  onPressed: () {
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return DashboardScreen(initialIndex: 0);
                      },
                    ));
                  },
                ),
              ),
            ],
          ))
        : Column(
            children: [
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
                                onDeleteItem: () {
                                  deleteCartItem(index.toString());
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
              Container(
                margin: EdgeInsets.only(right: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: getEmptyCartButton(),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              getButtonPriceWidget(checked),
              getCheckoutButton(context),
            ],
          );
  }

  void makeHistoryEntry() async {
    Map<String, dynamic> listBarang = {};
    listBarang["id-barang"] = cartItems[checked].idProducts;
    listBarang["jumlah-barang"] = cartItems[checked].quantity;

    double totalPayment = 0.0;

    for (int i = 0; i < listBarang["id-barang"]!.length; i++) {
      String itemId = listBarang["id-barang"]![i];
      double quantity = listBarang["jumlah-barang"]![i];

      GroceryItem groceryItem = getGroceryItemById(itemId);

      if (groceryItem != unknownProduct) {
        totalPayment += groceryItem.price * quantity;
      }
    }

    setState(() {
      checkout = HistoryEntry(
          emailUser: userEmailKu,
          idMerchant: int.parse(cartItems[checked].idMerchant),
          listBarang: listBarang,
          deliveryTime: Timestamp.fromDate(DateTime.now()),
          totalPayment: totalPayment);

      print(checkout.toString());
    });

    addHistoryEntryToFirebase(checkout);

    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return OrderAcceptedScreen();
        });
  }

  void showBottomSheet(context) {
    totalCost = totalPriceList[checked];

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet(checkoutFunction: makeHistoryEntry);
        });
  }

  void updateCartItemQuantity(double quantity, int cartindex, int index) {
    setState(() {
      cartItems[cartindex].quantity[index] = quantity;
      calculateTotalPrice(cartindex);
    });
  }

  void deleteCartItem(String itemIndex) {
    setState(() {
      cartItems.removeAt(int.parse(itemIndex));

      if (cartItems.isEmpty) {
        isCartEmpty = true;
      }

      saveCart();
      loadCart();
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
