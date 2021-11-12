import 'package:app/components/button.dart';
import 'package:app/components/inputfield.dart';
import 'package:app/controllers/channel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  final ScrollController _memberScrollController = ScrollController();
  final ScrollController _moderatorScrollController = ScrollController();
  late List<String> _memberlist;
  late List<String> _moderatorlist;

  @override
  void initState() {
    _memberlist = [];
    _moderatorlist = [];
    _channel = Get.find<ChannelController>();
    super.initState();
  }

  @override
  void dispose() {
    _addMemberController.dispose();
    _addModeratorController.dispose();
    _memberScrollController.dispose();
    _moderatorScrollController.dispose();
    super.dispose();
  }

  void _deleteUserToList(UserType type, String id) {
    switch (type) {
      case UserType.member:
        _memberlist.remove(id);
        break;
      case UserType.moderator:
        _moderatorlist.remove(id);
        break;
    }
    setState(() {});
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

  Widget _userListBody(UserType userType) {
    String _memberTitle;
    List<String> _userList;
    ScrollController _scrollController;

    switch (userType) {
      case UserType.member:
        _memberTitle = "Member Lists";
        _userList = _memberlist;
        _scrollController = _memberScrollController;
        break;
      case UserType.moderator:
        _memberTitle = "Moderator Lists";
        _userList = _moderatorlist;
        _scrollController = _moderatorScrollController;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _memberTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
        _userList.isNotEmpty
            ? Container(
                constraints: const BoxConstraints(
                  maxHeight: 175,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: _userList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black12,
                            width: 1,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        title: Text(_userList[index]),
                        trailing: GestureDetector(
                          onTap: () {
                            _deleteUserToList(userType, _userList[index]);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.delete),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
              ),
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
                      SchedulerBinding.instance!.addPostFrameCallback((_) {
                        _memberScrollController.animateTo(
                          _memberScrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                    ),
                    child: _userListBody(UserType.moderator),
                  ),
                  const SizedBox(height: 14),
                  InputField(
                    label: "Add Moderator ID",
                    textEditingController: _addModeratorController,
                    paddingHorizontal: 80,
                    trailingIcon: const Icon(Icons.add),
                    trailingFunction: () {
                      _addUserToList(
                          UserType.moderator, _addModeratorController.text);
                      SchedulerBinding.instance!.addPostFrameCallback((_) {
                        _moderatorScrollController.animateTo(
                          _moderatorScrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            Button(
              textLabel: "Create Room",
              paddingHorizontal: 50,
              onTap: () {
                _channel
                    .createGroupChannel(
                        userIds: _memberlist, operatorUserIds: _moderatorlist)
                    .then((_) => Get.back());
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
