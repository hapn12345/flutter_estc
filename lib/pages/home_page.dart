import 'package:estc_project/pages/alert_page.dart';
import 'package:estc_project/pages/log/add_logs_page.dart';
import 'package:estc_project/pages/log/log_history_page.dart';
import 'package:estc_project/pages/user/user_page.dart';
import 'package:estc_project/util/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isHasActionButtons = false;
  int _selectedIndex = 0;

  void setSeleletedIndex(int value) {
    setState(() {
      _selectedIndex = value;
      _isHasActionButtons =
          (value == 1 || value == 2) ? true : false; //alert and add logs page
    });
  }

  final controller = PageController();
  final notificationApi = NotificationApi();

  late final VoidCallback historyAction;

  @override
  void initState() {
    super.initState();
    NotificationApi.initialseNotifications();
    NotificationApi.isAndroidPermissionGranted();
    NotificationApi.requestPermissions();
    listenNotifications();
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return AppLocalizations.of(context).homePage;
      case 1:
        return AppLocalizations.of(context).alert;
      case 2:
        return AppLocalizations.of(context).addLogs;
      default:
        return AppLocalizations.of(context).user;
    }
  }

  void _onItemTapped(int index) {
    controller.animateToPage(index,
        duration: const Duration(microseconds: 500), curve: Curves.easeIn);
    setSeleletedIndex(index);
    switch (index) {
      case 0:
        break;
      case 1:
        NotificationApi.showNotifications(
          body: '123123',
          payload: '21312321.a',
          title: '123123123',
        );
        break;
      case 2:
        break;
      case 3:
        break;
    }
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          getTitle(_selectedIndex),
          style: const TextStyle(color: Colors.black),
        ),
        actions: _isHasActionButtons
            ? (_selectedIndex == 1
                ? [
                    //refresh
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ),
                    ),
                    //filter
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_alt,
                        color: Colors.black,
                      ),
                    )
                  ]
                : [
                    //edit
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                    //history
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
                  ])
            : [],
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setSeleletedIndex(index);
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
          const UserPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context).homePage,
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.error_outline_outlined),
            label: AppLocalizations.of(context).alert,
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: AppLocalizations.of(context).addLogs,
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppLocalizations.of(context).user,
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
