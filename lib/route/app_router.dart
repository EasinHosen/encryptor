import 'package:encryptor/view/screens/home_screen.dart';
import 'package:get/get.dart';

class AppRouter {
  AppRouter._();

  static const initial = HomeScreen.routeName;

  static final routes = [
    GetPage(
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
    ),
  ];
}
