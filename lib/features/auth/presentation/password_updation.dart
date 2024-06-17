
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/screen_names.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import '../../../core/images/image.dart';
import '../../home/presentation/bloc/menu_name_bloc.dart';
import '../../home/presentation/bloc/menu_name_event.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class PasswordUpdationScreen extends StatelessWidget {
  const PasswordUpdationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppImage.resetPasswordImage,
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        Container(
          alignment:
          AlignmentDirectional
              .center,
          child: Center(
            child: AutoSizeText(
              optionName!.passwordUpdatedSuccessfully,
              textAlign:
              TextAlign.center,
              minFontSize: 10,
              maxFontSize: 30,
              maxLines: 2,
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
          optionName!.loginBelow,
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
          maxLines: 1,
        ),
        const SizedBox(
          height: 50,
        ),
        CustomButton(
          text: optionName!.login,
          activeButtonColor: AppColors
              .secondaryColor,
          textStyle: CustomLabels
              .bodyTextStyle(
              fontSize: 14,
              color: AppColors
                  .darkColor),
          onPressed: () {
            BlocProvider.of<MenuNameBloc>(context)
                .add(MenuNameSelected(context: context, menuName: Screens.loginScreen));
          },
        ),
      ],
    );
  }
}
