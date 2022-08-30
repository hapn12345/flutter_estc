import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  void dispose() {
    controller.dispose();
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
            Container(
              color: Colors.red,
              child: const Center(child: Text('Page 1')),
            ),
            Container(
              color: Colors.indigo,
              child: const Center(child: Text('Page 2')),
            ),
            Container(
              color: Colors.red,
              child: const Center(child: Text('Page 3')),
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
