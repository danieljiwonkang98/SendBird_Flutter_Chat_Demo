import 'package:app/controllers/channel_controller.dart';
import 'package:app/routes/chatroom_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageCard extends StatelessWidget {
  final BaseChannel _channel = Get.find<ChannelController>();
  final int messageId;
  final String? message;
  final String? userName;
  MessageCard({Key? key, this.message, this.userName, required this.messageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(message ?? ""),
        subtitle: Text(userName ?? ""),
        trailing: GestureDetector(
          onTap: () {
            _channel.deleteMessage(messageId).then((_) => {
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
