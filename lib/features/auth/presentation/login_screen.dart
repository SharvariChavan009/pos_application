import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/c_text_field.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/common_messages.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import 'package:pos_application/core/routes/custom_router.dart';
import 'package:pos_application/core/utils/device_dimension.dart';
import 'package:pos_application/features/Profile/domain/repository/profile_repository.dart';
import 'package:pos_application/features/Profile/presentation/bloc/profile_event.dart';
import 'package:pos_application/features/Profile/presentation/bloc/profile_state.dart';
import 'package:pos_application/features/auth/domain/repository/login_repository.dart';
import 'package:pos_application/features/auth/presentation/bloc/login_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/login_state.dart';
import 'package:pos_application/features/auth/presentation/bloc/password_validation_bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/password_validation_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/password_validation_state.dart';
import 'package:pos_application/features/auth/presentation/bloc/textfield_validation_bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/textfield_validation_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/textfield_validation_state.dart';
import 'package:pos_application/features/auth/presentation/password_updation.dart';
import 'package:pos_application/features/auth/presentation/reset_password.dart';
import 'package:pos_application/features/auth/presentation/verification_code.dart';
import 'package:pos_application/features/auth/widget/custom_snackbar.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_state.dart';
import '../../../core/common/screen_names.dart';
import '../../../core/common/u_validations_all.dart';
import '../../../core/images/image.dart';
import '../../home/presentation/bloc/menu_name_event.dart';
import 'forgot_password.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:pos_application/features/home/domain/repository/floor_table_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/floor_table_event.dart';
import 'package:pos_application/features/home/presentation/bloc/floor_table_state.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          OverlayManager.showSnackbar(context,
              type: ContentType.failure,
              title: optionName!.loginError,
              message: optionName!.loginFailed);
        } else if (state is LoginSuccess) {
          customRouter.go('/home');
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoginSuccess) {
            if (state is ProfileStateInitial) {
              BlocProvider.of<ProfileBloc>(context).add(ProfileButtonPressed());
            }
          }
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.splash),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      Column(children: [
                        Image.asset(
                          height: 250,
                          width: 600,
                          AppImage.appLogo1,
                          fit: BoxFit.contain,
                        ),
                        AutoSizeText(
                          optionName!.loginWelcomeMsg,
                          textAlign: TextAlign.center,
                          minFontSize: 20,
                          maxFontSize: 22,
                          style: CustomLabels.body1TextStyle(
                              color: AppColors.darkColor,
                              fontSize: 30,
                              fontWeight: CustomLabels.smallFontWeight),
                          maxLines: 2,
                        ),
                      ]),
                      const SizedBox(
                        width: 50,
                      ),
                      LoginColumn(context),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ))
                ]),
          );
        },
      ),
    ));
  }
}

Widget LoginColumn(BuildContext context) {
  var optionName = AppLocalizations.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        alignment: AlignmentDirectional.center,
        child: Center(
            child: AutoSizeText(
          optionName!.loginBack,
          textAlign: TextAlign.center,
          minFontSize: 10,
          maxFontSize: 30,
          maxLines: 1,
          style: CustomLabels.bodyTextStyle(
              fontSize: 30,
              fontFamily: CustomLabels.primaryFont,
              letterSpacing: .5,
              color: AppColors.darkColor),
        )),
      ),
      SizedBox(
        height: 10,
      ),
      AutoSizeText(
        optionName!.loginSecondaryMessage,
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
        height: 30,
      ),
      BlocBuilder<TextFieldValidationBloc, TextfieldValidationState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: emailController,
                hintText: optionName!.email,
                cursorColor: AppColors.secondaryColor,
                borderColor: (state is TextFieldValidationSuccess ||
                        state is TextfieldValidationInitial)
                    ? AppColors.secondaryColor
                    : Colors.red,
              ),
              Padding(
                padding: (state is TextFieldValidationSuccess ||
                        state is TextfieldValidationInitial)
                    ? EdgeInsets.zero
                    : const EdgeInsets.only(
                        left: 8, top: 5, right: 0, bottom: 0),
                child: Visibility(
                  visible: state is TextfieldValidationFailure,
                  child: AutoSizeText(
                    (state is TextFieldValidationSuccess ||
                            state is TextfieldValidationInitial)
                        ? ''
                        : optionName!.invalidEmailErrorMessage,
                    minFontSize: 10,
                    maxFontSize: 14,
                    textAlign: TextAlign.left,
                    style: CustomLabels.body1TextStyle(
                        fontFamily: CustomLabels.primaryFont,
                        color: Colors.red),
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
      BlocBuilder<PasswordValidationBloc, PasswordValidationState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: passwordController,
                hintText: optionName!.password,
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
                        left: 8, top: 5, right: 0, bottom: 5),
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
                    style: CustomLabels.body1TextStyle(
                        fontFamily: CustomLabels.primaryFont,
                        color: Colors.red),
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
      GestureDetector(
          onTap: () {
            BlocProvider.of<MenuNameBloc>(context).add(MenuNameSelected(
                context: context, menuName: Screens.forgotPasswordScreen));
          },
          child: Row(children: [
            SizedBox(
              width: (DeviceUtils.getDeviceDimension(context).width) > 800
                  ? 220
                  : 0,
            ),
            AutoSizeText(
              optionName!.forgotPassword,
              textAlign: TextAlign.right,
              minFontSize: 13,
              maxFontSize: 18,
              style: CustomLabels.bodyTextStyle(
                  fontSize: 13,
                  fontFamily: CustomLabels.primaryFont,
                  letterSpacing: 0,
                  color: AppColors.secondaryColor),
              maxLines: 1,
            ),
          ])),
      const SizedBox(
        height: 20,
      ),
      CustomButton(
        text: optionName!.login,
        activeButtonColor: AppColors.secondaryColor,
        textStyle: CustomLabels.bodyTextStyle(
            fontSize: 18, color: AppColors.darkColor),
        onPressed: () {
          BlocProvider.of<PasswordValidationBloc>(context)
              .add(PasswordValidationPressedEvent(passwordController.text));
          // }else{
          BlocProvider.of<TextFieldValidationBloc>(context)
              .add(TextfieldValidationEvent(emailController.text));
          // }
          if (ValidationsAll.isValidEmail(emailController.text) &&
              ValidationsAll.isValidPassword(passwordController.text)) {
            BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
              email: emailController.text,
              password: passwordController.text,
            ));
          }
        },
      ),
    ],
  );
}
