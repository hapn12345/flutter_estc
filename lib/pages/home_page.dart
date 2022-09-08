import 'package:estc_project/pages/alert_page.dart';
import 'package:estc_project/pages/image_page.dart';
import 'package:estc_project/pages/log/add_logs_page.dart';
import 'package:estc_project/pages/log/log_history_page.dart';
import 'package:estc_project/util/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isHasIcon = false;
  int _selectedIndex = 0;
  String title = "Trang chủ";
  final controller = PageController();
  final notificationApi = NotificationApi();

  void _onItemTapped(
    int index,
  ) {
    controller.animateToPage(index,
        duration: const Duration(microseconds: 500), curve: Curves.easeIn);
    switch (index) {
      case 0:
        setState(() {
          title = "Trang chủ";
        });
        break;
      case 1:
        NotificationApi.showNotifications(
          body: '123123',
          payload: '21312321.a',
          title: '123123123',
        );
        setState(() {
          title = "Thông báo";
        });
        break;
      case 2:
        setState(() {
          isHasIcon = true;
          title = "Add logs";
        });
        break;
      case 3:
        setState(() {
          title = "User";
        });
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    NotificationApi.initialseNotifications();
    NotificationApi.isAndroidPermissionGranted();
    NotificationApi.requestPermissions();
    listenNotifications();
  }

  void listenNotifications() => NotificationApi.onNotifications.stream.listen(
        (event) => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          ),
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isHasIcon
          ? AppBar(
              backgroundColor: Colors.white,
              title: Text(
                title,
                style: const TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LogHistoryPage(),
                    ));
                  },
                  icon: const Icon(
                    Icons.history,
                    color: Colors.black,
                  ),
                )
              ],
            )
          : AppBar(
              backgroundColor: Colors.white,
              title: Text(
                title,
                style: const TextStyle(color: Colors.black),
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
          AlertPage(),
          Container(
              color: Colors.red,
              child:
                  //const LogHistoryPage()
                  const AddLogsPage() //Center(child: Text('Page 3')), //Add log page
              ),
          const ImagePage(),
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
