import 'package:encryptor/route/app_router.dart';
import 'package:encryptor/view/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/home_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRouter.initial,
      getPages: AppRouter.routes,
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorPrimary),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.colorWhite),
    );
  }
}
