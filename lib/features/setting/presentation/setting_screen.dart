import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/images/image.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_event.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  bool light0 = true;
  bool light1 = true;

  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    Widget? trailing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture.asset(
                iconPath,
                colorFilter: const ColorFilter.mode(
                  AppColors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 30),
            Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontFamily: CustomLabels.primaryFont,
                fontSize: 16,
                color: AppColors.whiteColor,
              ),
            ),
            const Spacer(),
            trailing ?? const SizedBox.shrink(),
            const SizedBox(width: 30),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 50, top: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: (title == "Notifications")
                    ? Colors.transparent
                    : AppColors.iconColor,
                width: .2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          onChanged(!value);
        });
      },
      child: Switch.adaptive(
        value: value,
        inactiveThumbColor: AppColors.iconColor,
        activeColor: AppColors.secondaryColor,
        inactiveTrackColor: AppColors.primaryColor,
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.iconColor, width: .5),
                ),
              ),
              child: const Text(
                'Setting',
                style: TextStyle(
                  letterSpacing: .8,
                  color: AppColors.whiteColor,
                  fontFamily: CustomLabels.primaryFont,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.only(left: 30, top: 30, bottom: 30),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                    iconPath: AllIcons.menu,
                    title: 'Menu',
                    trailing: InkWell(
                      onTap: () {
                        BlocProvider.of<MenuNameBloc>(context).add(
                            MenuNameSelected(
                                context: context, menuName: "Setting Menu"));
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: AppColors.iconColor,
                        size: 18,
                      ),
                    ),
                  ),
                  _buildMenuItem(
                    iconPath: AllIcons.tables,
                    title: 'Tables',
                    trailing: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColors.iconColor,
                      size: 18,
                    ),
                  ),
                  _buildMenuItem(
                    iconPath: AllIcons.lang,
                    title: 'Language',
                    trailing: const Row(
                      children: [
                        Text(
                          'English',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 14,
                            fontFamily: CustomLabels.primaryFont,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: AppColors.iconColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  _buildMenuItem(
                    iconPath: AllIcons.sound,
                    title: 'Sounds',
                    trailing: _buildSwitch(
                      value: light1,
                      onChanged: (value) {
                        setState(() {
                          light1 = value;
                        });
                      },
                    ),
                  ),
                  _buildMenuItem(
                    iconPath: AllIcons.notif,
                    title: 'Notifications',
                    trailing: _buildSwitch(
                      value: light0,
                      onChanged: (value) {
                        setState(() {
                          light0 = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(flex: 3, child: SizedBox()),
        ],
      ),
    );
  }
}
