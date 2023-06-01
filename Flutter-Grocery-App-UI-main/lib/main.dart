import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

// https://console.firebase.google.com/u/6/project/e-pasar-642b7/overview
