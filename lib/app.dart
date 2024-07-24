import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/App_routes.dart';
import 'routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.splash,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
