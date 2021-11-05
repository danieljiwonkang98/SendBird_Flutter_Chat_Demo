import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  return runApp(const MyApp());
}
