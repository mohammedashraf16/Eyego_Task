import 'package:eyego_task/config/router/routes.dart';
import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/core/widgets/custom_btn.dart';
import 'package:eyego_task/core/widgets/custom_text_form_field.dart';
import 'package:eyego_task/core/widgets/password_field.dart';
import 'package:eyego_task/features/auth/presentation/manager/login_cubit/cubit/login_cubit.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/custom_have_an_account_or_not_widget.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/custom_login_with_google_or_facebook_widget.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/custom_or_login_with_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: autoValidateMode,
          key: formKey,
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
                        onSaved: (value) {
                          email = value!;
                        },
                        lable: "Email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      PasswordField(
                        onSaved: (value) {
                          password = value!;
                        },
                      ),
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
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              context
                                  .read<LoginCubit>()
                                  .signInWithEmailAndPassword(email, password);
                            } else {
                              autoValidateMode = AutovalidateMode.always;
                            }
                          },
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
