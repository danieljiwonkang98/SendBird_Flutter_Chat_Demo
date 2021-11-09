import 'package:get/get.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

abstract class BaseChannel {
  // Creates Group Channel
  void createGroupChannel(
      {required List<String> userIds, required List<String> operatorUserIds});
}

class AuthenticationController extends GetxController implements BaseChannel {
  @override
  Future<void> createGroupChannel(
      {required List<String> userIds,
      required List<String> operatorUserIds}) async {
    try {
      final params = GroupChannelParams()
        ..userIds = userIds
        ..operatorUserIds = operatorUserIds;
      final channel = await GroupChannel.createChannel(params);
      // Now you can work with the channel object.
    } catch (e) {
      // Handle error.
    }
  }
}
