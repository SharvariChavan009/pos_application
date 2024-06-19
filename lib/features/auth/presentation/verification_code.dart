import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/common_messages.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import 'package:pos_application/features/auth/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:pos_application/features/auth/presentation/reset_password.dart';
import '../../../core/common/screen_names.dart';
import '../../home/presentation/bloc/menu_name_bloc.dart';
import '../../home/presentation/bloc/menu_name_event.dart';
import '../domain/repository/forgot_password_repository.dart';
import '../widget/custom_snackbar.dart';
import 'bloc/forgot_password/forgot_password_event.dart';
import 'bloc/textfield_validation_bloc.dart';
import 'bloc/textfield_validation_event.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'login_screen.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

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
              optionName!.forgotPassword,
              textAlign: TextAlign.center,
              minFontSize: 10,
              maxFontSize: 30,
              maxLines: 1,
              style: CustomLabels.body1TextStyle(
                  fontSize: 30, fontWeight: CustomLabels.smallFontWeight),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        AutoSizeText(
          optionName!.verificationCodeSuccessMessage,
          textAlign: TextAlign.center,
          minFontSize: 13,
          maxFontSize: 18,
          style: CustomLabels.bodyTextStyle(
              fontSize: 13,
              fontFamily: CustomLabels.primaryFont,
              letterSpacing: 0.5,
              color: AppColors.iconColor),
          maxLines: 2,
        ),
        const SizedBox(
          height: 30,
        ),
        OtpTextField(
          borderWidth: 0.09,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          fieldWidth: 50,
          fieldHeight: 40,
          numberOfFields: 4,
          alignment: Alignment.center,
          enabledBorderColor: AppColors.iconColor,
          showFieldAsBox: true,
          textStyle: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: CustomLabels.primaryFont,
          ),
          onSubmit: (String verificationCode) {
            ResetPasswordScreen.verificationCode = verificationCode;
            },
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
          text: optionName!.submit,
          activeButtonColor: AppColors.secondaryColor,
          textStyle: CustomLabels.bodyTextStyle(
              fontSize: 14, color: AppColors.darkColor),
          onPressed: () {
            BlocProvider.of<MenuNameBloc>(context).add(MenuNameSelected(
                context: context, menuName: Screens.resetPasswordScreen));
          },
        ),
        const SizedBox(
          height: 30,
        ),
        BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if(state is ForgotPasswordSuccess){
              OverlayManager.showSnackbar(context,
                  type: ContentType.success,
                  title: optionName!.forgotPassword,
                  message: state.message);
            }
          },
          child: GestureDetector(
            onTap: () {
              OverlayManager.showSnackbar(context,
                  type: ContentType.help,
                  title: optionName!.forgotPassword,
                  message: optionName!.verificationCodeMessage);
              BlocProvider.of<ForgotPasswordBloc>(context)
                  .add(
                  ForgotPasswordButtonPressed(email: emailController.text));
            },
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Add some space between the icon and text
                AutoSizeText(
                  optionName!.resendCode,
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
        )
      ],
    );
  }
}
