import 'package:app/controllers/authentication_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // * Initializes SendBird SDK
    Get.put(AuthenticationController(), permanent: true);
  }
}
