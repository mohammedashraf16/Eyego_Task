import 'package:eyego_task/config/router/routes.dart';
import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/core/widgets/custom_btn.dart';
import 'package:eyego_task/core/widgets/custom_text_form_field.dart';
import 'package:eyego_task/core/widgets/password_field.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/custom_have_an_account_or_not_widget.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/custom_login_with_google_or_facebook_widget.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/custom_or_login_with_text_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              Card(
                margin: EdgeInsets.all(30),
                elevation: 2,
                color: AppColors.kWhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      CustomTextFormField(
                        lable: "Email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      PasswordField(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              "Forget Password?",
                              style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: CustomBtn(
                          lable: "Login",
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.homeScreen,
                            (route) => false,
                          ),
                        ),
                      ),
                      CustomOrLoginWithTextWidget(lable: "Or Login With"),
                      Row(
                        children: [
                          Expanded(
                            child: CustomLoginWithGoogleOrFacebookWidget(
                              image: "assets/images/google.png",
                              lable: "Google",
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: CustomLoginWithGoogleOrFacebookWidget(
                              image: "assets/images/Facebook.png",
                              lable: "Facebook",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      CustomHaveAccountOrNotWidget(
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.registerScreen),
                        title: "Don’t have account? ",
                        subTitle: "Create now",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
