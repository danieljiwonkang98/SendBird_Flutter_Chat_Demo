import 'package:app/components/channel_card_list.dart';
import 'package:app/controllers/authentication_controller.dart';
import 'package:app/controllers/channel_controller.dart';
import 'package:app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';

class HomeRoute extends StatefulWidget {
  static final GlobalKey<_HomeRouteState> globalKey = GlobalKey();
  HomeRoute({Key? key}) : super(key: globalKey);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  late BaseAuth _authentication;
  late BaseChannel _channel;
  late List<GroupChannel> _groupChannel;

  Future<List<GroupChannel>?> _getChannel() async {
    return await _channel.retrieveChannelList();
  }

  void refreshPage() => setState(() {});

  @override
  void initState() {
    _authentication = Get.find<AuthenticationController>();
    _channel = Get.find<ChannelController>();
    //TODO Get List of Channels
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _getChannel();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          GestureDetector(
            onTap: () =>
                Get.toNamed("ProfileRoute")!.then((_) => setState(() {})),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              //TODO Include Profile Img Icon
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getChannel(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Unable to retrieve channel lists :("),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return const Center(
                child: Text("Channel Empty :("),
              );
            } else {
              return ChannelCardList(
                groupChannel: snapshot.data,
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.toNamed("/CreateChannelRoute")!.then((_) => setState(() {})),
        child: const Icon(Icons.add),
        backgroundColor: ThemeColors.primary,
        splashColor: ThemeColors.primaryLight,
      ),
    );
  }
}
