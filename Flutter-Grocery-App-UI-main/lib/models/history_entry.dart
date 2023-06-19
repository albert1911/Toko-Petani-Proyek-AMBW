import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryEntry {
  final String emailUser;
  final int idMerchant;
  final Map<String, dynamic> listBarang;
  final Timestamp deliveryTime;
  final double totalPayment;
  final String status;

  HistoryEntry(
      {required this.emailUser,
      required this.idMerchant,
      required this.listBarang,
      required this.deliveryTime,
      required this.totalPayment,
      required this.status});

  @override
  String toString() {
    return 'HistoryEntry{emailUser: $emailUser, \nidMerchant: $idMerchant, \nlistBarang: $listBarang, \ndeliveryTime: $deliveryTime, \ntotalPayment: $totalPayment}';
  }
}

var checkout;

List<HistoryEntry> historyList = [
  HistoryEntry(
    emailUser: "user@example.com",
    idMerchant: 1,
    listBarang: {
      "id-barang": [1, 2, 3],
      "jumlah-barang": [2.0, 3.0, 1.0],
    },
    deliveryTime: Timestamp.fromDate(DateTime.now()),
    totalPayment: 45.67,
    status: "Dikonfirmasi",
  ),
  HistoryEntry(
    emailUser: "user2@example.com",
    idMerchant: 2,
    listBarang: {
      "id-barang": [4, 5, 6],
      "jumlah-barang": [1.0, 4.0, 2.0],
    },
    deliveryTime: Timestamp.fromDate(DateTime.now()),
    totalPayment: 78.90,
    status: "Dalam Perjalanan",
  ),
  HistoryEntry(
    emailUser: "user3@example.com",
    idMerchant: 3,
    listBarang: {
      "id-barang": [7, 8, 9],
      "jumlah-barang": [3.0, 2.0, 1.0],
    },
    deliveryTime: Timestamp.fromDate(DateTime.now()),
    totalPayment: 123.45,
    status: "Selesai",
  )
];

String formatFirebaseTimestamp(Timestamp firebaseTimestamp) {
  DateTime dateTime = firebaseTimestamp.toDate();
  String formattedDateTime =
      '${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
  return formattedDateTime;
}

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

void getHistoryEntryFromFirebase() {
  // temp
}
