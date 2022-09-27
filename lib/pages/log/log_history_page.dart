import 'package:estc_project/models/log_item.dart';
import 'package:estc_project/pages/log/edit_log_page.dart';
import 'package:estc_project/util/log_util.dart';
import 'package:estc_project/widgets/log_history_card.dart';
import 'package:estc_project/widgets/fitler_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../routing/route_state.dart';
import '../../util/constants.dart';

class LogHistoryPage extends StatefulWidget {
  const LogHistoryPage({super.key});

  @override
  State<LogHistoryPage> createState() => _LogHistoryPageState();
}

class _LogHistoryPageState extends State<LogHistoryPage> {
  Future<void> deleteLog(LogItem log) async {
    var box = Hive.box<LogItem>(Constants.logItemTable);
    box.delete(log.key);
    LogUtil.d(tag: 'KhaiTQ', 'deleted: $log');
    Fluttertoast.showToast(
        msg: AppLocalizations.of(context).deleted,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context).addLogsHistory),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: InkWell(
                onTap: () {
                  print('KhaiTQ-show Bottom sheet');
                  //show search modal
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    context: context,
                    builder: (context) => FilterByDateModal(
                      callback: ((date, logID) async {
                        LogUtil.d('KhaiTQ-filter logs in date: $date');
                        await RouteStateScope.of(context)
                            .go('/log/log_history/${date.toString()}&&$logID');
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => FilterHistoryPage(
                        //       date: date,
                        //       logID: logID,
                        //     ),
                        //   ),
                        // );
                      }),
                    ),
                  );
                },
                child: const Icon(
                  Icons.filter_list,
                  size: 24.0,
                ),
              ),
            )
          ],
        ),
        body: ValueListenableBuilder<Box>(
            valueListenable:
                Hive.box<LogItem>(Constants.logItemTable).listenable(),
            builder: (context, box, widget) {
              if (box.values.isEmpty) {
                return Center(
                    child: Text(AppLocalizations.of(context).emptyLogsMessage));
              } else {
                return GroupedListView<LogItem, String>(
                  elements: box.values.toList() as List<LogItem>,
                  groupBy: ((log) =>
                      DateFormat('yyyy-MMM-dd').format(log.time)),
                  groupComparator: (date1, date2) => date2.compareTo(date1),
                  itemComparator: (log1, log2) =>
                      log2.time.compareTo(log1.time),
                  order: GroupedListOrder.DESC,
                  groupSeparatorBuilder: (String value) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  itemBuilder: (c, log) {
                    return Dismissible(
                      key: Key(log.key),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          deleteLog(log);
                        });
                      },
                      background: Row(
                        children: const [
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              Icons.delete,
                              size: 30.0,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      child: LogHistoryCard(
                        log: log,
                        onPressed: () {
                          // RouteStateScope.of(context)
                          //     .go('/log/edit_log/${log.logId}');
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditLogPage(log: log),
                          ));
                        },
                      ),
                    );
                  },
                );
              }
            }));
  }
}
