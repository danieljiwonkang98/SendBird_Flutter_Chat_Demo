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
  // set UserId
  void setUserId(String userId);
  // sign in
  // ? throws error when sign in Unsuccessful
  Future<void> signIn();
  // logout User
  void signOut();
  // login user
  void connect({required String userId, required String accesstoken});
  // update profile
  Future<void> updateProfile({String? nickName, String? imgUrl});
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

  //TODO sendbird connect in root page
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
        _sendbird.connect(_userId, accessToken: dotenv.env["MASTER_API_TOKEN"]);
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
  Future<void> signIn() async {
    try {
      SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      String? _userId = _sharedPreferences.getString("userId");
      _user = await _sendbird.connect(_userId!);

      //TODO Create Logger
      print("Sign In Successful");
    } catch (e) {
      //TODO Create Logger
      //TODO Create Error
      print("Sign In Unsuccessful");
      throw e;
    }
    update();
  }

  // Log Out User
  @override
  void signOut() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString("userId", "");
    _sendbird.disconnect();
    update();
  }

  @override
  bool get isSigned => _isSigned;

  @override
  User? get user => _sendbird.currentUser;

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
  Future<void> updateProfile({String? nickName, String? imgUrl}) async {
    //TODO Include Profile ImgURL & ImgFile
    try {
      await _sendbird.updateCurrentUserInfo(
        nickname: nickName,
      );
      print("Profile Updated!");
    } catch (e) {
      //TODO Create Logger
      print(e);
    }
  }

  @override
  void setUserId(String userId) async {
    try {
      SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      _sharedPreferences.setString("userId", userId);
      print("Set UserId Sucessful");
    } catch (e) {
      print(e);
    }
  }
}
