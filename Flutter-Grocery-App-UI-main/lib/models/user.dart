import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyUser {
  final String nama;
  final String email;
  final String alamat;

  MyUser({
    required this.nama,
    required this.email,
    required this.alamat,
  });

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'email': email,
        'alamat': alamat,
      };

  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
        nama: json['nama'],
        email: json['email'],
        alamat: json['alamat'],
      );
}

bool isLoggedIn = false;
String userNameKu = "";
String userEmailKu = "";

void setUserEmail(String? email) {
  userEmailKu = email!;
}

Future<String> getUserName(String userEmail) async {
  String userName = '';

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      userName = querySnapshot.docs.first.get('nama') ?? '';
    }
  } catch (e) {
    print('Error retrieving user name: $e');
  }

  return userName;
}

Future<String> loadUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userString = prefs.getString("user_email");
  if (userString != null) {
    return userString;
  } else {
    return "";
  }
}

Future<void> saveUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("user_email", userEmailKu);
}
