import 'package:app/bindings/root_binding.dart';
import 'package:app/routes/chatroom_route.dart';
import 'package:app/routes/create_channel_route.dart';
import 'package:app/routes/home_route.dart';
import 'package:app/routes/profile_route.dart';
import 'package:get/get.dart';
import 'components/root.dart';

final List<GetPage> routes = [
  GetPage(
      name: "/RootRoute",
      page: () => const RootRoute(),
      binding: RootBinding(),
      transition: Transition.noTransition),
  GetPage(
    name: "/HomeRoute",
    page: () => HomeRoute(),
  ),
  GetPage(
    name: "/ProfileRoute",
    page: () => const ProfileRoute(),
  ),
  GetPage(
    name: "/CreateChannelRoute",
    page: () => const CreateChannelRoute(),
  ),
  GetPage(
    name: "/ChatRoomRoute",
    page: () => ChatRoomRoute(),
  ),
];
