import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:popular_people_app/theme/popular_people_theme.dart';

class ACFlushBar {
  ACFlushBar._();

  static Future<dynamic> success(
      {@required BuildContext? context, @required message}) {
    Flushbar flush = Flushbar(
      shouldIconPulse: true,
      titleText: const Text(
        'Success',
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        message,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      icon: const Icon(
        Icons.check,
        size: 25.0,
        color: Colors.white,
      ),
      duration: const Duration(milliseconds: 4000),
      animationDuration: const Duration(milliseconds: 1000),
    );

    return flush.show(context!);
  }

  static Future<dynamic> error(
      {required BuildContext? context, String? message}) {
    Flushbar flush = Flushbar(
      shouldIconPulse: true,
      titleText: const Text(
        'Error',
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        message ?? 'error occured',
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      icon: const Icon(
        Icons.cancel,
        size: 25.0,
        color: Colors.white,
      ),
      duration: const Duration(milliseconds: 4000),
      animationDuration: const Duration(milliseconds: 1000),
    );

    return flush.show(context!);
  }

  static Future<dynamic> info(
      {@required BuildContext? context,
      @required message,
      String title = 'Alert'}) {
    Flushbar flush = Flushbar(
      shouldIconPulse: true,
      titleText: Text(
        title,
        style: const TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        message ?? 'alert',
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      backgroundColor: PopularPeopleTheme.primary,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      icon: const Icon(
        Icons.info_outline,
        size: 25.0,
        color: Colors.white,
      ),
      duration: const Duration(milliseconds: 1300),
      animationDuration: const Duration(milliseconds: 500),
    );

    return flush.show(context!);
  }
}
