import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future? completeSnackbar(String message) => Get.showSnackbar(
      GetBar(
        title: 'Done',
        message: message,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        shouldIconPulse: true,
        icon: const Icon(Icons.done_rounded),
      ),
    );
