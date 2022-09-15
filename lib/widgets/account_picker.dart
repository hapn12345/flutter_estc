// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:estc_project/util/share_preference_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPicker extends StatefulWidget {
  String accountName;

  AccountPicker({
    Key? key,
    required this.accountName,
  }) : super(key: key);

  @override
  State<AccountPicker> createState() => _AccountPickerState();
}

class _AccountPickerState extends State<AccountPicker> {
  List<String> accountList = [''];
  late String _accountName;

  @override
  void initState() {
    super.initState();
    _accountName = accountList.first;
    prepare();
  }

  Future<void> prepare() async {
    var tmp = await SharedPreferenceUtil().getAccountList();
    setState(() {
      accountList = tmp;
      _accountName = accountList.first;
      widget.accountName = _accountName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).accountName,
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
                value: _accountName,
                onChanged: (String? value) {
                  setState(() {
                    widget.accountName = value!;
                    _accountName = value;
                  });
                },
                isExpanded: true,
                items:
                    accountList.map<DropdownMenuItem<String>>((String value) {
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
