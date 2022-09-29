import 'package:estc_project/network/network_request.dart';
import 'package:estc_project/pages/login_page.dart';
import 'package:estc_project/util/app_theme.dart';
import 'package:flutter/material.dart';
import '../../app.dart';
import '/models/user.dart';
import '/util/constants.dart';
import '/util/log_util.dart';
import '/util/shared_preference_util.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _UserPageState();
}

class _UserPageState extends State<SettingPage> {
  VoidCallback? onTapImageProfile;
  bool _isVietnamese = false;
  bool _isDarkMode = SharedPreferenceUtil().getDarkMode();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    cirleAvatarProfile("images/relax_image.png", () {}),
                    buildEditIcon()
                  ],
                ),
              ),
              const SizedBox(height: 1),
              settingSwitchButton(
                context,
                "Language",
                Switch(
                  value: _isVietnamese,
                  onChanged: (bool isVietnamese) {
                    setState(() {
                      _isVietnamese = isVietnamese;
                    });
                    MyApp.of(context).then(
                      (app) {
                        app!.setLocale(isVietnamese
                            ? Constants.localeVN
                            : Constants.localeEN);
                      },
                    );
                  },
                ),
              ),
              settingSwitchButton(
                context,
                "Dark mode",
                Switch(
                  value: _isDarkMode,
                  onChanged: (bool isDarkMode) {
                    setState(() {
                      _isDarkMode = isDarkMode;
                    });
                    SharedPreferenceUtil().setDarkMode(_isDarkMode);
                    if (_isDarkMode) {
                      MyApp.of(context).then((app) {
                        app!.setThemeMode(AppTheme().darkTheme);
                      });
                    } else {
                      MyApp.of(context).then((app) {
                        app!.setThemeMode(AppTheme().lightTheme);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 1),
              infoUser(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Đăng Xuất",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<User> infoUser() {
    return FutureBuilder(
      future: NetWorkRequest().getInfoUser(4),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data as User;
          return Column(
            children: [
              BuildInfoUser(
                nameField: "Id",
                valueField: user.id.toString(),
              ),
              BuildInfoUser(
                nameField: "User Name",
                valueField: user.username,
              ),
              BuildInfoUser(
                nameField: "Role",
                valueField: user.role,
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Row settingSwitchButton(
    BuildContext context,
    String nameButton,
    Widget child,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.settings,
          color: Colors.blue,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              nameButton,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        child,
      ],
    );
  }

  buildEditIcon() {
    return Positioned(
      bottom: 0,
      right: 3,
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue,
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class BuildInfoUser extends StatelessWidget {
  const BuildInfoUser({
    required this.nameField,
    required this.valueField,
    Key? key,
  }) : super(key: key);
  final String? nameField;
  final String? valueField;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameField!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    valueField!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.0,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.blue,
                    size: 32.0,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

cirleAvatarProfile(String image, VoidCallback? callback) {
  return ClipOval(
    child: Material(
      child: Ink.image(
        image: Image.asset(image).image,
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: InkWell(
          onTap: callback,
        ),
      ),
    ),
  );
}
