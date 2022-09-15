import 'package:estc_project/util/log_util.dart';
import 'package:estc_project/widgets/log_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/log_item.dart';
import '../../util/constants.dart';
import 'edit_log_page.dart';

class FilterHistoryPage extends StatefulWidget {
  DateTime date;
  String logID;
  FilterHistoryPage({
    Key? key,
    required this.date,
    required this.logID,
  }) : super(key: key);

  @override
  State<FilterHistoryPage> createState() => _FilterHistoryPageState();
}

class _FilterHistoryPageState extends State<FilterHistoryPage> {
  late DateTime date;
  late String logID;

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
  void initState() {
    super.initState();
    date = widget.date;
    logID = widget.logID;
  }

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
              Hive.box<LogItem>(Constants.logItemTable).listenable(),
          builder: (context, box, widget) {
            var dataList = box.values.toList() as List<LogItem>;
            var filtedList = dataList.where((log) =>
                (log.time.year == date.year &&
                    log.time.month == date.month &&
                    log.time.day == date.day &&
                    log.logId == logID));
            LogUtil.d(
                tag: 'KhaiTQ',
                'filted in date ${date} and logId: $logID: $filtedList');
            return filtedList.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context).noAnyResult),
                  )
                : ListView.builder(
                    itemCount: filtedList.length,
                    itemBuilder: (context, index) {
                      var log = filtedList.elementAt(index);
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(log.key),
                        onDismissed: ((direction) {
                          deleteLog(log);
                        }),
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
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditLogPage(log: log),
                            ));
                          },
                        ),
                      );
                    });
          }),
    );
  }
}
