import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/styles/colors.dart';

import '_confirmation_dialog.dart';
import 'item_counter_widget.dart';

class ChartItemWidget extends StatefulWidget {
  ChartItemWidget(
      {Key? key,
      required this.item,
      this.quantity,
      this.onUpdateQuantity,
      required this.onDeleteItem})
      : super(key: key);
  final GroceryItem item;
  final double? quantity;
  final Function(double)? onUpdateQuantity;
  final VoidCallback onDeleteItem;

  @override
  _ChartItemWidgetState createState() => _ChartItemWidgetState();
}

class _ChartItemWidgetState extends State<ChartItemWidget> {
  final double height = 110;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  late double amount;

  @override
  void initState() {
    super.initState();
    amount = widget.quantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: widget.item.name,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 5,
                ),
                AppText(
                    text: widget.item.quantity,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey),
                SizedBox(
                  height: 12,
                ),
                Spacer(),
                ItemCounterWidget(
                    onAmountChanged: (newAmount) {
                      setState(() {
                        amount = newAmount;
                        widget.onUpdateQuantity!(amount);
                      });
                    },
                    initialAmount: widget.quantity,
                    isKilo: widget.quantity! % 1 != 0)
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                          message:
                              'Yakin ingin menghapus produk dari keranjang belanja anda? Anda dapat menambahkannya kembali pada halaman produk.',
                          title: 'Hapus Produk',
                          buttonAFunction: () {
                            Navigator.pop(context);
                            widget.onDeleteItem();
                          },
                          buttonBFunction: () => {Navigator.pop(context)},
                        );
                      },
                    ),
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColors.darkGrey,
                    size: 25,
                  ),
                ),
                Spacer(
                  flex: 5,
                ),
                Container(
                  width: 70,
                  child: AppText(
                    text: "Rp. ${getPrice().toStringAsFixed(3)}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.right,
                  ),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      width: 100,
      child: Image.asset(widget.item.imagePath),
    );
  }

  double getPrice() {
    return widget.item.price * amount;
  }
}
