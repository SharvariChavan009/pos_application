import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/images/image.dart';

class MenuListSetting extends StatefulWidget {
  const MenuListSetting({super.key});

  @override
  MenuListSettingState createState() => MenuListSettingState();
}

class MenuListSettingState extends State<MenuListSetting> {
  int _rowsPerPage = 10;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  bool _selectAll = false;
  Image imageUrl = Image.asset('assets/image/pizza.webp');

  List<Map<String, dynamic>> menus = [
    {
      'orderNumber': '001',
      'amount': '\$10',
      'guest': '1',
      'tableNumber': '1',
      'guestName': 'Leya',
      'orderStatus': 'Pending',
    },
    {
      'orderNumber': '002',
      'amount': '\$50',
      'guest': '2',
      'tableNumber': '2',
      'guestName': 'Deanna',
      'orderStatus': 'Serving',
    },
    {
      'orderNumber': '003',
      'amount': '\$150',
      'guest': '3',
      'tableNumber': '3',
      'guestName': 'Emam',
      'orderStatus': 'Completed',
    },
    {
      'orderNumber': '004',
      'amount': '\$20',
      'guest': '4',
      'tableNumber': '4',
      'guestName': 'John',
      'orderStatus': 'Pending',
    },
    {
      'orderNumber': '005',
      'amount': '\$30',
      'guest': '5',
      'tableNumber': '5',
      'guestName': 'Alice',
      'orderStatus': 'Serving',
    },
    {
      'orderNumber': '006',
      'amount': '\$40',
      'guest': '6',
      'tableNumber': '6',
      'guestName': 'Bob',
      'orderStatus': 'Completed',
    },
    {
      'orderNumber': '007',
      'amount': '\$60',
      'guest': '7',
      'tableNumber': '7',
      'guestName': 'Sarah',
      'orderStatus': 'Pending',
    },
    {
      'orderNumber': '008',
      'amount': '\$70',
      'guest': '8',
      'tableNumber': '8',
      'guestName': 'Michael',
      'orderStatus': 'Serving',
    },
    {
      'orderNumber': '009',
      'amount': '\$80',
      'guest': '9',
      'tableNumber': '9',
      'guestName': 'Sophia',
      'orderStatus': 'Completed',
    },
    {
      'orderNumber': '010',
      'amount': '\$90',
      'guest': '10',
      'tableNumber': '10',
      'guestName': 'David',
      'orderStatus': 'Pending',
    },
    {
      'orderNumber': '011',
      'amount': '\$100',
      'guest': '11',
      'tableNumber': '11',
      'guestName': 'Emily',
      'orderStatus': 'Serving',
    },
    {
      'orderNumber': '012',
      'amount': '\$110',
      'guest': '12',
      'tableNumber': '12',
      'guestName': 'William',
      'orderStatus': 'Completed',
    },
    {
      'orderNumber': '013',
      'amount': '\$120',
      'guest': '13',
      'tableNumber': '13',
      'guestName': 'Olivia',
      'orderStatus': 'Pending',
    },
    {
      'orderNumber': '014',
      'amount': '\$130',
      'guest': '14',
      'tableNumber': '14',
      'guestName': 'James',
      'orderStatus': 'Serving',
    },
    {
      'orderNumber': '015',
      'amount': '\$140',
      'guest': '15',
      'tableNumber': '15',
      'guestName': 'Ava',
      'orderStatus': 'Completed',
    },
    {
      'orderNumber': '016',
      'amount': '\$160',
      'guest': '16',
      'tableNumber': '16',
      'guestName': 'Alexander',
      'orderStatus': 'Pending',
    },
    {
      'orderNumber': '017',
      'amount': '\$170',
      'guest': '17',
      'tableNumber': '17',
      'guestName': 'Mia',
      'orderStatus': 'Serving',
    },
    {
      'orderNumber': '018',
      'amount': '\$180',
      'guest': '18',
      'tableNumber': '18',
      'guestName': 'Benjamin',
      'orderStatus': 'Completed',
    },
    {
      'orderNumber': '019',
      'amount': '\$190',
      'guest': '19',
      'tableNumber': '19',
      'guestName': 'Charlotte',
      'orderStatus': 'Pending',
    },
    {
      'orderNumber': '020',
      'amount': '\$200',
      'guest': '20',
      'tableNumber': '20',
      'guestName': 'Ethan',
      'orderStatus': 'Serving',
    },
    {
      'orderNumber': '001',
      'amount': '\$10',
      'guest': '1',
      'tableNumber': '1',
      'guestName': 'Leya',
      'orderStatus': 'Pending',
    },
    {
      'orderNumber': '002',
      'amount': '\$50',
      'guest': '2',
      'tableNumber': '2',
      'guestName': 'Deanna',
      'orderStatus': 'Serving',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dataTableTheme: DataTableThemeData(
          dataRowColor: MaterialStateColor.resolveWith(
              (states) => AppColors.primaryColor),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Expanded(flex: 1, child: OrderStatus(menus)),//uncomment when its required.
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: PaginatedDataTable(
                  horizontalMargin: 10,
                  showEmptyRows: false,
                  showCheckboxColumn: false,
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
                    DataColumn(
                      label: Checkbox(
                        activeColor: AppColors.secondaryColor,
                        side: BorderSide(
                            color: AppColors.whiteColor.withOpacity(.8)),
                        checkColor: AppColors.whiteColor,
                        tristate: true,
                        value: _selectAll,
                        onChanged: (value) {
                          setState(() {
                            _selectAll = value ?? false;
                            // Update the selection status of each row
                            for (var menu in menus) {
                              menu['selected'] = _selectAll;
                            }
                          });
                        },
                      ),
                    ),
                    const DataColumn(
                      label: Text('Images'),
                    ),
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
                            menus.sort((a, b) =>
                                a['orderNumber'].compareTo(b['orderNumber']));
                          } else {
                            menus.sort((a, b) =>
                                b['orderNumber'].compareTo(a['orderNumber']));
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
                            menus.sort(
                                (a, b) => a['amount'].compareTo(b['amount']));
                          } else {
                            menus.sort(
                                (a, b) => b['amount'].compareTo(a['amount']));
                          }
                        });
                      },
                    ),
                    DataColumn2(
                      label: const Text(
                        'Guest',
                        style: TextStyle(
                            color: AppColors.iconColor,
                            fontFamily: CustomLabels.primaryFont),
                      ),
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          _sortColumnIndex = columnIndex;
                          _sortAscending = ascending;
                          if (ascending) {
                            menus.sort(
                                (a, b) => a['guest'].compareTo(b['guest']));
                          } else {
                            menus.sort(
                                (a, b) => b['guest'].compareTo(a['guest']));
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
                            menus.sort((a, b) =>
                                a['tableNumber'].compareTo(b['tableNumber']));
                          } else {
                            menus.sort((a, b) =>
                                b['tableNumber'].compareTo(a['tableNumber']));
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
                        setState(() {
                          _sortColumnIndex = columnIndex;
                          _sortAscending = ascending;
                          if (ascending) {
                            menus.sort((a, b) =>
                                a['guestName'].compareTo(b['guestName']));
                          } else {
                            menus.sort((a, b) =>
                                b['guestName'].compareTo(a['guestName']));
                          }
                        });
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
                            menus.sort((a, b) =>
                                a['orderStatus'].compareTo(b['orderStatus']));
                          } else {
                            menus.sort((a, b) =>
                                b['orderStatus'].compareTo(a['orderStatus']));
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
                  ],
                  source: OrderDataSource(menus),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDataSource extends DataTableSource {
  final List<Map<String, dynamic>> orders;

  OrderDataSource(this.orders);

  @override
  DataRow? getRow(int index) {
    if (index >= orders.length) return null;
    final order = orders[index];
    return DataRow.byIndex(
        index: index,
        selected: order['selected'] ?? false,
        onSelectChanged: (selected) {
          if (selected != null) {
            orders[index]['selected'] = selected;
          }
        },
        cells: [
          DataCell(
            Checkbox(
              value: order['selected'] ?? false,
              onChanged: (value) {
                if (value != null) {
                  orders[index]['selected'] = value;
                }
              },
            ),
          ),
          DataCell(
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Image.asset(
                AppImage.pizza,
                width: 50,
                height: 50,
              ),
            ),
          ),
          DataCell(
            Text(
              order['orderNumber'].toString(),
              style: const TextStyle(
                  fontFamily: CustomLabels.primaryFont,
                  color: AppColors.whiteColor),
            ),
          ),
          DataCell(
            Text(
              order['amount'].toString(),
              style: const TextStyle(
                  fontFamily: CustomLabels.primaryFont,
                  color: AppColors.secondaryColor),
            ),
          ),
          DataCell(Text(
            order['guest'].toString(),
            style: const TextStyle(
                fontFamily: CustomLabels.primaryFont,
                color: AppColors.whiteColor),
          )),
          DataCell(Text(
            order['tableNumber'].toString(),
            style: const TextStyle(
                fontFamily: CustomLabels.primaryFont,
                color: AppColors.whiteColor),
          )),
          DataCell(Text(
            order['guestName'].toString(),
            style: const TextStyle(
                fontFamily: CustomLabels.primaryFont,
                color: AppColors.whiteColor),
          )),
          DataCell(
            Text(
              order['orderStatus'].toString(),
              style: const TextStyle(
                  fontFamily: CustomLabels.primaryFont, color: Colors.yellow),
            ),
          ),
          const DataCell(InkWell(
            child: Text(
              'View Order',
              style: TextStyle(
                  fontFamily: CustomLabels.primaryFont,
                  color: AppColors.secondaryColor),
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
