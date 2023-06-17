class AccountItem {
  final String label;
  final String iconPath;

  AccountItem(this.label, this.iconPath);
}

List<AccountItem> accountItems = [
  AccountItem("Riwayat Pesanan", "assets/icons/account_icons/orders_icon.svg"),
  AccountItem("Detail Akun", "assets/icons/account_icons/details_icon.svg"),
  AccountItem("Promo & Diskon", "assets/icons/account_icons/promo_icon.svg"),
  AccountItem("Komplain Pesanan", "assets/icons/account_icons/help_icon.svg"),
  AccountItem("Tentang kami", "assets/icons/account_icons/about_icon.svg"),
];
