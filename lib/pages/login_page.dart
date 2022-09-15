import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Vui lòng không để trống';
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: "Địa chỉ IP",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.location_on)),
        ),
        const SizedBox(height: 10),
        TextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Vui lòng không để trống';
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: "Tài Khoản",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Vui lòng không để trống';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Mật Khẩu",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          obscureText: !_passwordVisible,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
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
        )
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

  static _password(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Invalid password!";
    }
    if (txt.length < 8) {
      return "Password must has 8 characters";
    }
    if (!txt.contains(RegExp(r'[A-Z]'))) {
      return "Password must has uppercase";
    }
    if (!txt.contains(RegExp(r'[0-9]'))) {
      return "Password must has digits";
    }
    if (!txt.contains(RegExp(r'[a-z]'))) {
      return "Password must has lowercase";
    }
    if (!txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
      return "Password must has special characters";
    } else {
      return;
    }
  }
}
