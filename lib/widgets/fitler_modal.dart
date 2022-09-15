import 'package:estc_project/widgets/date_picker.dart';
import 'package:estc_project/widgets/log_id_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../util/constants.dart';

typedef ConfirmSearchCallback = Function(DateTime date, String logID);

class FilterByDateModal extends StatefulWidget {
  @override
  State<FilterByDateModal> createState() => _FilterByDateModalState();

  ConfirmSearchCallback callback;

  FilterByDateModal({super.key, required this.callback});
}

class _FilterByDateModalState extends State<FilterByDateModal> {
  MyDatePicker datePicker = MyDatePicker(dateTime: DateTime.now());
  LogIDPicker logIDPicker = LogIDPicker(logID: Constants.logIds.first);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          datePicker,
          const SizedBox(
            height: 10.0,
          ),
          logIDPicker,
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Spacer(),
              TextButton(
                onPressed: () {
                  var date = datePicker.dateTime;
                  var logID = logIDPicker.logID;
                  Navigator.of(context).pop();
                  print('KhaiTQ-search logs in: $date and logId: $logID');
                  widget.callback(date, logID);
                },
                child: Text(AppLocalizations.of(context).search,
                    style: const TextStyle(color: Colors.black)),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    print('KhaiTQ-close modal');
                  },
                  child: Text(AppLocalizations.of(context).close)),
            ],
          )
        ],
      ),
    );
  }
}
