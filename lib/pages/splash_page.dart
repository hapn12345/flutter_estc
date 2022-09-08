// ignore_for_file: use_build_context_synchronously

import 'package:estc_project/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        final prefs = await SharedPreferences.getInstance();
        final showHome = prefs.getBool('showHome') ?? false;
        //In the future check login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                showHome ? const HomePage() : const OnboardingPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "images/app_icon.png",
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.black38,
            ),
          )
        ],
      )),
    );
  }
}
