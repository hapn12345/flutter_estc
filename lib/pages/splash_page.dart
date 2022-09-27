// ignore_for_file: use_build_context_synchronously

import 'package:estc_project/pages/home_page.dart';
import 'package:estc_project/util/log_util.dart';
import 'package:estc_project/util/shared_preference_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routing/route_state.dart';
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

    Future.delayed(const Duration(seconds: 1), () async {
      final firstLaunch = await SharedPreferenceUtil().isFirstLaunch();
      //In the future check login
      RouteStateScope.of(context).go('/login');
      LogUtil.d('first launch: $firstLaunch');
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                firstLaunch ? const OnboardingPage() : const HomePage()),
      );*/
    });
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
