import 'package:app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/root_binding.dart';
import 'routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      title: "SendBird Chat Demo",
      initialRoute: "/RootRoute",
      getPages: routes,
      initialBinding: RootBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
