import 'package:estc_project/network/network_request.dart';
import 'package:flutter/material.dart';

import '../models/album.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List<Album> albumData = [];

  @override
  void initState() {
    super.initState();
    NetWorkRequest().fetchAlbum().then(
          (dataFromServer) => {
            setState(
              () {
                albumData = dataFromServer;
              },
            )
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: albumData.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                  child: Text(
                    'id: ${albumData[index].id}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.amberAccent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                  child: Text(
                    'title: ${albumData[index].title}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                  child: Text(
                    'userId: ${albumData[index].userId}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
