import 'package:flutter/material.dart';

import '../util/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PriorityPicker extends StatefulWidget {
  @override
  State<PriorityPicker> createState() => _PriorityPickerState();

  String priority;

  PriorityPicker({
    Key? key,
    required this.priority,
  }) : super(key: key);
}

class _PriorityPickerState extends State<PriorityPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).prority,
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
                value: widget.priority,
                onChanged: (String? value) {
                  setState(() {
                    widget.priority = value!;
                  });
                },
                isExpanded: true,
                items: Constants.prorities
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
