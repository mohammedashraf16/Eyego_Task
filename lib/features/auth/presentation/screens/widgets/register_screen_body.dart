import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/core/widgets/custom_btn.dart';
import 'package:eyego_task/core/widgets/custom_text_form_field.dart';
import 'package:eyego_task/core/widgets/password_field.dart';
import 'package:eyego_task/features/auth/presentation/manager/register_cubit/cubit/register_cubit.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/custom_have_an_account_or_not_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({super.key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  late String userName, email, password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
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
                "Register",
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
                          userName = value!;
                        },
                        lable: "Username",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
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
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: CustomBtn(
                          lable: "Register",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              context
                                  .read<RegisterCubit>()
                                  .createUserWithEmailAndPassword(
                                    email,
                                    password,
                                    userName,
                                  );
                            } else {
                              setState(() {
                                autoValidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                        ),
                      ),
                      CustomHaveAccountOrNotWidget(
                        onTap: () => Navigator.pop(context),
                        title: "Already have an account? ",
                        subTitle: "Login now",
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
