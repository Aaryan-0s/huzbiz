import 'package:huzbiz_app/core/routes/app_routes.dart';
import 'package:huzbiz_app/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    _initializeSplashScreen();
  }

  _initializeSplashScreen() {
    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/huzbiz_logo.png",
              width: size.width * 0.8,
              height: size.height * 0.2,
            ),
            const SizedBox(height: 10.0),
            const SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: AppColors.secondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
