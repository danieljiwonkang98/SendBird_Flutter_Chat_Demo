import 'package:flutter/material.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';

class ChannelCard extends StatefulWidget {
  final List<GroupChannel> groupChannel;
  final double horizontalPadding;
  const ChannelCard(
      {Key? key, required this.groupChannel, this.horizontalPadding = 20})
      : super(key: key);

  @override
  _ChannelCardState createState() => _ChannelCardState();
}

class _ChannelCardState extends State<ChannelCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.groupChannel.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
          child: GestureDetector(
            onTap: () {
              //TODO Enter Channel Room
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
