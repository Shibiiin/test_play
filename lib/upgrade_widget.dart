// import 'package:flutter/material.dart';
// import 'package:untitled/dashBoard_page.dart';
// import 'package:upgrader/upgrader.dart';
//
//
// class UpgradingWidget extends StatelessWidget {
//   const UpgradingWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: UpgradeAlert(
//         dialogStyle: UpgradeDialogStyle.material,
//         showIgnore: false,
//         showLater: false,
//         showReleaseNotes: true,
//         barrierDismissible: true,
//         upgrader: Upgrader(
//           // debugDisplayAlways: true,
//           debugDisplayOnce: true,
//           debugLogging: true,
//           languageCode: "en",
//           messages: UpgraderMessages(code: "en"),
//           countryCode: "IN",
//           minAppVersion: "1.1.5",
//           willDisplayUpgrade: (
//                   {required display, installedVersion, versionInfo}) =>display
//         ),
//         child: DashBoard(),
//       ),
//     );
//   }
// }
