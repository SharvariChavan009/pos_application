import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/features/orders/data/order_data.dart';
import 'package:pos_application/features/orders/domain/repository/order_list_repository.dart';
import 'package:pos_application/features/orders/presentation/orders/order_status.dart';
import '../../../home/domain/repository/cancel_order_repository.dart';
import '../../../home/presentation/bloc/menu_name_bloc.dart';
import '../../../home/presentation/bloc/menu_name_event.dart';
import '../../../home/presentation/bloc/order_bloc/cancel_order_event.dart';
import '../bloc/order_list/order_list_event.dart';
import '../bloc/order_list/order_list_state.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  OrderListState createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  int _rowsPerPage = 10;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  List<Order> orders = [];
  List<Order> sortedOrders = [];
  List<Order> resultOrders = [];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dataTableTheme: DataTableThemeData(
          dataRowColor: MaterialStateColor.resolveWith(
              (states) => AppColors.primaryColor),
        ),
      ),
      child: BlocBuilder<OrderListBloc, OrderListDisplayState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case OrderListInitial:
              return const Center(
                child: CircularProgressIndicator()
              );
            case OrderListSuccessState:
              final successState = state as OrderListSuccessState;
              print(state.orderList!.length);
              orders = successState.orderList!;
              resultOrders = orders;
              break;
            case OrderListSortSuccessState:
              final sortSuccessState = state as OrderListSortSuccessState;
              sortedOrders = sortSuccessState.sortedOrders!;
              resultOrders = sortedOrders;
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
                        bottom:
                        BorderSide(color: AppColors.iconColor, width: .5),
                      ),
                    ),
                    child: const Text(
                      'Orders',
                      style: TextStyle(
                        letterSpacing: .8,
                        color: AppColors.whiteColor,
                        fontFamily: CustomLabels.primaryFont,
                        fontWeight: CustomLabels.mediumFontWeight,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: OrderStatus(orders)),
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
                      columnSpacing: 30,
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (value) {
                        setState(
                              () {
                            _rowsPerPage =
                                value ??
                                    PaginatedDataTable.defaultRowsPerPage;
                          },
                        );
                      },
                      sortAscending: _sortAscending,
                      sortColumnIndex: _sortColumnIndex,
                      columns: [
                        DataColumn2(
                          label: const Text(
                            'Order Number',
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
                                    a.orderNo!
                                        .compareTo(b.orderNo!));
                              } else {
                                resultOrders.sort((a, b) =>
                                    b.orderNo!
                                        .compareTo(a.orderNo!));
                              }
                            });
                          },
                        ),
                        DataColumn2(
                          label: const Text(
                            'Amount',
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
                                    a.summary!.total!.compareTo(
                                        b.summary!.total!));
                              } else {
                                resultOrders.sort((a, b) =>
                                    b.summary!.total!.compareTo(
                                        a.summary!.total!));
                              }
                            });
                          },
                        ),
                        DataColumn2(
                          label: const Text(
                            'Table Number',
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
                                    a.floorTableId!
                                        .compareTo(b.floorTableId!));
                              } else {
                                resultOrders.sort((a, b) =>
                                    b.floorTableId!
                                        .compareTo(a.floorTableId!));
                              }
                            });
                          },
                        ),
                        DataColumn2(
                          label: const Text(
                            'Guest Name',
                            style: TextStyle(
                                color: AppColors.iconColor,
                                fontFamily: CustomLabels.primaryFont),
                          ),
                          onSort: (columnIndex, ascending) {
                            // setState(() {
                            //   _sortColumnIndex = columnIndex;
                            //   _sortAscending = ascending;
                            //   if (ascending) {
                            //     resultOrders.sort((a, b) =>
                            //         // a.customer!.name!.compareTo(
                            //         //     b.customer!.name!));
                            //   } else {
                            //     resultOrders.sort((a, b) =>
                            //         b.customer!.name!.compareTo(
                            //             a.customer!.name!));
                            //   }
                            // });
                          },
                        ),
                        DataColumn2(
                          label: const Text(
                            'Order Status',
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
                                    a.status!
                                        .compareTo(b.status!));
                              } else {
                                resultOrders.sort((a, b) =>
                                    b.status!
                                        .compareTo(a.status!));
                              }
                            });
                          },
                        ),
                        DataColumn2(
                          label: const Text(
                            'Action',
                            style: TextStyle(
                                color: AppColors.iconColor,
                                fontFamily: CustomLabels.primaryFont),
                          ),
                          onSort: (columnIndex, ascending) {
                            // No need to sort the Action column
                          },
                        ),
                        DataColumn2(
                          label: const Text(
                            'Cancel Order',
                            style: TextStyle(
                                color: AppColors.iconColor,
                                fontFamily: CustomLabels.primaryFont),
                          ),
                          onSort: (columnIndex, ascending) {
                            // No need to sort the Action column
                          },
                        ),
                      ],
                      source: OrderDataSource(resultOrders, context),
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
  final List<Order> orders;
  BuildContext context;

  OrderDataSource(this.orders, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= orders.length) return null;
    final order = orders[index];
    return DataRow(cells: [
      DataCell(
        Center(
          child:Text(
          order.orderNo.toString(),
          style: const TextStyle(
              fontFamily: CustomLabels.primaryFont,
              color: AppColors.whiteColor),
        ),)
      ),
      DataCell(
        Text(
          order.summary!.total.toString(),
          style: const TextStyle(
              fontFamily: CustomLabels.primaryFont,
              color: AppColors.secondaryColor),
        ),
      ),
      DataCell(
          Center(
              child: Text(
        order.floorTableId.toString(),
        style: const TextStyle(
            fontFamily: CustomLabels.primaryFont, color: AppColors.whiteColor),
      ))
      ),
      DataCell(Text(
        // order.customer[0].name.toString(),
        order.customer!.isEmpty ? "customer name": order.customer[0]!.name!,
        style: const TextStyle(
            fontFamily: CustomLabels.primaryFont, color: AppColors.whiteColor),
      )),
      DataCell(
        Center(
          child:Text(
          order.status.toString(),
          style: TextStyle(
              fontFamily: CustomLabels.primaryFont,
        color: changeColor(order.status.toString())
               ),),)),
      DataCell(InkWell(
        onTap: () {
          BlocProvider.of<MenuNameBloc>(context)
              .add(MenuNameSelected(context: context, menuName: "View Order"));
          BlocProvider.of<OrderListBloc>(context).add(OrderListShowDetailsEvent(order.id));
        },
        child: const Text(
          'View Order',
          style: TextStyle(
              fontFamily: CustomLabels.primaryFont,
              color: AppColors.secondaryColor),
        ),
      )),
      DataCell(InkWell(
        onTap: () {
          String? numberString = order.orderNo.toString();
          String numberPart =
          numberString!.substring(1);
          int number = int.parse(numberPart);
          BlocProvider.of<CancelOrderBloc>(
              context)
              .add(CancelOrderButtonPressed(
              "", number));
          BlocProvider.of<MenuNameBloc>(context)
              .add(MenuNameSelected(context: context, menuName: "Orders"));
          BlocProvider.of<OrderListBloc>(context).add(OrderListShowEvent());
          },
        child:Visibility(
          visible: order.status.toString() == "Placed" ? true : false,
            child:  const Center( child: Icon(
          Icons.cancel,
          color: Colors.red,
        ),))
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


MaterialColor changeColor(String name){
  switch(name){
    case "Placed":
      return Colors.green;
    case "Cancelled":
      return Colors.red;
    case "Preparing":
      return Colors.yellow;
    case "Ready":
      return Colors.orange;
    case "Completed":
      return Colors.blue;
    default:
      return Colors.red;
  }
}