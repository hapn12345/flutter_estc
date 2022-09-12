import 'package:estc_project/main.dart';
import 'package:flutter/material.dart';

import '../../util/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../util/share_preference_util.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _isVietnamese = false;

  @override
  void initState() {
    super.initState();
    prepare();
  }

  Future<void> prepare() async {
    var languageCode = await SharedPreferenceUtil().getLanguageCode();
    setState(() {
      _isVietnamese = (languageCode == 'vi');
    });
    print('KhaiTQ-isVietnamese:$_isVietnamese');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Ngôn ngữ Tiếng Việt'),
        Switch(
            value: _isVietnamese,
            onChanged: (bool isVietnamese) {
              setState(() {
                _isVietnamese = isVietnamese;
              });
              MyApp.of(context).then((app) {
                app!.setLocale(
                    isVietnamese ? Constants.LOCALE_VN : Constants.LOCALE_EN);
              });
            }),
      ],
    ));
  }
}
