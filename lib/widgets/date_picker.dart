import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatefulWidget {
  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
  DateTime dateTime;
  MyDatePicker({
    super.key,
    required this.dateTime,
  });
}

class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).date,
          textAlign: TextAlign.start,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                          BorderRadius.circular(5.0) //border of dropdown button
                      ),
                  child: OutlinedButton(
                    child: Row(
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd').format(widget.dateTime),
                          textAlign: TextAlign.start,
                          style: const TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        const Icon(Icons.calendar_today)
                      ],
                    ),
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2000, 1, 1),
                          maxTime: DateTime(2050, 1, 1), onChanged: (date) {
                        debugPrint(
                            'change $date in time zone ${date.timeZoneOffset.inHours}');
                      }, onConfirm: (date) {
                        setState(() {
                          widget.dateTime = date;
                        });
                        debugPrint('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.vi);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
