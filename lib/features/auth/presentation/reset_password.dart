import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/c_text_field.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/common_messages.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/screen_names.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import 'package:pos_application/features/auth/domain/repository/reset_password_repository.dart';
import 'package:pos_application/features/auth/presentation/bloc/password_validation_bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/password_validation_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/password_validation_state.dart';
import 'package:pos_application/features/auth/presentation/bloc/reset_password/reset_password_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/reset_password/reset_password_state.dart';
import 'package:pos_application/features/auth/widget/custom_snackbar.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_state.dart';
import '../../../core/common/u_validations_all.dart';
import '../../home/presentation/bloc/menu_name_bloc.dart';
import '../../home/presentation/bloc/menu_name_event.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'login_screen.dart';

TextEditingController createNewPasswordController = TextEditingController();
TextEditingController confirmNewPasswordController = TextEditingController();

class ResetPasswordScreen extends StatelessWidget {
  static String verificationCode = '';
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: AlignmentDirectional.center,
          child: Center(
            child: AutoSizeText(
              optionName!.resetPassword,
              textAlign: TextAlign.center,
              minFontSize: 10,
              maxFontSize: 30,
              maxLines: 1,
              style: CustomLabels.body1TextStyle(
                  fontSize: 30, fontWeight: CustomLabels.smallFontWeight),
            ),
          ),
        ),
        AutoSizeText(
          optionName!.createaNewPassword,
          textAlign: TextAlign.center,
          minFontSize: 13,
          maxFontSize: 18,
          style: CustomLabels.bodyTextStyle(
              fontSize: 15,
              fontFamily: CustomLabels.primaryFont,
              letterSpacing: .5,
              color: AppColors.iconColor),
          maxLines: 1,
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<PasswordValidationBloc, PasswordValidationState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: createNewPasswordController,
                  hintText: optionName!.createaNewPassword,
                  obscureText: true,
                  inputType: CustomTextInputType.password,
                  cursorColor: AppColors.secondaryColor,
                  borderColor: (state is PasswordValidationSuccess ||
                          state is PasswordValidationInitial)
                      ? AppColors.secondaryColor
                      : Colors.red,
                ),
                Padding(
                  padding: (state is PasswordValidationSuccess ||
                          state is PasswordValidationInitial)
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(
                          left: 8, top: 5, right: 0, bottom: 0),
                  child: Visibility(
                    visible: state is PasswordValidationFailure,
                    child: AutoSizeText(
                      (state is PasswordValidationSuccess ||
                              state is PasswordValidationInitial)
                          ? ''
                          : optionName!.invalidPasswordErrorMessage,
                      minFontSize: 10,
                      maxFontSize: 14,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: (state is PasswordValidationSuccess ||
                          state is PasswordValidationInitial)
                      ? 20
                      : 0,
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<PasswordValidationBloc, PasswordValidationState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: confirmNewPasswordController,
                  hintText: optionName!.confirmPassword,
                  obscureText: true,
                  inputType: CustomTextInputType.password,
                  cursorColor: AppColors.secondaryColor,
                  borderColor: (state is PasswordValidationSuccess ||
                          state is PasswordValidationInitial)
                      ? AppColors.secondaryColor
                      : Colors.red,
                ),
                Padding(
                  padding: (state is PasswordValidationSuccess ||
                          state is PasswordValidationInitial)
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(
                          left: 8, top: 0, right: 0, bottom: 5),
                  child: Visibility(
                    visible: state is PasswordValidationFailure,
                    child: AutoSizeText(
                      (state is PasswordValidationSuccess ||
                              state is PasswordValidationInitial)
                          ? ''
                          : optionName!.invalidPasswordErrorMessage,
                      minFontSize: 10,
                      maxFontSize: 14,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: (state is PasswordValidationSuccess ||
                          state is PasswordValidationInitial)
                      ? 20
                      : 0,
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<MenuNameBloc, MenuNameState>(
          builder: (context, state) {
            if (state is MenuNameFetchedSuccess) {
            }
            return BlocListener<ResetPasswordBloc, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordSuccess) {
                  OverlayManager.showSnackbar(context,
                      type: ContentType.success,
                      title: optionName!.resetPassword,
                      message: state.message!);
                }
              },
              child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    BlocProvider.of<MenuNameBloc>(context)
                        .add(MenuNameSelected(
                        context: context, menuName: Screens.passwordUpdatedScreen));
                  }
                  return CustomButton(
                      text: optionName!.submit,
                      activeButtonColor: AppColors.secondaryColor,
                      textStyle: CustomLabels.bodyTextStyle(
                          fontSize: 14, color: AppColors.darkColor),
                      onPressed: () {
                        //need to pass the correct controller
                        BlocProvider.of<PasswordValidationBloc>(context).add(
                            PasswordValidationPressedEvent(
                                confirmNewPasswordController.text));
                        if (ValidationsAll.isValidPassword(
                                createNewPasswordController.text) &&
                            ValidationsAll.isValidPassword(
                                confirmNewPasswordController.text) &&
                            createNewPasswordController.text ==
                                confirmNewPasswordController.text) {
                          BlocProvider.of<ResetPasswordBloc>(context)
                              .add(ResetPasswordButtonPressed(
                            email: emailController.text,
                            token: ResetPasswordScreen.verificationCode,
                            password: createNewPasswordController.text,
                            password_confirmation:
                                confirmNewPasswordController.text,
                          ));
                        } else {
                         OverlayManager.showSnackbar(context,
                             type: ContentType.failure,
                             title: optionName!.resetPasswordError,
                             message: optionName!.invalidPasswordErrorMessage);
                        }
                      });
                },
              ),
            );
          },
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<MenuNameBloc>(context).add(MenuNameSelected(
                context: context, menuName: Screens.loginScreen));
          },
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_ios, // Choose the arrow icon you prefer
                color: AppColors.iconColor,
                size: 14, // Set the color of the arrow icon
              ),
              SizedBox(width: 4), // Add some space between the icon and text
              AutoSizeText(
                optionName!.backToLogin,
                minFontSize: 10,
                maxFontSize: 14,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.iconColor,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
