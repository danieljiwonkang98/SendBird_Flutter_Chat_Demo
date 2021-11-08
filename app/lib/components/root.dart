import 'package:app/controllers/authentication_controller.dart';
import 'package:app/routes/home_route.dart';
import 'package:app/routes/login_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthStatus { notSignedIn, signedIn }

class RootRoute extends StatefulWidget {
  const RootRoute({Key? key}) : super(key: key);

  @override
  _RootRouteState createState() => _RootRouteState();
}

//* Logic to check if the user is Signed In or Not
class _RootRouteState extends State<RootRoute> {
  late AuthStatus _authStatus;
  late BaseAuth _authentication;

  @override
  void didChangeDependencies() {
    _authStatus = AuthStatus.notSignedIn;
    _authentication = Get.find<AuthenticationController>();

    _authentication.checkLogin().then((isLoggedIn) => {
          _authStatus =
              isLoggedIn == true ? AuthStatus.signedIn : AuthStatus.notSignedIn,
        });

    //! REMOVE
    print(_authStatus);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.signedIn:
        return const HomeRoute();
      case AuthStatus.notSignedIn:
        return const LoginRoute();
    }
  }
}
