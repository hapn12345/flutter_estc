import 'package:estc_project/model/log_item.dart';
import 'package:estc_project/pages/log/edit_log_page.dart';
import 'package:estc_project/widgets/LogHistoryCard.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../util/constants.dart';

class LogHistoryPage extends StatelessWidget {
  const LogHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:
              const Text('Lịch sử thêm', style: TextStyle(color: Colors.black)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ValueListenableBuilder<Box>(
            valueListenable:
                Hive.box<LogItem>(Constants.LOG_ITEM_TABLE).listenable(),
            builder: (context, box, widget) {
              return ListView.builder(
                itemCount: box.values.length,
                prototypeItem: LogHistoryCard(log: box.values.first),
                itemBuilder: (context, index) {
                  var log = box.values.toList()[index];
                  return LogHistoryCard(
                    log: log,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditLogPage(log: log),
                      ));
                    },
                  );
                },
              );
            }));
  }
}
