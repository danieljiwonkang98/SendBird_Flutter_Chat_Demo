import 'package:flutter/material.dart';

class CreateChannelRoute extends StatefulWidget {
  const CreateChannelRoute({Key? key}) : super(key: key);

  @override
  _CreateChannelRouteState createState() => _CreateChannelRouteState();
}

class _CreateChannelRouteState extends State<CreateChannelRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sendbird Login"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
      ),
    );
  }
}
