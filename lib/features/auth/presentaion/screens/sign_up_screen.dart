import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasks_joddb/core/config/app_localization.dart';
import 'package:tasks_joddb/core/config/enums/size_enum.dart';
import 'package:tasks_joddb/core/navigation/custom_navigation.dart';
import 'package:tasks_joddb/core/widgets/cusom_text_field.dart';
import 'package:tasks_joddb/core/widgets/custom_app_logo.dart';
import 'package:tasks_joddb/core/widgets/custom_card.dart';
import 'package:tasks_joddb/core/widgets/custom_text.dart';
import 'package:tasks_joddb/features/auth/data/params/create_account_prams.dart';
import 'package:tasks_joddb/features/auth/presentaion/bloc/auth_bloc/auth_bloc.dart';

import '../../../../core/config/validation.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../main/config/navigation/main_routes.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Form(
          key: fromKey,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Failed) {
                Fluttertoast.showToast(msg: AppLocalization.of(context).getTranslatedValues(state.message));
              } else if (state is CreateAccountSuccess) {
                CustomNavigator.pushInSubNavigator(MainRoutes.MAIN_SCREEN, clean: true);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const Row(
                    children: [
                      BackButton(),
                    ],
                  ),
                  const CustomAppLogo(
                    size: SizeEnum.large,
                  ),
                  CustomCard(
                    child: Column(
                      children: [
                        CustomText(
                          "auth_create_account",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        CustomTextField(
                          controller: email,
                          labelText: "auth_email",
                          validator: (value) {
                            return AppValidation.isEmail(value ?? "");
                          },
                        ),
                        CustomTextField(
                          controller: password,
                          labelText: "auth_password",
                          obscureText: true,
                          validator: (value) {
                            return AppValidation.isPassword(value ?? "");
                          },
                        ),
                        CustomTextField(
                          controller: confirmPassword,
                          labelText: "auth_confirm_password",
                          obscureText: true,
                          validator: (value) {
                            return AppValidation.isConfirmPassword(password.text, value ?? "");
                          },
                        ),
                        CustomButton(
                            onPressed: () {
                              if (fromKey.currentState?.validate() ?? false) {
                                context.read<AuthBloc>().add(CreateAccount(AuthParameters(email: email.text.trim(), password: password.text.trim())));
                              }
                            },
                            label: state is Loading ? null : "auth_sign_up"),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
