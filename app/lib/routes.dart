import 'package:app/bindings/root_binding.dart';
import 'package:get/get.dart';
import 'components/root.dart';

final List<GetPage> routes = [
  GetPage(
      name: "/RootRoute",
      page: () => const RootRoute(),
      binding: RootBinding(),
      transition: Transition.noTransition),
];
