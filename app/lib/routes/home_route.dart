import 'package:app/components/button.dart';
import 'package:app/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeRoute extends StatefulWidget {
  final VoidCallback onSignedOut;
  const HomeRoute({Key? key, required this.onSignedOut}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  late BaseAuth _authentication;

  @override
  void initState() {
    _authentication = Get.find<AuthenticationController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          GestureDetector(
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                //TODO Include Profile Img Icon
                child: Icon(Icons.person)),
          ),
        ],
      ),
      body: Column(
        children: [
          //TODO Include ListView
          const Spacer(),
          Button(
            textLabel: "Log Out",
            paddingHorizontal: 50,
            onTap: () {
              try {
                _authentication.signOut();
                //GET OFF AND REDIRECT TO ROOT PAGE
                widget.onSignedOut();
                Get.offAndToNamed("/RootRoute");
              } catch (e) {
                // _auth.signIn throws error when loggin unsuccessful

              }
            },
          ),
          const SizedBox(height: 150)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        splashColor: Colors.deepPurple[200],
      ),
    );
  }
}
