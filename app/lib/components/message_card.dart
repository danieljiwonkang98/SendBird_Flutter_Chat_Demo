import 'dart:io';
import 'dart:ui';
import 'package:app/controllers/channel_controller.dart';
import 'package:app/routes/chatroom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:isolate';

import 'package:permission_handler/permission_handler.dart';

class MessageCard extends StatefulWidget {
  final dynamic messageData;
  const MessageCard({Key? key, required this.messageData}) : super(key: key);

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  final ReceivePort _port = ReceivePort();
  late BaseChannel _channel;
  late String _taskId;

  Future download(String url) async {
    String baseStorage = "";
    var status = await Permission.storage.request();

    if (status.isGranted) {
      if (Platform.isAndroid) {
        //TODO
        // try {
        //   externalStorageDirPath = await AndroidPathProvider.downloadsPath;
        // } catch (e) {
        //   final directory = await getExternalStorageDirectory();
        //   externalStorageDirPath = directory?.path;
        // }
      } else if (Platform.isIOS) {
        baseStorage = (await getApplicationDocumentsDirectory()).path;
      }
      print("basestorage: ");
      print(baseStorage);

      _taskId = (await FlutterDownloader.enqueue(
          headers: {"Api-Token": dotenv.env["MASTER_API_TOKEN"]!},
          url: "https://download.samplelib.com/mp4/sample-5s.mp4",
          savedDir: baseStorage))!;
    }
    setState(() {});
  }

  @override
  void initState() {
    _channel = Get.find<ChannelController>();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print("Download Completed");
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);

    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        leading: widget.messageData.customType == "file"
            ? GestureDetector(
                onTap: () async {
                  bool isOpen = await FlutterDownloader.open(taskId: _taskId);
                  print(isOpen);
                },
                child: const Text(
                  "Open",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            : null,
        title: widget.messageData.customType == "file"
            ? GestureDetector(
                onTap: () async {
                  //TODO REMOVE BELOW
                  await download("");
                  //TODO UNCOMMENT BELOW
                  // _taskId = (await downloadFileLocal(
                  // widget.messageData.url!, "file"))!;
                  setState(() {});
                },
                child: const Text(
                  "Download File",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            : Text(widget.messageData.message ?? ""),
        subtitle: Text(widget.messageData.sender.nickname ?? ""),
        trailing: GestureDetector(
          onTap: () {
            _channel.deleteMessage(widget.messageData.messageId).then((_) => {
                  ChatRoomRoute.globalKey.currentState!.refreshPage(),
                });
          },
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.delete)),
        ),
      ),
    );
  }
}
