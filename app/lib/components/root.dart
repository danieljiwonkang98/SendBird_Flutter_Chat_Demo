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
  void initState() {
    _authStatus = AuthStatus.notSignedIn;
    _authentication = Get.find<AuthenticationController>();
    _authentication.initialize();

    _authStatus = _authentication.isSigned == true
        ? AuthStatus.signedIn
        : AuthStatus.notSignedIn;

    //! REMOVE
    print(_authStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.signedIn:
        return const LoginRoute();
      case AuthStatus.notSignedIn:
        return const HomeRoute();
    }
  }
}
