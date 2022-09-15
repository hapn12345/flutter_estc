import 'package:flutter/material.dart';

import '../util/constants.dart';

class LogIDPicker extends StatefulWidget {
  @override
  State<LogIDPicker> createState() => _LogIDPickerState();

  String logID;

  LogIDPicker({
    Key? key,
    required this.logID,
  }) : super(key: key);
}

class _LogIDPickerState extends State<LogIDPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LogID',
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 40.0,
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius:
                    BorderRadius.circular(5.0) //border of dropdown button
                ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.logID,
                onChanged: (String? value) {
                  setState(() {
                    widget.logID = value!;
                  });
                },
                isExpanded: true,
                items: Constants.logIds
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(value),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
