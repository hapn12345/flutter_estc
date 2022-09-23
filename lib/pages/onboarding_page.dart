import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../util/constants.dart';
import 'login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeDevice = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 60),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            introPage(
              size: sizeDevice,
              color: Constants.kColorBgIntro,
              urlImage: "images/introduction_image.png",
              title: 'Lorem ispsum',
              subTitle:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            ),
            introPage(
              size: sizeDevice,
              color: Constants.kColorBgIntro,
              urlImage: "images/mood_dairy_image.png",
              title: 'Lorem ispsum',
              subTitle:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            ),
            introPage(
              size: sizeDevice,
              color: Constants.kColorBgIntro,
              urlImage: "images/relax_image.png",
              title: 'Lorem ispsum',
              subTitle:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: sizeDevice.height / 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('showHome', true);

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Bắt Đầu',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: sizeDevice.height / 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Bỏ qua'),
                    onPressed: () {
                      controller.jumpToPage(2);
                    },
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const SlideEffect(
                      spacing: 12,
                      dotColor: Colors.black26,
                      activeDotColor: Colors.blue,
                      dotHeight: 12,
                      dotWidth: 12,
                    ),
                    onDotClicked: (index) => controller.animateToPage(
                      index,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn,
                    ),
                  ),
                  TextButton(
                    child: const Text('Tiếp'),
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeOut,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

Widget introPage({
  required Size size,
  required Color color,
  required String urlImage,
  required String title,
  required String subTitle,
}) {
  return Container(
    color: color,
    child: Column(
      children: [
        Image.asset(
          urlImage,
          height: size.height / 2,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        const SizedBox(height: 64),
        Text(
          title,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            subTitle,
            style: const TextStyle(color: Colors.black),
          ),
        )
      ],
    ),
  );
}
