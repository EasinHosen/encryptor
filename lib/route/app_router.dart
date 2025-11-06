import 'package:encryptor/bindings/home_binding.dart';
import 'package:encryptor/view/screens/ceaser_cypher.dart';
import 'package:encryptor/view/screens/hill_cipher.dart';
import 'package:encryptor/view/screens/home_screen.dart';
import 'package:encryptor/view/screens/monoalphabetic_substitution.dart';
import 'package:encryptor/view/screens/onetimepad_cipher.dart';
import 'package:encryptor/view/screens/polyalphabetic_cipher.dart';
import 'package:get/get.dart';

import '../view/screens/playfair_cipher.dart';

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
    GetPage(
      name: PlayFairCipher.routeName,
      page: () => const PlayFairCipher(),
    ),
    GetPage(
      name: HillCipher.routeName,
      page: () => const HillCipher(),
    ),
    GetPage(
      name: PolyalphabeticCipher.routeName,
      page: () => const PolyalphabeticCipher(),
    ),
    GetPage(
      name: OneTimePadCipher.routeName,
      page: () => const OneTimePadCipher(),
    ),
  ];
}
