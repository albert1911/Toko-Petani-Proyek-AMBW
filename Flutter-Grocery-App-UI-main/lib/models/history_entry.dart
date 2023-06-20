import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryEntry {
  final String emailUser;
  final int idMerchant;
  final Map<String, dynamic> listBarang;
  final Timestamp deliveryTime;
  final double totalPayment;
  final String status;
  final String historyAddress;

  HistoryEntry(
      {required this.emailUser,
      required this.idMerchant,
      required this.listBarang,
      required this.deliveryTime,
      required this.totalPayment,
      required this.status,
      required this.historyAddress});

  @override
  String toString() {
    return 'HistoryEntry{emailUser: $emailUser, \nidMerchant: $idMerchant, \nlistBarang: $listBarang, \ndeliveryTime: $deliveryTime, \ntotalPayment: $totalPayment}';
  }
}

var checkout;

List<HistoryEntry> historyList = [];
List<HistoryEntry> demoHistory = [
  HistoryEntry(
      emailUser: "user@example.com",
      idMerchant: 1,
      listBarang: {
        "id-barang": ["1", "2", "3"],
        "jumlah-barang": [2.0, 3.0, 1.0],
      },
      deliveryTime: Timestamp.fromDate(DateTime.now()),
      totalPayment: 64.5,
      status: "Dikonfirmasi",
      historyAddress: "Jl Stress 123"),
  HistoryEntry(
      emailUser: "user2@example.com",
      idMerchant: 2,
      listBarang: {
        "id-barang": ["4", "5", "6"],
        "jumlah-barang": [1.0, 4.0, 2.0],
      },
      deliveryTime: Timestamp.fromDate(DateTime.now()),
      totalPayment: 182.0,
      status: "Dalam Perjalanan",
      historyAddress: "Jl Depresi 456"),
  HistoryEntry(
      emailUser: "user3@example.com",
      idMerchant: 3,
      listBarang: {
        "id-barang": ["7", "8", "9"],
        "jumlah-barang": [3.0, 2.0, 1.0],
      },
      deliveryTime: Timestamp.fromDate(DateTime.now()),
      totalPayment: 50.0,
      status: "Selesai",
      historyAddress: "Jl Waswas 678")
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
    'status': entry.status,
    'address': entry.historyAddress,
  });
}

Future<List<HistoryEntry>> getHistoryEntryFromFirebase(
    String userEmailKu) async {
  CollectionReference history =
      FirebaseFirestore.instance.collection('history');

  QuerySnapshot querySnapshot =
      await history.where('email-user', isEqualTo: userEmailKu).get();

  List<HistoryEntry> entries = [];
  querySnapshot.docs.forEach((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    double totalPayment = (data['total-payment'] is int)
        ? (data['total-payment'] as int).toDouble()
        : data['total-payment'];
    entries.add(HistoryEntry(
        emailUser: data['email-user'],
        idMerchant: data['id-merchant'],
        listBarang: data['list-barang'],
        deliveryTime: data['deliver-time'],
        totalPayment: totalPayment,
        status: data['status'],
        historyAddress: data['address']));
  });

  return entries;
}
