import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future? errorSnackbar(String message, {int seconds = 3}) => Get.showSnackbar(
      GetBar(
        title: 'Error',
        message: message,
        backgroundColor: Colors.red,
        duration: Duration(seconds: seconds),
        icon: const Icon(Icons.info_outline_rounded),
        shouldIconPulse: true,
      ),
    );
