import 'package:estc_project/util/constants.dart';
import 'package:estc_project/util/log_util.dart';
import 'package:estc_project/widgets/priority_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/log_item.dart';
import '../../widgets/my_text_field.dart';
import 'dart:math';

import '../../widgets/account_picker.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/log_id_picker.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class EditLogPage extends StatefulWidget {
  @override
  State<EditLogPage> createState() => _EditLogPageState();

  const EditLogPage({super.key, required this.log});
  final LogItem log;
}

class _EditLogPageState extends State<EditLogPage> {
  late MyDatePicker datePicker;
  late LogIDPicker logIDPicker;
  late AccountPicker accountPicker;
  late PriorityPicker priorityPicker;

  @override
  void initState() {
    super.initState();
    datePicker = MyDatePicker(dateTime: widget.log.time);
    logIDPicker = LogIDPicker(logID: widget.log.logId);
    accountPicker = AccountPicker(accountName: widget.log.accountName);
    priorityPicker = PriorityPicker(priority: widget.log.prority);
  }

  var listController = List<TextEditingController>.generate(
      3, (index) => TextEditingController());

  @override
  void dispose() {
    for (var element in listController) {
      element.dispose();
    }
    super.dispose();
  }

  void editLog(String key, LogItem log) {
    var box = Hive.box<LogItem>(Constants.logItemTable);
    box.put(key, log);
    LogUtil.d(tag: 'KhaiTQ', 'edited log');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).editLog,
            style: const TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(shrinkWrap: true, children: [
          Row(
            children: [
              Expanded(child: logIDPicker),
              const SizedBox(width: 10.0),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: datePicker,
              ))
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          accountPicker,
          const SizedBox(
            height: 10.0,
          ),
          MyTextField(
            id: 'diary_type',
            title: AppLocalizations.of(context).diaryType,
            controller: listController[0],
            text: widget.log.diaryType,
          ),
          const SizedBox(
            height: 10.0,
          ),
          priorityPicker,
          const SizedBox(
            height: 10.0,
          ),
          MyTextField(
            id: 'note',
            title: AppLocalizations.of(context).note,
            controller: listController[1],
            text: widget.log.note,
          ),
          const SizedBox(
            height: 10.0,
          ),
          MyTextField(
            id: 'description',
            title: AppLocalizations.of(context).description,
            controller: listController[2],
            text: widget.log.description,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              const Spacer(),
              SizedBox(
                height: 40.0,
                child: ElevatedButton(
                    onPressed: () {
                      var logItem = LogItem(
                          key: widget.log.key,
                          logId: logIDPicker.logID,
                          time: datePicker.dateTime,
                          accountName: accountPicker.accountName,
                          diaryType: listController[0].text,
                          prority: widget.log.prority,
                          note: listController[1].text,
                          description: listController[2].text);
                      LogUtil.d(
                          tag: 'KhaiTQ', 'editing  ${logItem.toString()}');
                      editLog(widget.log.key, logItem);
                    },
                    child: Text(AppLocalizations.of(context).saveChanged)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
