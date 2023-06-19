import 'package:flutter/material.dart';
import 'package:grocery_app/screens/account/_history_screen.dart';

class AccountItem {
  final String label;
  final String iconPath;
  final Widget? route;

  AccountItem(this.label, this.iconPath, [this.route]);
}

List<AccountItem> accountItems = [
  AccountItem("Riwayat Pesanan", "assets/icons/account_icons/orders_icon.svg",
      HistoryScreen()),
  AccountItem("Detail Akun", "assets/icons/account_icons/details_icon.svg"),
  AccountItem("Promo & Diskon", "assets/icons/account_icons/promo_icon.svg"),
  AccountItem("Komplain Pesanan", "assets/icons/account_icons/help_icon.svg"),
  AccountItem("Tentang kami", "assets/icons/account_icons/about_icon.svg"),
];
