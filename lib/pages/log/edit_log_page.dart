import 'package:estc_project/pages/log/add_logs_page.dart';
import 'package:estc_project/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../model/log_item.dart';
import '../../widgets/MyTextField.dart';

class EditLogPage extends StatefulWidget {
  @override
  State<EditLogPage> createState() => _EditLogPageState();

  const EditLogPage({super.key, required this.log});
  final LogItem log;
}

class _EditLogPageState extends State<EditLogPage> {
  late String key;

  @override
  void initState() {
    super.initState();
    key = '${widget.log.accountName}-${widget.log.time.toString()}';
  }

  var listController = List<TextEditingController>.generate(
      4, (index) => TextEditingController());

  @override
  void dispose() {
    listController.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  void editLog(String key, LogItem log) {
    var box = Hive.box<LogItem>(Constants.LOG_ITEM_TABLE);
    box.put(key, log);
    debugPrint('KhaiTQ- edited log');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Chinh sua trang thai',
            style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
                              value: widget.log.logId,
                              onChanged: (String? value) {
                                setState(() {
                                  widget.log.logId = value!;
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
                                    widget.log.time = date;
                                  });
                                  debugPrint('confirm $date');
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              child: Text(
                                '${DateFormat('yyyy-MM-dd').format(widget.log.time)}',
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
            text: widget.log.accountName,
          ),
          MyTextField(
            id: 'diary_type',
            title: 'Loai nhat ky',
            controller: listController[1],
            text: widget.log.diaryType,
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
                      value: widget.log.prority,
                      onChanged: (String? value) {
                        setState(() {
                          widget.log.prority = value!;
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
            text: widget.log.note,
          ),
          MyTextField(
            id: 'description',
            title: 'Mo ta',
            controller: listController[3],
            text: widget.log.description,
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
                            logId: widget.log.logId,
                            time: widget.log.time,
                            accountName: listController[0].text,
                            diaryType: listController[1].text,
                            prority: widget.log.prority,
                            note: listController[2].text,
                            description: listController[3].text);
                        debugPrint(
                            'KhaiTQ - tao trang thai ${logItem.toString()}');
                        editLog(key, logItem);
                      },
                      child: const Text('Save trang thai')),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
