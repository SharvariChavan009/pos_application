import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoginFailure) {
            OverlayManager.showSnackbar(context,
                type: ContentType.failure,
                title: "Login Error",
                message: CustomMessages.loginFailed);
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
                BlocProvider.of<ProfileBloc>(context).add(
                    ProfileButtonPressed());
              }
            }

                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.darkColor,
                    image: DecorationImage(
                      image: AssetImage(AppImage.login),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: (DeviceUtils.getDeviceDimension(context)
                                            .width) >
                                        800
                                    ? 2
                                    : 0,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 5,
                                child: Stack(
                                  fit: StackFit.loose,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  children: [
                                    Container(
                                      height: (DeviceUtils.getDeviceDimension(
                                                  context)
                                              .height *
                                          .9),
                                      decoration: const BoxDecoration(
                                        color: AppColors.darkColor,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                        image: DecorationImage(
                                          image: AssetImage(AppImage.login1),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Hero(
                                      tag: 'Logo',
                                      child: Center(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 440),
                                          height: 80,
                                          width: DeviceUtils.getDeviceDimension(
                                                      context)
                                                  .width *
                                              .14,
                                          child: Image.asset(
                                            AppImage.logo1,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 280),
                                      child: Center(
                                        child: AutoSizeText(
                                          'Embark on an extraordinary culinary journey with our \nenchantingly efficient POS experience.',
                                          textAlign: TextAlign.center,
                                          minFontSize: 13,
                                          maxFontSize: 18,
                                          style: CustomLabels.bodyTextStyle(
                                              fontSize: 13,
                                              fontFamily:
                                                  CustomLabels.primaryFont,
                                              letterSpacing: 0,
                                              color: AppColors.iconColor),
                                          maxLines: 2,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex:
                                            MediaQuery.of(context).size.width >
                                                    1000
                                                ? 1
                                                : 0,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: BlocBuilder<MenuNameBloc,
                                                    MenuNameState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is MenuNameFetchedSuccess) {
                                                      switch (state.name) {
                                                        case Screens
                                                              .forgotPasswordScreen:
                                                          return Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child:
                                                                const ForgotPassword(),
                                                          );
                                                        case Screens
                                                              .loginScreen:
                                                          return Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: LoginColumn(
                                                                context),
                                                          );
                                                        case Screens
                                                              .verificationCodeScreen:
                                                          return Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child:
                                                                const VerificationCodeScreen(),
                                                          );
                                                        case Screens
                                                              .resetPasswordScreen:
                                                          return Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child:
                                                                const ResetPasswordScreen(),
                                                          );
                                                        case Screens
                                                              .passwordUpdatedScreen:
                                                          return Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child:
                                                                const PasswordUpdationScreen(),
                                                          );
                                                        default:
                                                          return Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: LoginColumn(
                                                                context),
                                                          );
                                                      }
                                                    } else {
                                                      return Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: LoginColumn(
                                                            context),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2, child: Container())
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex:
                                            MediaQuery.of(context).size.width >
                                                    1000
                                                ? 1
                                                : 0,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: (DeviceUtils.getDeviceDimension(context)
                                            .width) >
                                        800
                                    ? 2
                                    : 0,
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                );

          },
        ),
      ),
    );
  }
}

Widget LoginColumn(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        alignment: AlignmentDirectional.center,
        child: Center(
          child: AutoSizeText(
            CustomMessages.loginWelcomeMessage,
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
        CustomMessages.loginSecondaryMessage,
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
                hintText: 'Email',
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
                        : CustomMessages.invalidEmailErrorMessage,
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
                hintText: 'Password',
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
                        : CustomMessages.invalidPasswordErrorMessage,
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
        child: AutoSizeText(
          'Forgot Password?',
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
      ),
      const SizedBox(
        height: 20,
      ),
      CustomButton(
        text: 'Login',
        activeButtonColor: AppColors.secondaryColor,
        textStyle: CustomLabels.bodyTextStyle(
            fontSize: 14, color: AppColors.darkColor),
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
