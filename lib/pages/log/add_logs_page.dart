import 'package:estc_project/model/log_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:estc_project/widgets/MyTextField.dart';

import '../../util/constants.dart';

class AddLogsPage extends StatefulWidget {
  const AddLogsPage({Key? key}) : super(key: key);

  @override
  State<AddLogsPage> createState() => _AddLogsPage();
}

class _AddLogsPage extends State<AddLogsPage> {
  var logIdValue = Constants.logIds.first;
  var prorityValue = Constants.prorities.first;
  var time = DateTime.now();
  var listController = List<TextEditingController>.generate(
      4, (index) => TextEditingController());

  @override
  void dispose() {
    listController.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  void saveLog(LogItem log) {
    var box = Hive.box<LogItem>(Constants.LOG_ITEM_TABLE);
    box.put('${log.accountName}-${log.time.toString()}', log);
    debugPrint('KhaiTQ- saved log');
    resetField();
    Fluttertoast.showToast(
        msg: "Saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
    //reset fields
  }

  void resetField() {
    listController.forEach((element) {
      element.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(padding: const EdgeInsets.all(8.0), children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('LogID'),
                        InputDecorator(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: logIdValue,
                              onChanged: (String? value) {
                                setState(() {
                                  logIdValue = value!;
                                });
                              },
                              items: Constants.logIds
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              //Flexible(child: MyTextField(id: 'time', title: 'Thoi gian')),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thoi gian'),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2018, 3, 5),
                                    maxTime: DateTime(2019, 6, 7),
                                    onChanged: (date) {
                                  debugPrint(
                                      'change $date in time zone ${date.timeZoneOffset.inHours}');
                                }, onConfirm: (date) {
                                  setState(() {
                                    time = date;
                                  });
                                  debugPrint('confirm $date');
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              child: Text(
                                '${DateFormat('yyyy-MM-dd').format(time)}',
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
          MyTextField(
            id: 'account_name',
            title: 'Ten tai khoan',
            controller: listController[0],
          ),
          MyTextField(
            id: 'diary_type',
            title: 'Loai nhat ky',
            controller: listController[1],
          ),
          //MyTextField(id: 'priority', title: 'Muc uu tien'),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Muc uu tien'),
                InputDecorator(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: prorityValue,
                      onChanged: (String? value) {
                        setState(() {
                          prorityValue = value!;
                        });
                      },
                      isExpanded: true,
                      items: Constants.prorities
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ]),
          MyTextField(
            id: 'note',
            title: 'Ghi chu',
            controller: listController[2],
          ),
          MyTextField(
            id: 'description',
            title: 'Mo ta',
            controller: listController[3],
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                child: SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        var logItem = LogItem(
                            logId: logIdValue,
                            time: time,
                            accountName: listController[0].text,
                            diaryType: listController[1].text,
                            prority: prorityValue,
                            note: listController[2].text,
                            description: listController[3].text);
                        debugPrint(
                            'KhaiTQ - tao trang thai ${logItem.toString()}');
                        saveLog(logItem);
                      },
                      child: const Text('Tao trang thai')),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
