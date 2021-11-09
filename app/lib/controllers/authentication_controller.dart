import 'package:get/get.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuth {
  //Checks if Logged In
  Future<bool> checkLogin();
  // intialize
  void initialize();
  // sign in
  // ? throws error when sign in Unsuccessful
  void signIn(String userId);
  // logout User
  void signOut();
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
  late bool _isSigned;
  late User _user;
  //TODO Include SharedPreference HERE

  // Check if user is logged in
  @override
  Future<bool> checkLogin() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    String? _userId = _sharedPreferences.getString("userId");

    try {
      // If UserId Exists Login
      if (_userId == null || _userId == "") {
        _isSigned = false;
      } else {
        _isSigned = true;
        _sendbird.connect(_userId);
      }
    } catch (e) {
      //TODO Create Logger
      print(e);
    }

    // Update Value in Get X Controller
    update();
    return _isSigned;
  }

  @override
  void initialize() {
    //TODO login with accesstoken
    checkLogin();
  }

  @override
  void signIn(String userId) async {
    try {
      SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      _sharedPreferences.setString("userId", userId);
      _user = await _sendbird.connect(userId);

      //TODO Create Logger
      print("Sign In Successful");
    } catch (e) {
      //TODO Create Logger
      //TODO Create Error
      print("Sign In Unsuccessful");
      throw e;
    }
  }

  // Log Out User
  @override
  void signOut() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString("userId", "");
    update();
  }

  @override
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
    //TODO Include Profile ImgURL & ImgFile
    try {
      _sendbird.updateCurrentUserInfo(
        nickname: nickName,
      );
      print("Profile Updated!");
    } catch (e) {
      //TODO Create Logger
      print(e);
    }
  }
}
