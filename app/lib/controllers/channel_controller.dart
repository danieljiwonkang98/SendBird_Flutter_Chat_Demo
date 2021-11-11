import 'package:get/get.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

abstract class BaseChannel {
  // Get Channel Lists
  Future<List<GroupChannel>?> retrieveChannelList();
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
}
