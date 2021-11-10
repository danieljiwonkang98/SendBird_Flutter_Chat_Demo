import 'package:get/get.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

abstract class BaseChannel {
  // Get Channel Lists
  // TODO
  // Creates Group Channel
  void createGroupChannel(
      {required List<String> userIds, required List<String> operatorUserIds});
}

class ChannelController extends GetxController implements BaseChannel {
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
      print(e);
    }
  }
}
