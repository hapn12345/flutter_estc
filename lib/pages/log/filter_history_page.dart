import 'package:estc_project/widgets/log_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../models/log_item.dart';
import '../../util/constants.dart';
import 'edit_log_page.dart';

class FilterHistoryPage extends StatelessWidget {
  DateTime date;
  String logID;
  FilterHistoryPage({
    Key? key,
    required this.date,
    required this.logID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).seachResults,
            style: const TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ValueListenableBuilder<Box>(
          valueListenable:
              Hive.box<LogItem>(Constants.LOG_ITEM_TABLE).listenable(),
          builder: (context, box, widget) {
            var dataList = box.values.toList() as List<LogItem>;
            var filtedList = dataList.where((log) =>
                (log.time.year == date.year &&
                    log.time.month == date.month &&
                    log.time.day == date.day &&
                    log.logId == logID));
            print('KhaiTQ-filted in date $date: $filtedList');
            return filtedList.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context).noAnyResult),
                  )
                : ListView.builder(
                    itemCount: filtedList.length,
                    itemBuilder: (context, index) {
                      var log = filtedList.elementAt(index);
                      return LogHistoryCard(
                        log: log,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditLogPage(log: log),
                          ));
                        },
                      );
                    });
          }),
    );
  }
}
