import 'package:app/components/inputfield.dart';
import 'package:app/components/message_card.dart';
import 'package:app/controllers/authentication_controller.dart';
import 'package:app/controllers/channel_controller.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:get/get.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';

class ChatRoomRoute extends StatefulWidget {
  static final GlobalKey<_ChatRoomRouteState> globalKey = GlobalKey();
  ChatRoomRoute({Key? key}) : super(key: globalKey);

  @override
  _ChatRoomRouteState createState() => _ChatRoomRouteState();
}

//TODO Cache Messages
class _ChatRoomRouteState extends State<ChatRoomRoute> {
  late GroupChannel _groupChannel;
  final TextEditingController _messageController = TextEditingController();
  late BaseChannel _channel;
  late BaseAuth _auth;

  Future<List<BaseMessage>?> _getMessages() async {
    setState(() {});

    return await _channel.retrievePreviousMessages(_groupChannel.channelUrl);
  }

  void refreshPage() => setState(() {});

  @override
  void initState() {
    _auth = Get.find<AuthenticationController>();
    _channel = Get.find<ChannelController>();
    _groupChannel = Get.arguments[0];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _getMessages();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_groupChannel.name ?? "Chat Room"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder(
                future: _getMessages(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> messages) {
                  if (messages.hasError) {
                    return const Center(
                      child: Text("Unable to retrieve messages :("),
                    );
                  } else if (messages.hasData) {
                    if (messages.data.isEmpty) {
                      return const Center(
                        child: Text("No Messages"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: messages.data.length,
                          itemBuilder: (context, index) {
                            return MessageCard(
                              message: messages.data[index].message,
                              userName: messages.data[index].sender.nickname,
                              messageId: messages.data[index].messageId,
                            );
                          });
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            InputField(
              textEditingController: _messageController,
              paddingHorizontal: 28,
              maxLine: 3,
              trailingIcon: const Icon(Icons.send),
              trailingFunction: () {
                _channel.sendMessage(_messageController.text);
                setState(() {});
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
