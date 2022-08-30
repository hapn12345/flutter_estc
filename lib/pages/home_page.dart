import 'package:estc_project/pages/alert_page.dart';
import 'package:estc_project/util/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/ListItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final controller = PageController();
  final notificationApi = NotificationApi();

  void _onItemTapped(
    int index,
  ) {
    controller.animateToPage(index,
        duration: const Duration(microseconds: 500), curve: Curves.easeIn);
    if (index == 1) {
      NotificationApi.showNotifications(
        body: '123123',
        payload: '21312321.a',
        title: '123123123',
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    notificationApi.initialseNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listItem = List<ListItem>.generate(
      100,
      (i) => i % 6 == 0
          ? HeadingItem('Heading $i')
          : MessageItem('Sender $i', 'Message body $i'),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Trang chủ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          const WebView(
            initialUrl: "https://www.facebook.com/hapn12345",
          ),
          AlertPage(items: listItem),
          Container(
            color: Colors.red,
            child: const Center(child: Text('Page 3')),
          ),
          Container(
            color: Colors.red,
            child: const Center(child: Text('Page 4')),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.error_outline_outlined),
            label: 'Alert',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Add Logs',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
            backgroundColor: Colors.grey,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
