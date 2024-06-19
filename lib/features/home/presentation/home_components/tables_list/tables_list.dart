import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/c_text_field.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import 'package:pos_application/core/images/image.dart';
import 'package:pos_application/features/home/data/floor_tables.dart';
import 'package:pos_application/features/home/domain/repository/floor_table_repository.dart';
import 'package:pos_application/features/home/domain/repository/menus_repository.dart';
import 'package:pos_application/features/home/domain/repository/set_table_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/floor_table_event.dart';
import 'package:pos_application/features/home/presentation/bloc/floor_table_state.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
import 'package:pos_application/features/home/presentation/home_components/tables_list/table_status.dart';
import 'package:pos_application/features/menu/bloc/add_menu/add_menu_cart_event.dart';
import 'package:pos_application/features/menu/domain/add_menu_to_cart_repository.dart';

import '../../bloc/menu_list_event.dart';
import '../../bloc/set_table/set_table_event.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class MainBodyTable extends StatefulWidget {
  static MainBodyTableState? _currentState;

  static MainBodyTableState? get currentState => _currentState;

  const MainBodyTable({super.key});

  @override
  MainBodyTableState createState() {
    _currentState = MainBodyTableState();
    return _currentState!;
  }

}

class MainBodyTableState extends State<MainBodyTable> {
  List<FloorTable> floorTables = [];

  List<String> distinctFloors = [];
  int activeFloor = 0;

  List<List<FloorTable>> tables = [];
  Set<FloorTable> selectedTables = {};
  int tableCounter = 1;
  int reservedTables = 0;
  int availableTables = 0;
  int servingTables = 0;


  void addTable(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    TextEditingController txtTableName = TextEditingController();
    TextEditingController txtMaxCapacity = TextEditingController();

    showDialog<String>(
        barrierColor: Colors.black.withOpacity(.5),
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              elevation: 0,
              surfaceTintColor: Colors.red,
              backgroundColor: AppColors.whiteColor,
              contentPadding: const EdgeInsets.all(30),
              titleTextStyle: const TextStyle(
                  fontSize: 18,
                  fontFamily: CustomLabels.primaryFont,
                  color: AppColors.darkColor),
              title:  Text(
               optionName!.addaTable,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: CustomLabels.primaryFont,
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                         "${optionName!.tableNumber} : ",
                          style: CustomLabels.body1TextStyle(
                            fontFamily: CustomLabels.primaryFont,
                            color: AppColors.darkColor,
                            fontSize: 16,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: CustomTextField(
                          controller: txtTableName,
                          hintText: "1",
                          textAlign: TextAlign.center,
                          inputType: CustomTextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          "${optionName!.capacity} : ",
                          style: CustomLabels.body1TextStyle(
                            fontFamily: CustomLabels.primaryFont,
                            color: AppColors.darkColor,
                            fontSize: 16,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: CustomTextField(
                          controller: txtMaxCapacity,
                          hintText: "1",
                          textAlign: TextAlign.center,
                          inputType: CustomTextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                CustomButton(
                  text: optionName!.add,
                  activeButtonColor: AppColors.secondaryColor,
                  onPressed: () {
                    BlocProvider.of<FloorTableBloc>(context).add(
                        FloorTableAddButtonPressed(
                            floor: AllTableStatus.floorSelected,
                            floorName: txtTableName.text,
                            minCapacity: 1,
                            maxCapacity: int.parse(txtMaxCapacity.text),
                            extraCapacity: 0));

                    Navigator.pop(context, 'OK');
                  },
                ),
              ],
            ));
  }

  void toggleTableSelection(FloorTable tableNumber) {
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FloorTableStatus, List<FloorTable>>(
        builder: (context, floorWiseTables) {
          floorTables.clear();
          tables.clear();
          AllTableStatus.tableCount = 0;
          // for (int i = 0; i < floorWiseTables.length; i++) {
          //   floorTables.add(floorWiseTables[i]);
          //   if (tables.isEmpty || tables.last.length >= 5) {
          //     tables.add([floorWiseTables[i]]);
          //   } else {
          //     tables.last.add(floorWiseTables[i]);
          //   }
          //   AllTableStatus.tableCount++;
          //   tableCounter++;
          //   availableTables++;
          // }
          return BlocBuilder<FloorTableSortBloc, FloorTableState>(
            builder: (context, state) {
              if(state is FloorTableSortSuccess){
                print("floorTables tbales =${floorTables.length}");
                print("floorwise tbales =${floorWiseTables.length}");
                print("original table =${tables.length}");
                print("sorted tables=${state.floors.length}");
                tables.clear();
                for (int i = 0; i < state.floors.length; i++) {
                  floorTables.add(state.floors[i]);
                  if (tables.isEmpty || tables.last.length >= 5) {
                    tables.add([state.floors[i]]);
                  } else {
                    tables.last.add(state.floors[i]);
                  }
                  AllTableStatus.tableCount++;
                  tableCounter++;
                  availableTables++;
                }
              }else {
                for (int i = 0; i < floorWiseTables.length; i++) {
                  floorTables.add(floorWiseTables[i]);
                  if (tables.isEmpty || tables.last.length >= 5) {
                    tables.add([floorWiseTables[i]]);
                  } else {
                    tables.last.add(floorWiseTables[i]);
                  }
                  AllTableStatus.tableCount++;
                  tableCounter++;
                  availableTables++;
                }
                print("floorTables tbales else =${tables.length}");
              }
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                itemCount: tables.length,
                itemBuilder: (context, rowIndex) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: tables[rowIndex].map((table) {
                      return GestureDetector(
                        onTap: () {
                          if (!table.isSelected) {
                            BlocProvider.of<AddMenuToCartBloc>(context)
                                .add(GetCartSummary(table.id));
                          }
                          BlocProvider.of<SetTableBloc>(context)
                              .add(TableSetPressedEvent(table.id));
                          BlocProvider.of<FloorTableStatus>(context)
                              .selectTable(table.id, table.floor);
                          BlocProvider.of<MenuListBloc>(context).add(
                              MenuListButtonPressed());
                        },
                        child: Container(
                          height: 90,
                          width: 120,
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(table.isSelected
                                  ? AppImage.available
                                  : AppImage.reserved),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  table.name,
                                  style: const TextStyle(
                                      color: AppColors.darkColor,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            },
          );
        });
  }

  void generateCart() async {}
}
