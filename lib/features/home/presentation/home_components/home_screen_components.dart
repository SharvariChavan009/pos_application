import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/utils/device_dimension.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_state.dart';
import 'package:pos_application/features/home/presentation/home_components/home_widgets.dart';

import 'package:pos_application/features/menu/presentation/menu/menu_body.dart';
import 'package:pos_application/features/orders/presentation/orders/order_details.dart';
import 'package:pos_application/features/orders/presentation/orders/order_list.dart';
import 'package:pos_application/features/payment/presentation/payment_list.dart';
import 'package:pos_application/features/setting/presentation/menu_setting/menu_body/menu_list_body.dart';
import 'package:pos_application/features/setting/presentation/setting_screen.dart';
import 'package:pos_application/features/staff_attendance/presentation/staff_attendance.dart';


Widget buildContentColumn(context, TabController tabController) {
  return Expanded(
    flex: (DeviceUtils.getDeviceDimension(context).width) > 1000
        ? 10
        : (DeviceUtils.getDeviceDimension(context).width) > 900
            ? 8
            : 6,
    child: Column(
      children: [
        BlocBuilder<MenuNameBloc, MenuNameState>(
          builder: (context, state) {
            if (state is MenuNameFetchedSuccess) {
              String name = state.name;
              switch (name) {
                case "Home":
                  return SizedBox(
                  height: DeviceUtils.getDeviceDimension(context).height,
                  child: Column(
                    children: [
                      headerPart(context),
                      middleBody(tabController),
                      bottomPart(),
                    ],
                  ),
                );
                case "Menu": return SizedBox(
                  height: DeviceUtils.getDeviceDimension(context).height,
                  child: Column(
                    children: [
                      headerPart(context),
                      const Expanded(
                        flex: 11,
                        child: ListOfMenus(),
                      ),
                    ],
                  ),
                );
                case "Orders":
                  return SizedBox(
                  height: DeviceUtils.getDeviceDimension(context).height,
                  child: Column(
                    children: [
                      headerPart(context),
                      const Expanded(
                        flex: 11,
                        child: OrderList(),
                      ),
                    ],
                  ),
                );
                case "Payment":
                  return SizedBox(
                  height: DeviceUtils.getDeviceDimension(context).height,
                  child: Column(
                    children: [
                      headerPart(context),
                      const Expanded(
                        flex: 11,
                        child: PaymentList(),
                      ),
                    ],
                  ),
                );
                case "Setting": return SizedBox(
                  height: DeviceUtils.getDeviceDimension(context).height,
                  child: Column(
                    children: [
                      headerPart(context),
                       Expanded(
                        flex: 11,
                        child: SettingScreen(),
                      ),
                    ],
                  ),
                );
                case "View Order": return SizedBox(
                  height: DeviceUtils.getDeviceDimension(context).height,
                  child: Column(
                    children: [
                      headerPart(context),
                      const Expanded(
                        flex: 11,
                        child: OrderDetails(),
                      ),
                      orderBottom(),
                    ],
                  ),
                );
                case "Setting Menu":
                  return SizedBox(
                  height: DeviceUtils.getDeviceDimension(context).height,
                  child: Column(
                    children: [
                      headerPart(context),
                      const Expanded(
                        flex: 11,
                        child: MenuListSetting(),
                      ),
                      bottomPart(),
                    ],
                  ),
                );
                case "Setting Table" ||"Setting new Table":
                  return SizedBox(
                    height: DeviceUtils.getDeviceDimension(context).height,
                    child: Column(
                      children: [
                        headerPart(context),
                        (name == "Setting new Table") ? middleBodySettingTable(tabController,true) : middleBodySettingTable(tabController, false),
                        bottomPart(),
                      ],
                    ),
                  );
                case "Staff Attendance":
                  return SizedBox(
                    height: DeviceUtils.getDeviceDimension(context).height,
                    child: Column(
                      children: [
                        headerPart(context),
                        const Expanded(
                          flex: 11,
                          child: StaffAttendancePage(),
                        ),
                      ],
                    ),
                  );
                default: return SizedBox(
                  height: DeviceUtils.getDeviceDimension(context).height,
                  child: Column(
                    children: [
                      headerPart(context),
                      middleBody(tabController),
                      bottomPart(),
                    ],
                  ),
                );
              }
            }
            return SizedBox(
              height: DeviceUtils.getDeviceDimension(context).height,
              child: Column(
                children: [
                  headerPart(context),
                  middleBody(tabController),
                  bottomPart(),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
