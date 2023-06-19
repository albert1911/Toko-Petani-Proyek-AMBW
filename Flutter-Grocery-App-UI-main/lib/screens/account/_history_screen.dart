import 'package:flutter/material.dart';
import 'package:grocery_app/models/merchant.dart';

import '../../models/cart_item.dart';
import '../../models/grocery_item.dart';
import '../../models/history_entry.dart';
import '../../styles/colors.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          return HistoryItem(historyList[index]);
        },
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final HistoryEntry historyEntry;
  HistoryItem(this.historyEntry);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(getLocationName(historyEntry.idMerchant.toString())),
      subtitle: Text(formatFirebaseTimestamp(historyEntry.deliveryTime)),
      trailing: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: _getStatusColor(historyEntry.status),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          historyEntry.status,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryDetailsPage(historyEntry),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    if (status == 'Dikonfirmasi') {
      return Colors.orange;
    } else if (status == 'Dalam Perjalanan') {
      return Colors.blue;
    } else if (status == 'Selesai') {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}

class HistoryDetailsPage extends StatelessWidget {
  final HistoryEntry historyEntry;

  HistoryDetailsPage(this.historyEntry);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rincian'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(getLocationName(historyEntry.idMerchant.toString())),
            subtitle: Text(formatFirebaseTimestamp(historyEntry.deliveryTime)),
            trailing: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: _getStatusColor(historyEntry.status),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                historyEntry.status,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Makanan:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  children: getHistoryEntryWidgets(historyEntry),
                ),
                SizedBox(height: 16),
                Text(
                  'Total Pembayaran:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text("Rp. ${historyEntry.totalPayment.toStringAsFixed(3)}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getHistoryEntryWidgets(HistoryEntry historyEntry) {
    List<dynamic>? idList = historyEntry.listBarang["id-barang"];
    List<dynamic>? quantityList = historyEntry.listBarang["jumlah-barang"];

    if (idList == null || quantityList == null) {
      return []; // Return an empty list if either list is null
    }

    return List<Widget>.generate(idList.length, (index) {
      int id = idList[index];
      double quantity = quantityList[index];
      GroceryItem item = getGroceryItemById(id.toString());

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${item.name} x $quantity'),
          Text('Price: ${item.price}'),
        ],
      );
    });
  }

  Color _getStatusColor(String status) {
    if (status == 'Dikonfirmasi') {
      return Colors.orange;
    } else if (status == 'Dalam Perjalanan') {
      return Colors.blue;
    } else if (status == 'Selesai') {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}
