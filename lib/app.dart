import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/routes/App_routes.dart';
import 'package:untitled/routes/app_pages.dart';
import 'package:upgrader/upgrader.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.siginPage,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
