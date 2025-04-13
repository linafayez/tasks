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
import '../../config/navigation/auth_routes.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final fromKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
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
              } else if (state is SignInSuccess) {
                CustomNavigator.pushInSubNavigator(MainRoutes.MAIN_SCREEN, clean: true);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const CustomAppLogo(
                    size: SizeEnum.large,
                  ),
                  CustomCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              "auth_welcome_back",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
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
                        CustomButton(
                            onPressed: () {
                              if (fromKey.currentState?.validate() ?? false) {
                                context.read<AuthBloc>().add(SignIn(AuthParameters(email: email.text.trim(), password: password.text.trim())));
                              }
                            },
                            label: state is Loading ? null : "auth_sign_in"),
                        TextButton(
                            onPressed: () {
                              CustomNavigator.push(AuthRoutes.SIGN_UP_SCREEN);
                            },
                            child: CustomText("auth_create_account"))
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
