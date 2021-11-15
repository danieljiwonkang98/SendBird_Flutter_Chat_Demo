import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();

  await dotenv.load(fileName: ".env");
  return runApp(const MyApp());
}
