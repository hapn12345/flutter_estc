import 'package:flutter/material.dart';

import '../routing/route_state.dart';
import '../widgets/auth.dart';
import '../widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  bool _showTextLoginFailed = false;
  TextEditingController userControllerName = TextEditingController();
  TextEditingController passWordControllerName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    userControllerName.dispose();
    passWordControllerName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _forgotPassword(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: const [
        Text(
          "Đăng Nhập",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Vui lòng nhập tài khoản mật khẩu"),
      ],
    );
  }

  _inputField(context) {
    final authState = BookstoreAuthScope.of(context);
    final routeState = RouteStateScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextFormField(
          key: widget.key,
          labelText: "Địa chỉ IP",
          iconPrefix: Icons.location_on,
          isShowIconSufix: false,
          passwordVisible: _passwordVisible,
          iconSufixListener: () {},
          textFieldController: null,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          key: widget.key,
          labelText: "Tài Khoản",
          iconPrefix: Icons.person,
          passwordVisible: _passwordVisible,
          isShowIconSufix: false,
          iconSufixListener: () {},
          textFieldController: userControllerName,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          key: widget.key,
          labelText: "Mật Khẩu",
          iconPrefix: Icons.lock,
          passwordVisible: _passwordVisible,
          isShowIconSufix: true,
          iconSufixListener: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          textFieldController: passWordControllerName,
        ),
        _showTextLoginFailed
            ? const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  'Đăng nhập thất bại',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final username = userControllerName.text.toString();
              final password = passWordControllerName.text.toString();

              var signedIn = await authState.signIn(username, password);
              if (signedIn) {
                await routeState.go('/home');
              }

              /*NetWorkRequest().login(
                username,
                password,
                () async {
                  var signedIn = await authState.signIn(username, password);
                  if (signedIn) {
                    await routeState.go('/home');
                  }
                },
                () {
                  setState(() {
                    _showTextLoginFailed = true;
                  });
                },
              ).then((value) => SharedPreferenceUtil().setToken(value));*/
            } else {
              setState(() {
                _showTextLoginFailed = false;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            "Đăng Nhập",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(onPressed: () {}, child: const Text("Quên mật khẩu?"));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Bạn chưa có tài khoản? "),
        TextButton(onPressed: () {}, child: const Text("Đăng Ký"))
      ],
    );
  }
}
