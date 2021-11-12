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

  void _signInCallBack() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  @override
  void initState() {
    _authStatus = AuthStatus.notSignedIn;
    _authentication = Get.find<AuthenticationController>();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // check login if logged in
    _authentication.checkLogin().then((isLoggedIn) => {
          // connect user
          if (isLoggedIn)
            {
              _authentication.signIn(),
            },

          setState(() {
            _authStatus = isLoggedIn == true
                ? AuthStatus.signedIn
                : AuthStatus.notSignedIn;
          }),
          print(_authStatus),
        });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.signedIn:
        return HomeRoute();
      case AuthStatus.notSignedIn:
        return LoginRoute(
          onSignedIn: _signInCallBack,
        );
    }
  }
}
