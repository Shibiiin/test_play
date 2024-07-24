import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app.dart';
import 'package:untitled/controller/controller.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Upgrader.clearSavedSettings();

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskController(),
      child: MyApp(),
    ),
  );
}
