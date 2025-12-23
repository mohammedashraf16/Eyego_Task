import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoginWithGoogleOrFacebookWidget extends StatelessWidget {
  const CustomLoginWithGoogleOrFacebookWidget({
    super.key,
    required this.image,
    required this.lable,
    this.onPressed,
  });
  final String image;
  final String lable;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.kBordersideColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 22),
            SizedBox(width: 8),
            Text(lable, style: TextStyle(color: AppColors.kBlackColor)),
          ],
        ),
      ),
    );
  }
}
