import 'package:app/bindings/root_binding.dart';
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
    page: () => const HomeRoute(),
  ),
  GetPage(
    name: "/ProfileRoute",
    page: () => const ProfileRoute(),
  ),
];
