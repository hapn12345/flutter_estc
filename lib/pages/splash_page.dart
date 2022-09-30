import 'package:flutter/material.dart';
import '../routing/route_state.dart';
import '../util/shared_preference_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
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
