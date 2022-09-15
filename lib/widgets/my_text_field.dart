import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
    super.key,
    required this.id,
    required this.title,
    required this.controller,
    this.text = "",
  });

  final String id;
  final String title;
  final TextEditingController controller;
  String text;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        SizedBox(
          height: 40.0,
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: widget.controller,
          ),
        ),
      ],
    );
  }
}
