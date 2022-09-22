import 'package:flutter/material.dart';

import '../util/share_preference_util.dart';
import '../widgets/list_item.dart';

class AlertPage extends StatefulWidget {
  final listItem = List<ListItem>.generate(
    100,
    (i) => i % 6 == 0
        ? HeadingItem('Heading $i')
        : MessageItem('Sender $i', 'Message body $i'),
  );

  AlertPage({Key? key}) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  String _token = '';

  @override
  void initState() {
    super.initState();
    prepare();
  }

  Future<void> prepare() async {
    var token = await SharedPreferenceUtil().getFcmToken();
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Token:\n $_token'),
      ),
    );
    /*return Scaffold(
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: widget.listItem.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = widget.listItem[index];

          return ListTile(
            title: item.buildTitle(context),
            subtitle: item.buildSubTitle(context),
          );
        },
      ),
    );*/
  }
}
