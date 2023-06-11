import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/dashboard/dashboard_screen.dart';
import '../styles/colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.message,
    required this.content,
    required this.subcontent,
    required this.isError,
    required this.appBarTitle,
  });

  final String title;
  final String subtitle;
  final String message;
  final Widget content;
  final Widget subcontent;
  final bool isError;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    TextStyle errorStyle = GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: isError ? Colors.red : Colors.green,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) {
                return DashboardScreen(initialIndex: 3);
              },
            ));
          },
        ),
        title: Text(appBarTitle),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 0, bottom: 0, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title != "null"
                ? Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  )
                : SizedBox(),
            subtitle != "null" ? Text(subtitle) : SizedBox(),
            const SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(1, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Container(
                    margin: const EdgeInsets.only(
                        top: 25, bottom: 25, left: 25, right: 25),
                    child: content),
              ),
            ),
            const SizedBox(height: 25),
            subcontent,
            const SizedBox(height: 15),
            Text(message, style: errorStyle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
