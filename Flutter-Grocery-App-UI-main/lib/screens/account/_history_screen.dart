import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat'),
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
      title: Text(historyEntry.restaurantName),
      subtitle: Text(historyEntry.deliveryTime),
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
            title: Text(historyEntry.restaurantName),
            subtitle: Text(historyEntry.deliveryTime),
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
                  children: List.generate(
                    historyEntry.foodList.length,
                    (index) {
                      return Text(
                        '${historyEntry.foodList[index]} x ${historyEntry.quantity[index]}',
                      );
                    },
                  ),
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
                Text(historyEntry.totalPayment),
              ],
            ),
          ),
        ],
      ),
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

class HistoryEntry {
  final String restaurantName;
  final String deliveryTime;
  final String status;
  final List<String> foodList;
  final List<double> quantity;
  final String totalPayment;

  HistoryEntry({
    required this.restaurantName,
    required this.deliveryTime,
    required this.status,
    required this.foodList,
    required this.quantity,
    required this.totalPayment,
  });
}

// Contoh daftar riwayat
List<HistoryEntry> historyList = [
  HistoryEntry(
    restaurantName: 'Restoran A',
    deliveryTime: '2 Juni 2023, 13.00',
    status: 'Selesai',
    foodList: ['Nasi Goreng', 'Ayam Bakar'],
    quantity: [2, 1],
    totalPayment: 'Rp50.000',
  ),
  HistoryEntry(
    restaurantName: 'Restoran B',
    deliveryTime: '1 Juni 2023, 19.30',
    status: 'Dalam Perjalanan',
    foodList: ['Mie Ayam', 'Es Teh'],
    quantity: [1, 1],
    totalPayment: 'Rp35.000',
  ),
  HistoryEntry(
    restaurantName: 'Restoran C',
    deliveryTime: '31 Mei 2023, 12.15',
    status: 'Dikonfirmasi',
    foodList: ['Nasi Padang'],
    quantity: [1],
    totalPayment: 'Rp25.000',
  ),
];
