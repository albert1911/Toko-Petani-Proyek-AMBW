import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryEntry {
  final String emailUser;
  final int idMerchant;
  final Map<String, dynamic> listBarang;
  final Timestamp deliveryTime;
  final double totalPayment;

  HistoryEntry(
      {required this.emailUser,
      required this.idMerchant,
      required this.listBarang,
      required this.deliveryTime,
      required this.totalPayment});

  @override
  String toString() {
    return 'HistoryEntry{emailUser: $emailUser, \nidMerchant: $idMerchant, \nlistBarang: $listBarang, \ndeliveryTime: $deliveryTime, \ntotalPayment: $totalPayment}';
  }
}

var checkout;

List<HistoryEntry> historyList = [
  HistoryEntry(
    emailUser: "user@example.com",
    idMerchant: 123,
    listBarang: {
      "id-barang": [1, 2, 3],
      "jumlah-barang": [2, 3, 1],
    },
    deliveryTime: Timestamp.fromDate(DateTime.now()),
    totalPayment: 45.67,
  ),
  HistoryEntry(
    emailUser: "user2@example.com",
    idMerchant: 456,
    listBarang: {
      "id-barang": [4, 5, 6],
      "jumlah-barang": [1, 4, 2],
    },
    deliveryTime: Timestamp.fromDate(DateTime.now()),
    totalPayment: 78.90,
  ),
  HistoryEntry(
    emailUser: "user3@example.com",
    idMerchant: 789,
    listBarang: {
      "id-barang": [7, 8, 9],
      "jumlah-barang": [3, 2, 1],
    },
    deliveryTime: Timestamp.fromDate(DateTime.now()),
    totalPayment: 123.45,
  )
];

void addHistoryEntryToFirebase(HistoryEntry entry) async {
  CollectionReference history =
      FirebaseFirestore.instance.collection('history');

  await history.add({
    'deliver-time': entry.deliveryTime,
    'email-user': entry.emailUser,
    'id-merchant': entry.idMerchant,
    'list-barang': entry.listBarang,
    'total-payment': entry.totalPayment,
  });
}
