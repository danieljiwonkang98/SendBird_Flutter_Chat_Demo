import 'package:app/components/button.dart';
import 'package:app/components/inputfield.dart';
import 'package:app/controllers/channel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserType { member, moderator }

class CreateChannelRoute extends StatefulWidget {
  const CreateChannelRoute({Key? key}) : super(key: key);

  @override
  _CreateChannelRouteState createState() => _CreateChannelRouteState();
}

class _CreateChannelRouteState extends State<CreateChannelRoute> {
  late BaseChannel _channel;
  final TextEditingController _addMemberController = TextEditingController();
  final TextEditingController _addModeratorController = TextEditingController();
  late List<String> _memberlist;
  late List<String> _moderatorlist;

  @override
  void initState() {
    _memberlist = [];
    _moderatorlist = [];
    _channel = Get.find<ChannelController>();
    super.initState();
  }

  void _addUserToList(UserType type, String id) {
    switch (type) {
      case UserType.member:
        _memberlist.add(id);
        break;
      case UserType.moderator:
        _moderatorlist.add(id);
        break;
    }
    setState(() {});
  }

  Widget _userListBody(UserType type) {
    String _memberTitle;
    List<String> _userList;

    switch (type) {
      case UserType.member:
        _memberTitle = "Member Lists";
        _userList = _memberlist;
        break;
      case UserType.moderator:
        _memberTitle = "Moderator Lists";
        _userList = _moderatorlist;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _memberTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _userList.length,
            itemBuilder: (context, index) {
              return Text(_userList[index]);
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Group Channel"),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                      ),
                      child: _userListBody(UserType.member),
                    ),
                    const SizedBox(height: 14),
                    InputField(
                      label: "Add Member ID",
                      textEditingController: _addMemberController,
                      paddingHorizontal: 80,
                      trailingIcon: const Icon(Icons.add),
                      trailingFunction: () {
                        _addUserToList(
                            UserType.member, _addMemberController.text);
                      },
                    ),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                      ),
                      child: _userListBody(UserType.moderator),
                    ),
                    InputField(
                      label: "Add Moderator ID",
                      textEditingController: _addModeratorController,
                      paddingHorizontal: 80,
                      trailingIcon: const Icon(Icons.add),
                      trailingFunction: () {
                        _addUserToList(
                            UserType.moderator, _addModeratorController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Button(
              textLabel: "Create Room",
              paddingHorizontal: 50,
              onTap: () {
                _channel
                    .createGroupChannel(
                        userIds: _memberlist, operatorUserIds: _moderatorlist)
                    .then(
                      (_) => Get.back(),
                    );
              },
            ),
            const SizedBox(
              height: 75,
            ),
          ],
        ),
      ),
    );
  }
}
