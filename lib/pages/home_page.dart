// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:estc_project/pages/user/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:estc_project/network/network_request.dart';
import 'package:estc_project/pages/alert_page.dart';
import 'package:estc_project/pages/log/add_logs_page.dart';
import 'package:estc_project/pages/log/log_history_page.dart';
import 'package:estc_project/pages/user/user_page.dart';
import 'package:estc_project/util/shared_preference_util.dart';

import '../util/notification_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isHasActionButtons = false;
  int _selectedIndex = 0;
  String setTokenToLocalStorage =
      "localStorage.setItem('aT', '${SharedPreferenceUtil().getToken()}');";
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
        /*NotificationApi.showNotifications(
          body: '123123',
          payload: '21312321.a',
          title: '123123123',
        );*/
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
        backgroundColor: Colors.blue,
        title: Text(
          getTitle(_selectedIndex),
          style: const TextStyle(color: Colors.white),
        ),
        actions: _isHasActionButtons
            ? (_selectedIndex == 1
                ? [
                    //refresh
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    ),
                    //filter
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_alt,
                        color: Colors.white,
                      ),
                    )
                  ]
                : [
                    //edit
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
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
                        color: Colors.white,
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
          KeepAlivePage(
            key: widget.key,
            child: WebView(
              initialUrl: NetWorkRequest.baseUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                webViewController.runJavascript(setTokenToLocalStorage);
              },
            ),
          ),
          AlertPage(),
          Container(
              color: Colors.red,
              child:
                  //const LogHistoryPage()
                  const AddLogsPage() //Center(child: Text('Page 3')), //Add log page
              ),
          const KeepAlivePage(child: SettingPage()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context).homePage,
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.error_outline_outlined),
            label: AppLocalizations.of(context).alert,
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.note),
            label: AppLocalizations.of(context).addLogs,
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context).user,
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  const KeepAlivePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  KeepAlivePageState createState() => KeepAlivePageState();
}

class KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
