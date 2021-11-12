import 'package:app/controllers/channel_controller.dart';
import 'package:app/routes/home_route.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:get/get.dart';

class ChannelCardList extends StatefulWidget {
  final List<GroupChannel> groupChannel;
  final double horizontalPadding;
  const ChannelCardList({
    Key? key,
    required this.groupChannel,
    this.horizontalPadding = 20,
  }) : super(key: key);

  @override
  _ChannelCardState createState() => _ChannelCardState();
}

class _ChannelCardState extends State<ChannelCardList> {
  late BaseChannel _channel;

  @override
  void initState() {
    _channel = Get.find<ChannelController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.groupChannel.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
          child: GestureDetector(
            onTap: () {
              _channel.setCurrentGroupChannel(widget.groupChannel[index]);
              Get.toNamed("/ChatRoomRoute",
                      arguments: [widget.groupChannel[index]])!
                  .then(
                (_) => HomeRoute.globalKey.currentState!.refreshPage(),
              );
            },
            child: Card(
              child: ListTile(
                leading: widget.groupChannel[index].coverUrl != null
                    ? Image.network(widget.groupChannel[index].coverUrl!)
                    : null,
                title: Text(widget.groupChannel[index].name ?? "[BLANK]"),
                subtitle:
                    Text(widget.groupChannel[index].lastMessage?.message ?? ""),
              ),
            ),
          ),
        );
      },
    );
  }
}
