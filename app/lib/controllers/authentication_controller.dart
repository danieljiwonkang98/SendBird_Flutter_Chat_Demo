import 'package:get/get.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BaseAuth {
  // intialize
  void initialize();
  // disconnect from application
  void disconnect();
  // login user
  void connect({required String userId, required String accesstoken});
  // update profile
  void updateProfile({String? nickName, String? imgUrl});
  // check if user is logged in
  bool get isSigned;
  // get current user
  User? get user;
}

class AuthenticationController extends GetxController implements BaseAuth {
  //* Initialize Sendbird Sdk
  final _sendbird = SendbirdSdk(appId: dotenv.env["APP_ID_DEV"]);
  bool _isSigned = false;

  @override
  void initialize() {
    // TODO: implement initialize
  }

  @override
  // TODO: implement isSigned
  bool get isSigned => _isSigned;

  @override
  User? get user => _sendbird.currentUser;

  /*
    A user should be disconnected from the Sendbird server 
    when they no longer need to receive messages from an online state.
    However, the user will still receive push notifications for new
    messages from group channels they've joined.
  */
  @override
  void disconnect() {
    _sendbird.disconnect();
  }

  // Logging User to Sendbird application
  @override
  void connect({required String userId, required String accesstoken}) {
    try {
      _sendbird.connect(userId);
    } catch (e) {
      //TODO Create Logger
      print(e);
    }
  }

  // Updates User's Nickname and Profile Image
  @override
  void updateProfile({String? nickName, String? imgUrl}) {
    // TODO: implement updateProfile
  }
}
