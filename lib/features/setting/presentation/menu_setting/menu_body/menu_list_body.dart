import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/images/image.dart';
import 'package:pos_application/features/home/data/menu_list.dart';
import 'package:pos_application/features/home/domain/repository/menus_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_list_state.dart';
import 'package:pos_application/features/menu/domain/cart_response.dart';
import 'package:pos_application/features/setting/bloc/menu_setting_bloc.dart';
import 'package:pos_application/features/setting/bloc/menu_setting_state.dart';

import '../../../../../core/common/api_methods.dart';
import '../../../../../core/common/icon.dart';
import '../../../../home/domain/repository/cancel_order_repository.dart';
import '../../../../home/presentation/bloc/menu_list_event.dart';
import '../../../../home/presentation/bloc/menu_name_bloc.dart';
import '../../../../home/presentation/bloc/menu_name_event.dart';
import '../../../../home/presentation/bloc/order_bloc/cancel_order_event.dart';
import '../../../../orders/data/order_data.dart';
import '../../../../orders/domain/repository/order_list_repository.dart';
import '../../../../orders/presentation/bloc/order_list/order_list_event.dart';
import '../../../../orders/presentation/bloc/order_list/order_list_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../orders/presentation/orders/order_status.dart';
import '../../../bloc/menu_setting_event.dart';

class MenuListSetting extends StatefulWidget {
  const MenuListSetting({super.key});

  @override
  MenuListSettingState createState() => MenuListSettingState();
}

class MenuListSettingState extends State<MenuListSetting> {
  int _rowsPerPage = 10;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  String? currency;

  List<MenuItem> orders = [];
  List<MenuItem> sortedOrders = [];
  List<MenuItem> resultOrders = [];
  @override
  void initState() {
    super.initState();
    fetchCurrency();
  }

  void fetchCurrency() async {
    currency = await ApiMethods.getCurrency();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return Theme(
      data: ThemeData(
        dataTableTheme: DataTableThemeData(
          dataRowColor:
              MaterialStateColor.resolveWith((states) => AppColors.lightGray),
        ),
      ),
      child:
          BlocBuilder<MenuListBloc, MenuListState>(builder: (context, state) {
        switch (state.runtimeType) {
          case MenuListStateInitial:
            BlocProvider.of<MenuListBloc>(context).add(MenuListButtonPressed());
            return const Center(child: CircularProgressIndicator());
          case MenuListStateSuccess:
            final successState = state as MenuListStateSuccess;
            orders = successState.menus!;
            print(orders.length);
            if (orders.isEmpty) {
              return Center(
                child: Text(
                  optionName!.noOrdersFound,
                  style: const TextStyle(
                    fontSize: 30.0,
                    color: AppColors.whiteColor,
                    fontFamily: CustomLabels.primaryFont,
                  ),
                ),
              );
            } else {
              resultOrders = orders;
            }

            break;
        }
        return Container(
          margin:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
          decoration: const BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Row(children: [
                    InkWell(
                        onTap: () {
                          BlocProvider.of<MenuNameBloc>(context).add(
                              MenuNameSelected(
                                  context: context, menuName: "Setting"));
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.iconColor,
                          size: 22,
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: AppColors.iconColor, width: .5),
                        ),
                      ),
                      child: Text(
                        optionName!.menuList,
                        style: const TextStyle(
                          letterSpacing: .8,
                          color: AppColors.darkColor,
                          fontFamily: CustomLabels.primaryFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ])),
              // Expanded(flex: 1, child: OrderStatus(orders)),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: PaginatedDataTable(
                    horizontalMargin: 10,
                    showEmptyRows: false,
                    showFirstLastButtons: true,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.lightGray),
                    arrowHeadColor: AppColors.secondaryColor,
                    columnSpacing: 60,
                    rowsPerPage: _rowsPerPage,
                    onRowsPerPageChanged: (value) {
                      setState(
                        () {
                          _rowsPerPage =
                              value ?? PaginatedDataTable.defaultRowsPerPage;
                        },
                      );
                    },
                    sortAscending: _sortAscending,
                    sortColumnIndex: _sortColumnIndex,
                    columns: [
                      DataColumn2(
                        label: Text(
                          optionName!.srNo,
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                      ),
                      DataColumn2(
                        label: Text(
                          optionName!.image,
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                      ),
                      DataColumn2(
                        label: Center(
                            child: Text(
                          optionName!.menuName,
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontFamily: CustomLabels.primaryFont),
                        )),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            if (ascending) {
                              resultOrders
                                  .sort((a, b) => a.name!.compareTo(b.name!));
                            } else {
                              resultOrders
                                  .sort((a, b) => b.name!.compareTo(a.name!));
                            }
                          });
                        },
                      ),
                      DataColumn2(
                        label: Text(
                          optionName!.type,
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            if (ascending) {
                              resultOrders
                                  .sort((a, b) => a.type.compareTo(b.type));
                            } else {
                              resultOrders
                                  .sort((a, b) => b.type.compareTo(a.type));
                            }
                          });
                        },
                      ),
                      DataColumn2(
                        label: Text(
                          optionName!.category,
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            if (ascending) {
                              resultOrders.sort((a, b) => a
                                  .menuCategories.first.name
                                  .compareTo(b.menuCategories.first.name!));
                            } else {
                              resultOrders.sort((a, b) => b
                                  .menuCategories.first.name
                                  .compareTo(a.menuCategories.first.name));
                            }
                          });
                        },
                      ),
                      DataColumn2(
                        label: Text(
                          "${optionName.price} {In ${currency}}",
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            if (ascending) {
                              resultOrders
                                  .sort((a, b) => a.price.compareTo(b.price));
                            } else {
                              resultOrders
                                  .sort((a, b) => b.price.compareTo(a.price));
                            }
                          });
                        },
                      ),
                      DataColumn2(
                        label: Text(
                          optionName!.active,
                          style: const TextStyle(
                              color: AppColors.buttonColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                      ),
                    ],
                    source: OrderDataSource(resultOrders, context, currency),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class OrderDataSource extends DataTableSource {
  final List<MenuItem> orders;
  BuildContext context;
  String? Currency;
  OrderDataSource(this.orders, this.context, this.Currency);

  @override
  DataRow? getRow(int index) {
    if (index >= orders.length) return null;
    var optionName = AppLocalizations.of(context);
    final menus = orders[index];
    var id = index + 1;
    return DataRow(cells: [
      DataCell(Center(
        child: Text(
          id.toString(),
          style: const TextStyle(
              fontFamily: CustomLabels.primaryFont, color: AppColors.darkColor),
        ),
      )),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: CachedNetworkImage(
            imageUrl: menus.images.first,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => LinearProgressIndicator(
              color: Colors.transparent,
              backgroundColor: AppColors.secondaryColor.withOpacity(.1),
            ),
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          ),
        ),
      ),
      DataCell(Center(
          child: Text(
        menus.name,
        style: TextStyle(
            fontFamily: CustomLabels.primaryFont, color: AppColors.darkColor),
      ))),
      DataCell(Center(
          child: Row(children: [
        Text(
          menus.type,
          style: const TextStyle(
              fontFamily: CustomLabels.primaryFont, color: AppColors.darkColor),
        ),
        const SizedBox(
          width: 5,
        ),
        Image.asset(
          changeIcon(menus.type),
          height: 20,
          width: 20,
        ),
      ]))),
      DataCell(Text(
        menus.menuCategories.first.name,
        style: TextStyle(
            fontFamily: CustomLabels.primaryFont, color: AppColors.darkColor),
      )),
      DataCell(Center(
        child: Text(
          "${menus.price}/-",
          style: TextStyle(
            fontFamily: CustomLabels.primaryFont,
            color: AppColors.darkColor,
          ),
        ),
      )),
      // DataCell(
      //     Center(
      //       child: Transform.scale(
      //         scale: 0.5, // Adjust the scale to make the Switch smaller
      //         child: Switch(
      //           value: menus.active ? true : false,
      //           activeColor: Colors.blue,
      //           onChanged: (bool value) {
      //
      //             print("is active ? ${value} with id =${menus.id}");
      //             BlocProvider.of<MenuSettingBloc>(context)
      //                 .add(MenuSettingPressed(menus.id));
      //             BlocProvider.of<MenuListBloc>(context).add(MenuListButtonPressed());
      //
      //           },
      //         ),
      //       ),
      //     )
      //    ),
      DataCell(
        BlocBuilder<MenuSettingBloc, MenuSettingState>(
          builder: (context, state) {
            if(state is MenuSettingSuccess){

            }
            return Center(
              child: Transform.scale(
                scale: 0.5, // Adjust the scale to make the Switch smaller
                child: Switch(
                  value: menus.active ? true : false,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    // BlocProvider.of<MenuSettingBloc>(context)
                    //     .add(MenuSettingPressed(menus.id));
                    // Future.delayed(const Duration(seconds: 1), () {
                    //   BlocProvider.of<MenuListBloc>(context)
                    //       .add(MenuListButtonPressed());
                    // });
                    showDialog(
                      context: context,
                      builder: (BuildContext context1) {
                        return AlertDialog(
                          title:
                              Text(value ? optionName!.activateMenu : optionName!.deactivateMenu),
                          content: Text(value
                              ? optionName!.doyouwanttoactivatethismenu
                              : optionName!.doyouwanttodeactivatethismenu),
                          actions: [
                            TextButton(
                              child: Text(optionName!.cancel),
                              onPressed: () {
                                Navigator.of(context1)
                                    .pop(); // Dismiss the dialog
                              },
                            ),
                            TextButton(
                              child: Text(optionName!.oK),
                              onPressed: () {
                                Navigator.of(context1)
                                    .pop(); // Dismiss the dialog
                                BlocProvider.of<MenuSettingBloc>(context)
                                    .add(MenuSettingPressed(menus.id));
                                Future.delayed(const Duration(seconds: 1), () {
                                  BlocProvider.of<MenuListBloc>(context)
                                      .add(MenuListButtonPressed());
                                });
                              }),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      )
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orders.length;

  @override
  int get selectedRowCount => 0;
}

MaterialColor changeColor(String name) {
  switch (name) {
    case "Placed" || "وضعت":
      return Colors.green;
    case "Cancelled" || "ألغيت":
      return Colors.red;
    case "Preparing" || "خطة":
      return Colors.yellow;
    case "Ready" || "مستعد":
      return Colors.orange;
    case "Completed" || "مكتمل":
      return Colors.blue;
    default:
      return Colors.red;
  }
}

String changeIcon(String typeName) {
  switch (typeName) {
    case "Veg":
      return AllIcons.veg;
    case "NonVeg":
      return AllIcons.chkn;
    case "Egg":
      return AllIcons.egg;
    case "Vegan":
      return AllIcons.vegan;
    default:
      return AllIcons.veg;
  }
}
