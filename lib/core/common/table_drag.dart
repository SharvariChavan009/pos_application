// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../features/home/data/floor_tables.dart';
// import '../../features/home/domain/repository/floor_table_repository.dart';
// import '../../features/home/domain/repository/menus_repository.dart';
// import '../../features/home/domain/repository/set_table_repository.dart';
// import '../../features/home/presentation/bloc/floor_table_state.dart';
// import '../../features/home/presentation/bloc/menu_list_event.dart';
// import '../../features/home/presentation/bloc/set_table/set_table_event.dart';
// import '../../features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
// import '../../features/home/presentation/home_components/tables_list/table_status.dart';
// import '../../features/home/presentation/home_components/tables_list/tables_list.dart';
// import '../../features/menu/bloc/add_menu/add_menu_cart_event.dart';
// import '../../features/menu/domain/add_menu_to_cart_repository.dart';
// import '../images/image.dart';
// import 'colors.dart';
//
// class TableDragPage extends StatefulWidget {
//   final double containerWidth;
//   final double containerHeight;
//   final bool isNewTable;
//
//   const TableDragPage({
//     super.key,
//     required this.containerWidth,
//     required this.containerHeight,
//     required this.isNewTable,
//   });
//
//   @override
//   State<TableDragPage> createState() => _TableDragState();
// }
//
// class _TableDragState extends State<TableDragPage> {
//   Offset _offset = const Offset(0, 0);
//   List<FloorTable> floorTables = [];
//
//   List<String> distinctFloors = [];
//   int activeFloor = 0;
//
//   List<List<FloorTable>> tables = [];
//   Set<FloorTable> selectedTables = {};
//   int tableCounter = 1;
//   int reservedTables = 0;
//   int availableTables = 0;
//   int servingTables = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FloorTableStatus, List<FloorTable>>(
//       builder: (context, floorWiseTables) {
//         floorTables.clear();
//         tables.clear();
//         AllTableStatus.tableCount = 0;
//
//         return BlocBuilder<FloorTableSortBloc, FloorTableState>(
//           builder: (context, state) {
//             if (state is FloorTableSortSuccess) {
//               print("floorTables tbales =${floorTables.length}");
//               print("floorwise tbales =${floorWiseTables.length}");
//               print("original table =${tables.length}");
//               print("sorted tables=${state.floors.length}");
//               tables.clear();
//               for (int i = 0; i < state.floors.length; i++) {
//                 floorTables.add(state.floors[i]);
//                 if (tables.isEmpty || tables.last.length >= 5) {
//                   tables.add([state.floors[i]]);
//                 } else {
//                   tables.last.add(state.floors[i]);
//                 }
//                 AllTableStatus.tableCount++;
//                 tableCounter++;
//                 availableTables++;
//               }
//             } else {
//               for (int i = 0; i < floorWiseTables.length; i++) {
//                 floorTables.add(floorWiseTables[i]);
//                 if (tables.isEmpty || tables.last.length >= 5) {
//                   tables.add([floorWiseTables[i]]);
//                 } else {
//                   tables.last.add(floorWiseTables[i]);
//                 }
//                 AllTableStatus.tableCount++;
//                 tableCounter++;
//                 availableTables++;
//               }
//               print("floorTables tbales else drag =${tables.length}");
//             }
//
//             return Center(
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   // Flatten the nested list of tables
//                   List<FloorTable> flatTables =
//                       tables.expand((tableList) => tableList).toList();
//
//                   return widget.isNewTable
//                       ? Stack(
//                           children: [
//                             Positioned(
//                               left: _offset.dx,
//                               top: _offset.dy,
//                               child: LongPressDraggable(
//                                 feedback: Image.asset(
//                                   AppImage.available,
//                                   height: 50,
//                                   color: Colors.orangeAccent,
//                                   colorBlendMode: BlendMode.colorBurn,
//                                 ),
//                                 child: Image.asset(
//                                   AppImage.available,
//                                   height: 50,
//                                 ),
//                                 onDragEnd: (details) {
//                                   setState(() {
//                                     // Get the local position within the container
//                                     RenderBox renderBox =
//                                         context.findRenderObject() as RenderBox;
//                                     Offset localPosition =
//                                         renderBox.globalToLocal(details.offset);
//
//                                     // Ensure the new offset is within the bounds of the container
//                                     double newX = localPosition.dx;
//                                     double newY = localPosition.dy;
//
//                                     // Adjustments to ensure the draggable widget remains within bounds
//                                     if (newX < 0) newX = 0;
//                                     if (newY < 0) newY = 0;
//                                     if (newX > widget.containerWidth - 50)
//                                       newX = widget.containerWidth -
//                                           50; // Assuming image width is 50
//                                     if (newY > widget.containerHeight - 50)
//                                       newY = widget.containerHeight -
//                                           50; // Assuming image height is 50
//
//                                     _offset = Offset(newX, newY);
//                                     MainBodyTable.currentState
//                                         ?.addTable(context, newX, newY);
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         )
//                       : Stack(
//                           children: flatTables.map((table) {
//                             return Positioned(
//                               left: table.xCord == null
//                                   ? 0.0
//                                   : double.parse(table.xCord!),
//                               top: table.yCord == null
//                                   ? 0.0
//                                   : double.parse(table.yCord!),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   if (!table.isSelected) {
//                                     BlocProvider.of<AddMenuToCartBloc>(context)
//                                         .add(GetCartSummary(table.id));
//                                   }
//                                   BlocProvider.of<SetTableBloc>(context)
//                                       .add(TableSetPressedEvent(table.id));
//                                   BlocProvider.of<FloorTableStatus>(context)
//                                       .selectTable(table.id, table.floor);
//                                   BlocProvider.of<MenuListBloc>(context)
//                                       .add(MenuListButtonPressed());
//                                 },
//                                 child: Container(
//                                   height: 90,
//                                   width: 120,
//                                   margin: const EdgeInsets.all(20),
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(table.isSelected
//                                           ? AppImage.available
//                                           : AppImage.reserved),
//                                       fit: BoxFit.fitWidth,
//                                     ),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           table.name,
//                                           style: const TextStyle(
//                                               color: AppColors.darkColor,
//                                               fontSize: 20),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         );
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/data/floor_tables.dart';
import '../../features/home/domain/repository/floor_table_repository.dart';
import '../../features/home/domain/repository/menus_repository.dart';
import '../../features/home/domain/repository/set_table_repository.dart';
import '../../features/home/presentation/bloc/floor_table_state.dart';
import '../../features/home/presentation/bloc/menu_list_event.dart';
import '../../features/home/presentation/bloc/set_table/set_table_event.dart';
import '../../features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
import '../../features/home/presentation/home_components/tables_list/table_status.dart';
import '../../features/home/presentation/home_components/tables_list/tables_list.dart';
import '../../features/menu/bloc/add_menu/add_menu_cart_event.dart';
import '../../features/menu/domain/add_menu_to_cart_repository.dart';
import '../images/image.dart';
import 'colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableDragPage extends StatefulWidget {
  final double containerWidth;
  final double containerHeight;
  final bool isNewTable;

  const TableDragPage({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
    required this.isNewTable,
  });

  @override
  State<TableDragPage> createState() => _TableDragPageState();
}

class _TableDragPageState extends State<TableDragPage> {
  Offset _offset = const Offset(0, 0);
  List<FloorTable> floorTables = [];
  List<List<FloorTable>> tables = [];
  bool isAdded = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FloorTableStatus, List<FloorTable>>(
      builder: (context, floorWiseTables) {
        floorTables.clear();
        tables.clear();

        // Flatten the nested list of tables
        List<FloorTable> flatTables = floorWiseTables;
        print("table drag = ${floorWiseTables.last.name} AllTableStatus =${AllTableStatus.tableCount} , floorselcted =${AllTableStatus.floorSelected}");

        // Organize tables into rows of 5
        for (int i = 0; i < flatTables.length; i++) {
          if (tables.isEmpty || tables.last.length >= 5) {
            tables.add([flatTables[i]]);
          } else {
            tables.last.add(flatTables[i]);
          }
        }
        List<Widget> stackChildren = flatTables.map((table) {
          return Positioned(
            left: table.xCord == null ? 0.0 : double.parse(table.xCord!),
            top: table.yCord == null ? 0.0 : double.parse(table.yCord!),
            child: GestureDetector(
              onTap: () {
                if (!table.isSelected) {
                  BlocProvider.of<AddMenuToCartBloc>(context)
                      .add(GetCartSummary(table.id));
                }
                BlocProvider.of<SetTableBloc>(context)
                    .add(TableSetPressedEvent(table.id));
                BlocProvider.of<FloorTableStatus>(context)
                    .selectTable(table.id, table.floor);
                BlocProvider.of<MenuListBloc>(context).add(MenuListButtonPressed());
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
                            color: AppColors.darkColor, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList();

        if (widget.isNewTable) {
          stackChildren.add(
            Positioned(
              left: _offset.dx,
              top: _offset.dy,
              child: LongPressDraggable(
                feedback: Image.asset(
                  AppImage.available,
                  height: 50,
                  color: Colors.orangeAccent,
                  colorBlendMode: BlendMode.colorBurn,
                ),
                child: Visibility(
                  visible: isAdded,
                    child:Image.asset(
                  AppImage.available,
                  height: 50,
                )),
                onDragEnd: (details) {
                  setState(() {
                    // Get the local position within the container
                    RenderBox renderBox = context.findRenderObject() as RenderBox;
                    Offset localPosition = renderBox.globalToLocal(details.offset);

                    // Ensure the new offset is within the bounds of the container
                    double newX = localPosition.dx;
                    double newY = localPosition.dy;

                    // Adjustments to ensure the draggable widget remains within bounds
                    if (newX < 0) newX = 0;
                    if (newY < 0) newY = 0;
                    if (newX > widget.containerWidth - 50)
                      newX = widget.containerWidth - 50; // Assuming image width is 50
                    if (newY > widget.containerHeight - 50)
                      newY = widget.containerHeight - 50; // Assuming image height is 50

                    _offset = Offset(newX, newY);
                    MainBodyTable.currentState?.addTable(context, newX, newY);
                    isAdded = false;
                  });
                },
              ),
            ),
          );
        }

        return Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: stackChildren,
              );
            },
          ),
        );
      },
    );
  }
}
