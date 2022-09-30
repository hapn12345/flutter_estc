import 'package:flutter/material.dart';

class AlertDetailPage extends StatefulWidget {
  final String alertId;

  const AlertDetailPage({super.key, required this.alertId});

  @override
  State<AlertDetailPage> createState() => _AlertDetailPageState();
}

class _AlertDetailPageState extends State<AlertDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert ${widget.alertId}'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Title: ${widget.alertId}'), const Text('Description')],
      )),
    );
  }
}
