import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/images/image.dart';
import 'package:pos_application/features/home/data/menu_list.dart';
import 'package:pos_application/features/home/domain/repository/menus_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_list_state.dart';
import 'package:pos_application/features/menu/domain/cart_response.dart';

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
          dataRowColor: MaterialStateColor.resolveWith(
              (states) => AppColors.primaryColor),
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
            color: AppColors.primaryColor,
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
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.iconColor, width: .5),
                    ),
                  ),
                  child: Text(
                    optionName!.menuList,
                    style: const TextStyle(
                      letterSpacing: .8,
                      color: AppColors.whiteColor,
                      fontFamily: CustomLabels.primaryFont,
                      fontWeight: CustomLabels.mediumFontWeight,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
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
                        (states) => AppColors.primaryColor),
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
                              color: AppColors.iconColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                      ),
                       DataColumn2(
                        label: Text(
                          optionName!.image,
                          style: TextStyle(
                              color: AppColors.iconColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                      ),
                       DataColumn2(
                        label: Center(
                            child:Text(
                          optionName!.menuName,
                          style: TextStyle(
                              color: AppColors.iconColor,
                              fontFamily: CustomLabels.primaryFont),
                        )),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            if (ascending) {
                              resultOrders.sort((a, b) =>
                                  a.name!
                                      .compareTo(b.name!));
                            } else {
                              resultOrders.sort((a, b) =>
                                  b.name!
                                      .compareTo(a.name!));
                            }
                          });
                        },
                      ),
                      DataColumn2(
                        label:  Text(
                          optionName!.type,
                          style: TextStyle(
                              color: AppColors.iconColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            if (ascending) {
                              resultOrders.sort((a, b) =>
                                  a.type.compareTo(
                                      b.type));
                            } else {
                              resultOrders.sort((a, b) =>
                                  b.type.compareTo(
                                      a.type));
                            }
                          });
                        },
                      ),
                      DataColumn2(
                        label:  Text(
                          optionName!.category,
                          style: TextStyle(
                              color: AppColors.iconColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            if (ascending) {
                              resultOrders.sort((a, b) =>
                                  a.menuCategories.first.name.compareTo(
                                      b.menuCategories.first.name!));
                            } else {
                              resultOrders.sort((a, b) =>
                                  b.menuCategories.first.name.compareTo(
                                      a.menuCategories.first.name));
                            }
                          });
                        },
                      ),
                       DataColumn2(
                        label: Text(
                          "${optionName.price} {In ${currency}}",
                          style: TextStyle(
                              color: AppColors.iconColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            if (ascending) {
                              resultOrders.sort((a, b) =>
                                  a.price
                                      .compareTo(b.price));
                            } else {
                              resultOrders.sort((a, b) =>
                                  b.price
                                      .compareTo(a.price));
                            }
                          });
                        },
                      ),
                       DataColumn2(
                        label: Text(
                          optionName!.active,
                          style: const TextStyle(
                              color: AppColors.iconColor,
                              fontFamily: CustomLabels.primaryFont),
                        ),
                      ),
                    ],
                    source: OrderDataSource(resultOrders, context,currency),
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
    var id = index + 1 ;
    return DataRow(cells: [
      DataCell(Center(
        child: Text(
          id.toString(),
          style: const TextStyle(
              fontFamily: CustomLabels.primaryFont,
              color: AppColors.whiteColor),
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
            fontFamily: CustomLabels.primaryFont, color: AppColors.whiteColor),
      ))),
      DataCell(Center(
          child: Row(children: [
        Text(
          menus.type,
          style: const TextStyle(
              fontFamily: CustomLabels.primaryFont,
              color: AppColors.whiteColor),
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
            fontFamily: CustomLabels.primaryFont, color: AppColors.whiteColor),
      )),
      DataCell(Center(
        child: Text(
          menus.price,
          style: TextStyle(
            fontFamily: CustomLabels.primaryFont,
            color: changeColor("Placed"),
          ),
        ),
      )),
      DataCell(Center(
        child: Transform.scale(
          scale: 0.5, // Adjust the scale to make the Switch smaller
          child: Switch(
            value: menus.active ? true : false,
            activeColor: Colors.blue,
            onChanged: (bool value) {},
          ),
        ),

      )),
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

String changeIcon(String typeName){
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
