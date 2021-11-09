import 'package:app/components/button.dart';
import 'package:app/controllers/authentication_controller.dart';
import 'package:app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

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
            onTap: () => Get.toNamed("ProfileRoute"),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              //TODO Include Profile Img Icon
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //TODO Include ListView
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: ThemeColors.primary,
        splashColor: ThemeColors.primaryLight,
      ),
    );
  }
}
