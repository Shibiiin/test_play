import 'package:get/get.dart';
import 'package:untitled/SigninPage.dart';
import 'package:untitled/dashBoard_page.dart';
import 'package:untitled/upgrade_widget.dart';
import 'app_pages.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(name: AppPages.dashBoard, page: ()=> DashBoard()),
    GetPage(name: AppPages.upgrade, page: ()=> UpgradingWidget()),
    GetPage(name: AppPages.siginPage, page: ()=> SiginPage()),
  ];
}