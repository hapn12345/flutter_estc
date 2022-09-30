import 'package:estc_project/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../routing/route_state.dart';
import '../../util/shared_preference_util.dart';
import '../../widgets/list_item.dart';

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
    final routeState = RouteStateScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).alert),
        actions: [
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
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Token:\n $_token'),
            ElevatedButton(
              onPressed: () {
                routeState.go('/alert/alert_Id_fake');
              },
              child: const Text('Open detail alert description'),
            ),
            ElevatedButton(
              onPressed: () {
                MyApp.of(context).then((value) => value!.testAlertSound());
              },
              child: const Text('Test sound alert'),
            )
          ],
        ),
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
