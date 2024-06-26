import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/icon.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/images/image.dart';
import 'package:pos_application/core/routes/custom_router.dart';
import 'package:pos_application/core/utils/device_dimension.dart';
import 'package:pos_application/features/Profile/domain/repository/profile_repository.dart';
import 'package:pos_application/features/Profile/presentation/bloc/profile_event.dart';
import 'package:pos_application/features/Profile/presentation/bloc/profile_state.dart';
import 'package:pos_application/features/home/domain/repository/logout_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/connectivity.dart';
import 'package:pos_application/features/home/presentation/bloc/logout_event.dart';
import 'package:pos_application/features/home/presentation/bloc/logout_state.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_bloc.dart';
import 'package:pos_application/features/home/presentation/home_components/bottom_buttons/bottom_screen.dart';
import 'package:pos_application/features/home/presentation/home_components/header/rest_details.dart';
import 'package:pos_application/features/home/presentation/home_components/side_order/side_order.dart';
import 'package:pos_application/features/home/presentation/home_components/tables_list/floors_parts.dart';
import 'package:pos_application/features/home/presentation/home_components/tables_list/table_status.dart';
import 'package:pos_application/features/home/presentation/home_components/tables_list/tables.dart';
import 'package:pos_application/features/home/presentation/home_components/tables_list/tables_list.dart';
import 'package:pos_application/features/orders/presentation/orders/order_bottom.dart';

import '../../../../core/common/table_drag.dart';
import '../../../../core/common/w_custom_button.dart';
import '../../../auth/widget/custom_snackbar.dart';
import '../bloc/menu_name_event.dart';
import '../bloc/table_bloc/set_selected_floor_table_bloc.dart';
import '../bloc/table_bloc/set_selected_floor_table_state.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

Widget headerPart(context) {
  return Expanded(
    flex: 1,
    child: Container(
      margin: const EdgeInsets.only(left: 5),
      color: AppColors.whiteColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 0),
              //color: Colors.yellow,
              child: const RestaurantDetails(),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: DeviceUtils.getDeviceDimension(context).width > 1000 ? 4 : 0,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 18,
                    child: CustomIcon(
                      color: AppColors.darkColor,
                      iconPath: AllIcons.bell,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  SizedBox(
                    height: 18,
                    child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
                        builder: (context, state) {
                      return CustomIcon(
                        color: AppColors.darkColor,
                        iconPath: (state.isConnected)
                            ? AllIcons.olStatus
                            : AllIcons.ofStatus,
                        size: 40,
                      );
                    }),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                    if (state is ProfileStateInitial) {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(ProfileButtonPressed());
                    }
                    if (state is ProfileStateSuccess) {
                      return CircleAvatar(
                        minRadius: 15,
                        maxRadius: 15,
                        child: CachedNetworkImage(
                          imageUrl: state.user.user.profilePhotoUrl!,
                          imageBuilder: (context, imageProvider) => ClipOval(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              Image.asset('assets/icons/per.png'),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        minRadius: 15,
                        maxRadius: 15,
                        child: Image.asset('assets/icons/per.png'),
                      );
                    }
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileStateInitial) {
                        BlocProvider.of<ProfileBloc>(context)
                            .add(ProfileButtonPressed());
                      }
                      if (state is ProfileStateSuccess) {
                        return AutoSizeText(
                          state.user.user.name,
                          textAlign: TextAlign.center,
                          minFontSize: 10,
                          maxFontSize: 16,
                          style: CustomLabels.textTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          presetFontSizes: const [14],
                        );
                      } else {
                        return AutoSizeText(
                          'Deanna Leya',
                          textAlign: TextAlign.center,
                          minFontSize: 12,
                          maxFontSize: 16,
                          style: CustomLabels.textTextStyle(
                              color: AppColors.whiteColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          presetFontSizes: const [14],
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  BlocBuilder<LogoutBloc, LogoutState>(
                    builder: (context, state) {
                      if (state is LogoutSuccess) {
                        customRouter.go('/login');
                      }
                      return PopupMenuButton(
                          position: PopupMenuPosition.under,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: AppColors.darkColor,
                            size: 20,
                          ),
                          color: AppColors.whiteColor,
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                    onTap: () {
                                      BlocProvider.of<LogoutBloc>(context)
                                          .add(LogoutButtonPressed());
                                    },
                                    textStyle: const TextStyle(
                                      color: AppColors.darkColor,
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color: AppColors.darkColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                            color: AppColors.darkColor,
                                          ),
                                        ),
                                      ],
                                    )),
                              ]);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget middleBody(TabController tabController) {
  return Expanded(
    flex: 10,
    child: Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: FloorScreen(
              tabController: tabController,
            ),
          ),
          const Expanded(
            flex: 1,
            child: AllTableStatus(),
          ),
          Expanded(
            flex: 11,
            child: TablesList(
              tabController: tabController,
            ),
          )
        ],
      ),
    ),
  );
}

Widget middleBodySettingTable(TabController tabController,bool? isNewTable) {
  return Expanded(
    flex: 10,
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: FloorScreen(
                  tabController: tabController,
                ),
              ),
              Expanded(
                flex: 1,
                child: settingTableButton(),
              ),
              Expanded(
                flex: 11,
                child: TableDragPage(
                  containerWidth: constraints.maxWidth,
                  containerHeight: constraints.maxHeight,
                  isNewTable: isNewTable!,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}


Widget bottomPart() {
  return Expanded(
    flex: 1,
    child: Container(
      margin: const EdgeInsets.only(left: 5),
      color: AppColors.whiteColor,
      child: const BottomScreen(),
    ),
  );
}

Widget buildBlueColumn() {
  return const Expanded(
    flex: 4,
    child: OrderScreen(),
  );
}

Widget orderBottom() {
  return Expanded(
    flex: 1,
    child: Container(
      margin: const EdgeInsets.only(left: 5),
      color: AppColors.whiteColor,
      child: const OrderBottom(),
    ),
  );
}

Widget settingTableButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        width: 120,
        margin: const EdgeInsets.only(right: 30),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor.withOpacity(.1),
          border: Border.all(
            color: AppColors.secondaryColor.withOpacity(.8),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: BlocBuilder<SetSelectedFloorTableBloc, SetSelectedFloorTableState>(
          builder: (context, state) {
            String? floorname = "";
            if(state is SetSelectedFloorTableSuccess){
              floorname = state.floorTable;
            }
            return CustomButton(
              onPressed: () {
                if (floorname!.isEmpty) {
                  OverlayManager.showSnackbar(
                    context,
                    type: ContentType.failure,
                    title: AppLocalizations.of(context)!.addaTable,
                    message: AppLocalizations.of(context)!.tableSelectionMessage,
                  );
                } else {
                 //need to add
                  BlocProvider.of<MenuNameBloc>(context).add(
                      MenuNameSelected(
                          context: context, menuName: "Setting new Table"));
                }
              },
              text: AppLocalizations.of(context)!.addaTable,
              activeButtonColor: AppColors.secondaryColor,
              backgroundColor: AppColors.darkColor,
              textStyle: const TextStyle(
                  color: AppColors.whiteColor,
                  fontFamily: CustomLabels.primaryFont),
            );
          },
        ),
      ),
    ],
  );
}
