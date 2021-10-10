import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showOverlayDuringAsync(Future function) async {
  return await Get.showOverlay(
    asyncFunction: () => function,
    loadingWidget: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
