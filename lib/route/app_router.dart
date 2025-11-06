import 'package:encryptor/bindings/home_binding.dart';
import 'package:encryptor/view/screens/ceaser_cypher.dart';
import 'package:encryptor/view/screens/home_screen.dart';
import 'package:encryptor/view/screens/monoalphabetic_substitution.dart';
import 'package:get/get.dart';

class AppRouter {
  AppRouter._();

  static const initial = HomeScreen.routeName;

  static final routes = [
    GetPage(
      binding: HomeBinding(),
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: CeaserCypher.routeName,
      page: () => const CeaserCypher(),
    ),
    GetPage(
      name: MonoAlphabeticSubstitution.routeName,
      page: () => const MonoAlphabeticSubstitution(),
    ),
  ];
}
