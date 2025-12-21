import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomHaveAccountOrNotWidget extends StatelessWidget {
  const CustomHaveAccountOrNotWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.subTitle,
  });
  final void Function() onTap;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(color: AppColors.kGreyColor),
            ),
            TextSpan(
              text: subTitle,
              style: TextStyle(
                color: AppColors.kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
