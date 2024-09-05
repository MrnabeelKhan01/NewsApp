import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';


getFlushBar(
    BuildContext context, {
      required String title,
    }) {
  return Flushbar(
    message: title,
    icon: const Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.blue,
    ),
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    duration: const Duration(seconds: 3),
  )..show(context);
}

getReloadFlushBar(
    BuildContext context, {
      required String title,
    }) {
  return Flushbar(
    message: title,
    messageSize: 11,
    icon: const Icon(
      Icons.error,
      size: 28.0,
      color: Colors.red,
    ),
    isDismissible: false,
    mainButton: TextButton(
      onPressed: () {
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => SplashView()),
        //         (route) => false);
      },
      child: const Text(
        "Reload",
        style: TextStyle(color: Colors.yellow),
      ),
    ),
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),

  )..show(context);
}
