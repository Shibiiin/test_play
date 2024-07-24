import 'package:get/get.dart';
import 'package:untitled/splash_screen.dart';
import 'package:untitled/todo.dart';
import 'package:untitled/dashBoard_page.dart';
import 'app_pages.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(name: AppPages.dashBoard, page: ()=> DashBoard()),
    // GetPage(name: AppPages.upgrade, page: ()=> UpgradingWidget()),
    GetPage(name: AppPages.todo, page: ()=> TodoList()),
    GetPage(name: AppPages.splash, page: ()=> MySplashScreen()),
  ];
}