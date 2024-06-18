// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pos_application/core/common/colors.dart';
// import 'package:pos_application/core/common/label.dart';
// import 'package:pos_application/features/home/domain/repository/menus_repository.dart';
// import 'package:pos_application/features/setting/presentation/menu_setting/menu_setting_body.dart';
// import 'package:pos_application/features/setting/presentation/menu_setting/menu_setting_options.dart';
//
// import '../../../home/presentation/bloc/menu_list_event.dart';
//
//
// class MenuSetting extends StatefulWidget {
//   const MenuSetting({super.key});
//
//   @override
//   State<MenuSetting> createState() => _MenuSettingState();
// }
//
// class _MenuSettingState extends State<MenuSetting>
//     with SingleTickerProviderStateMixin {
//   // late TabController optionsController;
//
//   @override
//   void initState() {
//     super.initState();
//     // optionsController = TabController(length: 1, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
//       decoration: const BoxDecoration(
//         color: AppColors.primaryColor,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               padding: const EdgeInsets.only(left: 10),
//               alignment: Alignment.centerLeft,
//               decoration: const BoxDecoration(
//                   // border: Border(
//                   //   bottom: BorderSide(color: AppColors.iconColor, width: .5),
//                   // ),
//                   ),
//               child:  Row(
//                 children: [
//                   Icon(
//                     Icons.arrow_back_rounded,
//                     color: CupertinoColors.white,
//                     size: 22,
//                   ),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   Text(
//                     'Settings',
//                     style: TextStyle(
//                       letterSpacing: .8,
//                       color: AppColors.whiteColor,
//                       fontFamily: CustomLabels.primaryFont,
//                       fontWeight: CustomLabels.mediumFontWeight,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(width: 5),
//                   InkWell(
//                     onTap: (){
//                       BlocProvider.of<MenuListBloc>(context).add(MenuListButtonPressed());
//                     },
//                     child:Icon(
//                     Icons.arrow_forward_ios_sharp,
//                     color: AppColors.iconColor,
//                     size: 16,
//                   ),),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     'Menu',
//                     style: TextStyle(
//                       letterSpacing: .8,
//                       color: AppColors.whiteColor,
//                       fontFamily: CustomLabels.primaryFont,
//                       fontWeight: CustomLabels.mediumFontWeight,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             // child: MenuSettingOptions(
//             //   optionsController: optionsController,
//             // ),
//             child: MenuSettingOptions(),
//           ),
//           Expanded(
//               flex: 10,
//               // child: MenuSettingBody(
//               //   optionsController: optionsController,
//               // ))
//             child: MenuSettingBody()),
//         ],
//       ),
//     );
//   }
// }
