import 'package:flutter/material.dart';
import 'package:estc_project/model/log_item.dart';

class LogHistoryCard extends StatelessWidget {
  final LogItem log;

  const LogHistoryCard({
    Key? key,
    required this.log,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {onPressed!()},
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: Text('date \n month year')),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${log.logId}'),
                      Text('${log.time.toString()}'),
                      Text('${log.note}'),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.edit,
                    color: Colors.pink,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
