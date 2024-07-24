import 'package:flutter/material.dart';

void customSnackBar(context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black26,
      duration: const Duration(seconds: 3),
      // action: SnackBarAction(
      //   textColor: Colors.white,
      //   onPressed: () {
      //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //   },
      // ),
    ),
  );
}
