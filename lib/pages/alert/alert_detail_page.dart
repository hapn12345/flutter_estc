import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:estc_project/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

typedef OnError = void Function(Exception exception);

class AlertDetailPage extends StatefulWidget {
  final String alertId;

  const AlertDetailPage({super.key, required this.alertId});

  @override
  State<AlertDetailPage> createState() => _AlertDetailPageState();
}

class _AlertDetailPageState extends State<AlertDetailPage> {
  AudioPlayer player = AudioPlayer()..setReleaseMode(ReleaseMode.loop);

  List<StreamSubscription> streams = [];

  @override
  void initState() {
    super.initState();
    streams.add(player.onPlayerComplete.listen((event) {
      LogUtil.d('Player complete!');
    }));
    streams.add(player.onSeekComplete.listen((event) {
      LogUtil.d('Seek complete!');
    }));
    preparePlayer();
  }

  Future<void> preparePlayer() async {
    await player.play(AssetSource('alarm.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert ${widget.alertId}'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/alert-exclamation.json'),
          Text('Title: ${widget.alertId}'),
          const Text('Description'),
          ElevatedButton(
              onPressed: () async {
                await player.release();
              },
              child: const Text('Stop'))
        ],
      )),
    );
  }

  @override
  void dispose() {
    for (var it in streams) {
      it.cancel();
    }
    player.release();
    super.dispose();
  }
}
