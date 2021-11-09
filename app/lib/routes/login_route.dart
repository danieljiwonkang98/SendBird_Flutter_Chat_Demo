import 'package:app/components/button.dart';
import 'package:app/components/inputfield.dart';
import 'package:app/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginRoute extends StatefulWidget {
  final VoidCallback onSignedIn;
  const LoginRoute({Key? key, required this.onSignedIn}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final TextEditingController _userIdController = TextEditingController();
  final BaseAuth _auth = Get.find<AuthenticationController>();

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sendbird Login"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Image.asset('assets/img/SendBirdLogo.png',
                  fit: BoxFit.cover, height: 350),
              InputField(
                textEditingController: _userIdController,
                paddingHorizontal: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              Button(
                textLabel: "Login",
                paddingHorizontal: 50,
                onTap: () {
                  try {
                    _auth.signIn(_userIdController.text);
                    print(_auth.user);

                    //GET OFF AND REDIRECT TO ROOT PAGE
                    widget.onSignedIn();
                    Get.offAndToNamed("/RootRoute");
                  } catch (e) {
                    // _auth.signIn throws error when loggin unsuccessful

                  }
                },
              ),
              const SizedBox(height: 150)
            ],
          ),
        ),
      ),
    );
  }
}
