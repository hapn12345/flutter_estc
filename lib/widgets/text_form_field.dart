import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.iconPrefix,
    required this.isShowIconSufix,
    required this.iconSufixListener,
    required this.passwordVisible,
    required this.textFieldController,
  }) : super(key: key);

  final String labelText;
  final IconData iconPrefix;
  final bool isShowIconSufix;
  final bool passwordVisible;
  final VoidCallback iconSufixListener;
  final TextEditingController? textFieldController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Vui lòng không để trống';
        }
        return null;
      },
      obscureText: isShowIconSufix ? !passwordVisible : false,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
          borderSide: BorderSide(color: Colors.blue, width: 0.1),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(iconPrefix),
        suffixIcon: isShowIconSufix
            ? IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  iconSufixListener.call();
                  // Update the state i.e. toogle the state of passwordVisible variable
                },
              )
            : null,
      ),
    );
  }
}
