import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/common_messages.dart';
import 'package:pos_application/core/common/screen_names.dart';
import 'package:pos_application/features/auth/domain/repository/forgot_password_repository.dart';
import 'package:pos_application/features/auth/presentation/bloc/forgot_password/forgot_password_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:pos_application/features/auth/widget/custom_snackbar.dart';
import '../../../core/common/c_text_field.dart';
import '../../../core/common/colors.dart';
import '../../../core/common/label.dart';
import '../../../core/common/u_validations_all.dart';
import '../../../core/common/w_custom_button.dart';
import '../../home/presentation/bloc/menu_name_bloc.dart';
import '../../home/presentation/bloc/menu_name_event.dart';
import 'bloc/textfield_validation_bloc.dart';
import 'bloc/textfield_validation_event.dart';
import 'bloc/textfield_validation_state.dart';
import 'login.dart';

TextEditingController createNewPasswordController = TextEditingController();
TextEditingController confirmNewPasswordController = TextEditingController();

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Container(
          alignment:
          AlignmentDirectional
              .center,
          child: Center(
            child: AutoSizeText(
              'Forgot Password',
              textAlign:
              TextAlign.center,
              minFontSize: 10,
              maxFontSize: 30,
              maxLines: 1,
              style: CustomLabels
                  .body1TextStyle(
                  fontSize: 30,
                  fontWeight:
                  CustomLabels
                      .smallFontWeight),
            ),
          ),
        ),
        AutoSizeText(
          CustomMessages.forgotPasswordErrorMessage,
          textAlign: TextAlign.center,
          minFontSize: 13,
          maxFontSize: 18,
          style: CustomLabels
              .bodyTextStyle(
              fontSize: 15,
              fontFamily:
              CustomLabels
                  .primaryFont,
              letterSpacing: .5,
              color: AppColors
                  .iconColor),
          maxLines: 2,
        ),
        const SizedBox(
          height: 30,
        ),
        BlocBuilder<
            TextFieldValidationBloc,
            TextfieldValidationState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment:
              MainAxisAlignment
                  .start,
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                CustomTextField(
                  controller:
                  emailController,
                  hintText: 'Email',
                  cursorColor: AppColors
                      .secondaryColor,
                  borderColor: (state
                  is TextFieldValidationSuccess ||
                      state
                      is TextfieldValidationInitial)
                      ? AppColors
                      .secondaryColor
                      : Colors.red,
                ),
                Padding(
                  padding: (state
                  is TextFieldValidationSuccess ||
                      state
                      is TextfieldValidationInitial)
                      ? EdgeInsets
                      .zero
                      : const EdgeInsets
                      .only(
                      left: 8,
                      top: 5,
                      right: 0,
                      bottom: 0),
                  child: Visibility(
                    visible: state
                    is TextfieldValidationFailure,
                    child:
                    AutoSizeText(
                      (state is TextFieldValidationSuccess ||
                          state
                          is TextfieldValidationInitial)
                          ? ''
                          : CustomMessages.invalidEmailErrorMessage,
                      minFontSize: 10,
                      maxFontSize: 14,
                      textAlign:
                      TextAlign
                          .left,
                      style:
                      const TextStyle(
                        color: Colors
                            .red,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if(state is ForgotPasswordSuccess){
              OverlayManager.showSnackbar(context,
                  type: ContentType.success,
                  title: "Forgot Password",
                  message: state.message);
            }
          },
          child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (context, state) {
              if (state is ForgotPasswordSuccess) {
                BlocProvider.of<MenuNameBloc>(context)
                    .add(MenuNameSelected(context: context,
                    menuName: Screens.verificationCodeScreen));
              }
              return CustomButton(
                text: 'Continue',
                activeButtonColor: AppColors
                    .secondaryColor,
                textStyle: CustomLabels
                    .bodyTextStyle(
                    fontSize: 14,
                    color: AppColors
                        .darkColor),
                onPressed: () {
                  OverlayManager.showSnackbar(context,
                      type: ContentType.help,
                      title: "Forgot Password",
                      message: CustomMessages.verificationCodeMessage);
                  BlocProvider.of<
                      TextFieldValidationBloc>(
                      context)
                      .add(TextfieldValidationEvent(
                      emailController
                          .text));
                  if (ValidationsAll
                      .isValidEmail(
                      emailController
                          .text)) {
                    BlocProvider.of<ForgotPasswordBloc>(context).add(
                        ForgotPasswordButtonPressed(
                            email: emailController.text));
                  }
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<MenuNameBloc>(context)
                .add(MenuNameSelected(
                context: context, menuName: Screens.loginScreen));
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_ios, // Choose the arrow icon you prefer
                color: AppColors.iconColor,
                size: 14, // Set the color of the arrow icon
              ),
              SizedBox(width: 4), // Add some space between the icon and text
              AutoSizeText(
                'Back to Login',
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




