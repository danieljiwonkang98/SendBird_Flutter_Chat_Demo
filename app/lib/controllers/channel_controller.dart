import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

abstract class BaseChannel {
  // Get Channel Lists
  Future<List<GroupChannel>?> retrieveChannelList();

  // Send Message
  void sendMessage(String message);

  // Send File
  void sendFile(File file);

  // Delete Message
  Future<void> deleteMessage(int messageId);

  // Get Previous Messages
  Future<List<BaseMessage>?> retrievePreviousMessages(String channelURL);

  // Creates Group Channel
  Future<void> createGroupChannel(
      {required List<String> userIds, required List<String> operatorUserIds});

  // set current selected group channel
  void setCurrentGroupChannel(GroupChannel channel);

  //get current group
  GroupChannel get currentGroupChannel;
}

class ChannelController extends GetxController implements BaseChannel {
  late GroupChannel _currentChannel;

  @override
  Future<void> createGroupChannel(
      {required List<String> userIds,
      required List<String> operatorUserIds}) async {
    try {
      final params = GroupChannelParams()
        ..userIds = userIds
        ..operatorUserIds = operatorUserIds;
      final channel = await GroupChannel.createChannel(params);
      print("Channel Create Successful!");
      // Now you can work with the channel object.
    } catch (e) {
      //TODO Create Logger
      print("Channel Create Unsuccessful!");
      print(e);
    }
  }

  @override
  Future<List<GroupChannel>?> retrieveChannelList() async {
    try {
      final query = GroupChannelListQuery()
        ..includeEmptyChannel = true
        ..memberStateFilter = MemberStateFilter.joined
        ..order = GroupChannelListOrder.latestLastMessage
        ..limit = 15;
      final result = await query.loadNext();
      //! TODO REMOVE
      print("Retrieve Group Channel Successful!");
      return result;
      // A list of private group channels matching the list query criteria is successfully retrieved.
    } catch (e) {
      print(e);

      // Handle error.
    }
    return null;
  }

  Future<List<BaseMessage>?> retrievePreviousMessages(String channelURL) async {
    try {
      final listQuery = PreviousMessageListQuery(
        channelType: ChannelType.group,
        channelUrl: channelURL,
      )
        ..limit = 30
        ..reverse = false;
      final messages = await listQuery.loadNext();
      //! TODO REMOVE
      print("Messages Loaded!");
      return messages;
    } catch (e) {
      print(e);
      // Handle error.
    }
  }

  @override
  GroupChannel get currentGroupChannel => _currentChannel;

  @override
  void setCurrentGroupChannel(GroupChannel channel) {
    _currentChannel = channel;
    update();
  }

  @override
  void sendMessage(String message) {
    try {
      final params = UserMessageParams(message: message)
        ..customType = "message";

      final preMessage =
          _currentChannel.sendUserMessage(params, onCompleted: (message, err) {
        // If error is null and message is sent successfully,
      });

      //use preMessage to display the message before it is sent to the server.
      print("Message Sent!");
    } catch (e) {
      print(e);
      // Handle error.
    }
  }

  @override
  Future<void> deleteMessage(int messageId) async {
    try {
      await _currentChannel.deleteMessage(messageId);
    } catch (e) {
      // Handle exception.
    }
  }

  @override
  void sendFile(File file) {
    try {
      final params = FileMessageParams.withFile(file, name: "file")
        ..thumbnailSizes = [const Size(100, 100), const Size(200, 200)]
        ..customType = "file";

      final preMessage =
          _currentChannel.sendFileMessage(params, onCompleted: (message, err) {
        // A file message with detailed configuration is successfully sent to the channel.
        // If error is null and message is sent successfully,
      });

      print("File Message Sent!");
      //use preMessage to display the message before it is sent to the server.
    } catch (e) {
      print(e);
      // Handle error.
    }
  }
}
