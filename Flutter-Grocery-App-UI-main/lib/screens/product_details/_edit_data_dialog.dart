import 'package:flutter/material.dart';

import '../../models/merchant.dart';

class EditDataDialog extends StatefulWidget {
  final String currentLocation;
  final List<String> locationOptions;
  final List<String> stockAmounts;
  final Function(String) onLocationSelected;
  final String editType;

  EditDataDialog({
    required this.currentLocation,
    required this.locationOptions,
    required this.stockAmounts,
    required this.onLocationSelected,
    required this.editType,
  });

  @override
  _EditDataDialogState createState() => _EditDataDialogState();
}

class _EditDataDialogState extends State<EditDataDialog> {
  String selectedLocation = '';

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.editType == "quantity" ? 'Ubah Kuantitas' : 'Ubah Toko',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.editType == "quantity"
                  ? '→ Kuantitas saat ini'
                  : '→ Toko yang terpilih sekarang',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              widget.editType == "quantity"
                  ? widget.currentLocation
                  : getLocationName(widget.currentLocation),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.editType == "quantity"
                  ? ''
                  : daftarToko[int.parse(widget.currentLocation)].alamat,
            ),
            SizedBox(height: 25),
            Text(
              widget.editType == "quantity"
                  ? '→ Pilih kuantitas lain'
                  : '→ Pilih toko lain',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 3),
            DropdownButton<String>(
              value: selectedLocation,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLocation = newValue!;
                });
              },
              items: widget.editType != "quantity"
                  ? widget.locationOptions
                      .asMap()
                      .entries
                      .map<DropdownMenuItem<String>>(
                      (entry) {
                        final index = entry.key;
                        final value = entry.value;
                        final stockAmount = widget.stockAmounts[index];
                        final merchant =
                            daftarToko.firstWhere((toko) => toko.id == value);
                        final merchantName = merchant.nama;
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Text(merchantName),
                              SizedBox(width: 8),
                              Text('(Sisa stok: $stockAmount)'),
                            ],
                          ),
                        );
                      },
                    ).toList()
                  : widget.locationOptions
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  // Save the selected location and close the dialog
                  widget.onLocationSelected(selectedLocation);
                  Navigator.pop(context);
                },
                child: Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
