import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../network/network_request.dart';
import '../util/shared_preference_util.dart';

String setTokenToLocalStorage =
    "localStorage.setItem('aT', '${SharedPreferenceUtil().getToken()}');";

class MyWebView extends StatelessWidget {
  const MyWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homePage),
      ),
      body: WebView(
        initialUrl: NetWorkRequest.baseUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          webViewController.runJavascript(setTokenToLocalStorage);
        },
      ),
    );
  }
}
