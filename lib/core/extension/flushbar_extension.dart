import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

extension FlushBarErrorMessage on BuildContext {
  void flushBarErrorMessage({
    required String message,
  }) {
    showFlushbar(
      context: this,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(10),
        backgroundColor: Colors.red.shade800,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.error_outline,
          size: 28,
          color: Colors.white,
        ),
      )..show(this),
    );
  }
}

extension FlushBarSuccessMessage on BuildContext {
  void flushBarSuccessMessage({
    required String message,
  }) {
    showFlushbar(
      context: this,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(10),
        backgroundColor: Colors.green.shade800,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.check,
          size: 28,
          color: Colors.white,
        ),
      )..show(this),
    );
  }
}
