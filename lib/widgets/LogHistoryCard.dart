import 'package:flutter/material.dart';
import 'package:estc_project/model/log_item.dart';
import 'package:intl/intl.dart';

class LogHistoryCard extends StatelessWidget {
  final LogItem log;

  const LogHistoryCard({
    Key? key,
    required this.log,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  String getDateText(DateTime time) {
    return DateFormat('dd\nMMM yyyy').format(time);
  }

  String getTimeText(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Center(
                      child: Text(
                        getDateText(log.time),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LogID: ${log.logId}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Gio: ${getTimeText(log.time)}'),
                      Text('Ghi chu: ${log.note}'),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => {onPressed!()},
                  child: const Icon(
                    Icons.edit,
                    color: Colors.pink,
                    size: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
