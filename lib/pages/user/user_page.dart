import 'package:estc_project/main.dart';
import 'package:estc_project/util/log_util.dart';
import 'package:flutter/material.dart';
import '../../app.dart';
import '../../util/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../util/shared_preference_util.dart';
import '../../widgets/auth.dart';

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
    LogUtil.d(tag: 'KhaiTQ', 'isVietnamese:$_isVietnamese');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).user),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Ngôn ngữ Tiếng Việt'),
          Switch(
              value: _isVietnamese,
              onChanged: (bool isVietnamese) {
                setState(() {
                  _isVietnamese = isVietnamese;
                });
                MyApp.of(context).then((app) {
                  app!.setLocale(
                      isVietnamese ? Constants.localeVN : Constants.localeEN);
                });
              }),
          ElevatedButton(
              onPressed: () {
                BookstoreAuthScope.of(context).signOut();
              },
              child: const Text('Đăng xuất'))
        ],
      )),
    );
  }
}
