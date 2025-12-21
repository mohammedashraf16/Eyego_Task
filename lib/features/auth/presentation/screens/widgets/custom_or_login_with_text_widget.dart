import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomOrLoginWithTextWidget extends StatelessWidget {
  const CustomOrLoginWithTextWidget({super.key, required this.lable});
  final String lable;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        children: [
          Expanded(child: Divider()),
          SizedBox(width: 5),
          Text(
            lable,
            style: TextStyle(color: AppColors.kGreyColor, fontSize: 14),
          ),
          SizedBox(width: 5),
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}
