import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

//TODO NEED REFACTOR
Future<File> downloadFile(String url, String filename) async {
  var response = await get(Uri.parse(url),
      headers: {"Api-Token": dotenv.env["MASTER_API_TOKEN"]!});
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File('$dir/$filename');
  await file.writeAsBytes(response.bodyBytes);
  return file;
}

Future<String?> _findLocalPath() async {
  var externalStorageDirPath;
  //TODO Test on Android
  if (Platform.isAndroid) {
    // try {
    //   externalStorageDirPath = await AndroidPathProvider.downloadsPath;
    // } catch (e) {
    //   final directory = await getExternalStorageDirectory();
    //   externalStorageDirPath = directory?.path;
    // }
  } else if (Platform.isIOS) {
    externalStorageDirPath = (await getApplicationDocumentsDirectory()).path;
  }
  return externalStorageDirPath;
}

Future<String?> downloadFileLocal(String url, String filename) async {
  // await Permission.
  await Permission.storage.request();
  // callback is a top-level or static function
  String _localPath = (await _findLocalPath())!;
  final savedDir = Directory(_localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    await savedDir.create();
  }
  // String dir = (await getApplicationDocumentsDirectory()).path;
  final taskId = await FlutterDownloader.enqueue(
    url: url,
    headers: {"Api-Token": dotenv.env["MASTER_API_TOKEN"]!},
    savedDir: _localPath,
    showNotification:
        true, // show download progress in status bar (for Android)
    openFileFromNotification:
        true, // click on notification to open downloaded file (for Android)
  );
  print(_localPath);
  print("Downloaded");
  print(taskId);
  return taskId;
}
