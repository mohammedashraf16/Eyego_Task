import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

Future<dynamic> buildErrorDialog(BuildContext context, String message) {
  return AwesomeDialog(
    btnOkColor: AppColors.kPrimaryColor,
    autoDismiss: true,
    customHeader: const Icon(Icons.error, color: Colors.red, size: 80),
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.error,
    body: Center(child: Text(message)),
    title: 'Error',
    desc: message,
    btnOkOnPress: () {},
  ).show();
}
