import 'package:app/components/button.dart';
import 'package:app/components/inputfield.dart';
import 'package:app/controllers/authentication_controller.dart';
import 'package:app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({Key? key}) : super(key: key);

  @override
  _ProfileRouteState createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  late BaseAuth _authentication;
  final TextEditingController _nameController = TextEditingController();
  late String _nickName;

  @override
  void initState() {
    _authentication = Get.find<AuthenticationController>();
    updateNickName();
    super.initState();
  }

  void updateNickName() {
    _nickName = _authentication.user!.nickname;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
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
              const SizedBox(height: 50),
              Center(
                child: Image.asset('assets/img/avatar.png',
                    fit: BoxFit.cover, height: 175),
              ),
              const SizedBox(height: 16),
              if (_nickName != "")
                Column(
                  children: [
                    const Text(
                      "Nick Name",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Center(
                        child: Text(
                          _authentication.user!.nickname,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              const Text(
                "User ID",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Center(
                  child: Text(
                    _authentication.user!.userId,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const Spacer(),
              InputField(
                hintText:
                    (_nickName == "") ? _authentication.user!.nickname : null,
                label: "Nick Name",
                textEditingController: _nameController,
                paddingHorizontal: 80,
              ),
              const Spacer(),
              Button(
                textLabel: "Update Info",
                paddingHorizontal: 50,
                onTap: () {
                  try {
                    if (_nameController.text != "") {
                      _authentication
                          .updateProfile(nickName: _nameController.text)
                          .then((value) => updateNickName());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: ThemeColors.primary,
                          content: Text('Profile Updated!'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: ThemeColors.primary,
                          content: Text('Please Enter Nick Name!'),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: ThemeColors.primary,
                        content: Text('Update Unsuccessful :('),
                      ),
                    );
                  }
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              Button(
                textLabel: "Log Out",
                paddingHorizontal: 50,
                onTap: () {
                  try {
                    _authentication.signOut();
                    //GET OFF AND REDIRECT TO ROOT PAGE
                    Get.offAllNamed("/RootRoute");
                  } catch (e) {
                    //TODO Create Logger
                    print(e);
                  }
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
