import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _userEmail;
  String? _userName;

  String? get userEmail => _userEmail;
  String? get userName => _userName;

  void setUserEmail(String? email) {
    _userEmail = email;
    notifyListeners();
  }

  void setUserName() {
    _userName = getUserName(_userEmail!).toString();
    notifyListeners();
  }
}

Future<String?> getUserName(String userEmail) async {
  String? userName;

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      userName = querySnapshot.docs.first.get('nama');
    }
  } catch (e) {
    print('Error retrieving user name: $e');
  }

  return userName;
}
