import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
// import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  final String imagePath = "assets/images/welcome_image.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFEFFB5),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(),
                icon(),
                SizedBox(
                  height: 20,
                ),
                welcomeTextWidget(),
                SizedBox(
                  height: 10,
                ),
                sloganText(),
                SizedBox(
                  height: 40,
                ),
                getButton(context),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ));
  }

  Widget icon() {
    String iconPath = "assets/icons/_app_icon.svg";
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFA8FF8D).withOpacity(0.8),
            blurRadius: 50,
            spreadRadius: 10,
          ),
        ],
      ),
      child: SvgPicture.asset(
        iconPath,
        width: 96,
        height: 96,
      ),
    );
  }

  Widget welcomeTextWidget() {
    return Column(
      children: [
        AppText(
          text: "Selamat datang!",
          fontSize: 34,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2A881E),
          glowColor: Color(0xFFA8FF8D),
        ),
        AppText(
          text: "E-PASAR",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2A881E),
          glowColor: Color(0xFFA8FF8D),
        ),
      ],
    );
  }

  Widget sloganText() {
    return AppText(
      text: "Sadia sayur dan buah langsung dari pasar",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xFF2A881E).withOpacity(0.7),
      glowColor: Color(0xFFA8FF8D),
    );
  }

  Widget getButton(BuildContext context) {
    return AppButton(
      label: "Masuk",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () {
        onGetStartedClicked(context);
      },
    );
  }

  void onGetStartedClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return DashboardScreen();
      },
    ));
  }
}
