import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../networking/error_response.dart';
// import 'package:get/get.dart';
// import 'package:loc/core/networking/responses/error_response.dart';
// import 'package:loc/public/styles.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Utils {
  static String getErrorFromJson(Map<String, dynamic> json) {

    print("Response is : ${json}");
    var buffer = new StringBuffer();
    if (json == null) {
      buffer.write("Unknown error");
      return buffer.toString();
    }
    if(json['error'] is String){
      buffer.write(json['error']);
      return buffer.toString();
    }
    else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(json);
      errorResponse.error?.forEach((element) {
        buffer.write(element.message??""+ "\n");
      });


    }


    if (buffer.toString().isEmpty) {
      buffer.write("UnKnow Error");
    }
    return buffer.toString();
  }



  // static showSnackBar(String message){
  //   Get.showSnackbar(GetBar(message: message,
  //     backgroundColor: colorPrimary,
  //     borderRadius: 10,
  //     isDismissible: true,
  //
  //     margin: const EdgeInsets.symmetric(horizontal: 40),
  //     snackPosition: SnackPosition.TOP,
  //     animationDuration: const Duration(milliseconds: 700),
  //     duration: const Duration(seconds: 5),));
  // }
  // static showSheet(BuildContext context, Widget widget) async {
  //   Widget w = await Future.microtask(() {
  //     return widget;
  //   });
  //   showBarModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => w,
  //   );
  // }
  //
  // static Future<void> customLaunch(command) async {
  //   if (await canLaunchUrlString(command)) {
  //     await launchUrlString(command);
  //   } else {
  //     print(' could not launch $command');
  //   }
  // }

}

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension EmailValidator on String? {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this??"");
  }
}
