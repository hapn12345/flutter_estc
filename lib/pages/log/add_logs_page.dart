import 'package:estc_project/models/log_item.dart';
import 'package:estc_project/pages/log/edit_log_page.dart';
import 'package:estc_project/widgets/account_picker.dart';
import 'package:estc_project/widgets/date_picker.dart';
import 'package:estc_project/widgets/log_id_picker.dart';
import 'package:estc_project/widgets/priority_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:estc_project/widgets/my_text_field.dart';

import '../../util/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddLogsPage extends StatefulWidget {
  const AddLogsPage({Key? key}) : super(key: key);

  @override
  State<AddLogsPage> createState() => _AddLogsPage();
}

class _AddLogsPage extends State<AddLogsPage> {
  MyDatePicker datePicker = MyDatePicker(dateTime: DateTime.now());
  LogIDPicker logIDPicker = LogIDPicker(logID: Constants.logIds.first);
  AccountPicker accountPicker = AccountPicker(accountName: '');
  PriorityPicker priorityPicker =
      PriorityPicker(priority: Constants.prorities.first);

  var listController = List<TextEditingController>.generate(
      3, (index) => TextEditingController());

  @override
  void dispose() {
    for (var element in listController) {
      element.dispose();
    }
    super.dispose();
  }

  void saveLog(LogItem log) {
    var box = Hive.box<LogItem>(Constants.LOG_ITEM_TABLE);
    box.put(log.key, log);
    debugPrint('KhaiTQ- saved log');
    resetField();
    Fluttertoast.showToast(
        msg: AppLocalizations.of(context).saved,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void resetField() {
    for (var element in listController) {
      element.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(shrinkWrap: true, children: [
          Row(
            children: [
              Expanded(
                child: logIDPicker,
              ),
              const SizedBox(width: 10.0),
              Expanded(child: datePicker)
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
          ),
          const SizedBox(
            height: 10.0,
          ),
          MyTextField(
            id: 'description',
            title: AppLocalizations.of(context).description,
            controller: listController[2],
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
                          key: getRandomString(15),
                          logId: logIDPicker.logID,
                          time: datePicker.dateTime,
                          accountName: accountPicker.accountName,
                          diaryType: listController[0].text,
                          prority: priorityPicker.priority,
                          note: listController[1].text,
                          description: listController[2].text);
                      debugPrint(
                          'KhaiTQ - tao trang thai ${logItem.toString()}');
                      saveLog(logItem);
                    },
                    child: Text(AppLocalizations.of(context).createLogs)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
