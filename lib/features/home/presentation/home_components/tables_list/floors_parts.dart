import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/features/home/domain/repository/floor_table_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/floor_table_event.dart';
import 'package:pos_application/features/home/presentation/bloc/floor_table_state.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/set_selected_floor_table_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/set_selected_floor_table_event.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/set_selected_floor_table_state.dart';
import 'package:pos_application/features/home/presentation/home_components/tables_list/table_status.dart';
import '../../../data/floor_tables.dart';


class FloorScreen extends StatefulWidget {
  const FloorScreen({required this.tabController, super.key});

  final TabController tabController;

  @override
  State<FloorScreen> createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen>
    with SingleTickerProviderStateMixin {
  late List<FloorTable> floorNames = [
    FloorTable(
        id: 2,
        name: "floor 2",
        status: "Available",
        minCapacity: 10,
        maxCapacity: 20,
        floor: "1",
        active: true,
        extraCapacity: 0,
        priority: 0,
        tenantUnitId: 1,
        deletedAt: null,
        createdAt: "2024-04-24T10:16:08.000000Z",
        updatedAt: "2024-04-24T10:16:08.000000Z",
        shareUrl:
            "http://localhost:8000/customers/tables/1/orders?signature=3bd23454f284faa2e39e5fb4ea19e849803b11fbde025f55a1cded9133c391f5")
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FloorTableBloc, FloorTableState>(
      builder: (context, state) {
        if (state is FloorTableStateInitial) {
          BlocProvider.of<FloorTableBloc>(context)
              .add(FloorTableButtonPressed());
        }
        if (state is FloorTableStateSuccess) {
          if (state.floors.isNotEmpty) {
            floorNames = state.floors;
          }
          BlocProvider.of<FloorTableStatus>(context)
              .setFloor_tables(floorNames);
        }
        Set<String> uniqueFloors = Set();
        for (var item in floorNames) {
          if (item.floor.isNotEmpty) {
            uniqueFloors.add(item.floor);
          }
        }
        if (AllTableStatus.floorSelected != "") {
          AllTableStatus.floorSelected = uniqueFloors.first;
          BlocProvider.of<FloorTableStatus>(context)
              .loadSpecificFloorTables(AllTableStatus.floorSelected);
        }
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.secondaryColor, width: .3),
            ),
          ),
          child: BlocBuilder<SetSelectedFloorTableBloc, SetSelectedFloorTableState>(
            builder: (context, state) {
              return TabBar(
                onTap: (index) {
                  AllTableStatus.floorSelected = uniqueFloors.elementAt(index);
                  BlocProvider.of<SetSelectedFloorTableBloc>(context).add(setSelectedFloorPressed(uniqueFloors.elementAt(index)));
                  BlocProvider.of<FloorTableStatus>(context)
                      .loadSpecificFloorTables(AllTableStatus.floorSelected);
                },
                isScrollable: true,
                controller: widget.tabController,
                unselectedLabelColor: AppColors.darkColor,
                indicatorWeight: 3.1,
                indicatorColor: AppColors.buttonColor,
                padding: EdgeInsets.zero,
                dividerColor: AppColors.darkColor,
                dividerHeight: .3,
                enableFeedback: true,
                indicatorSize: TabBarIndicatorSize.tab,
                tabAlignment: TabAlignment.start,
                labelStyle: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: CustomLabels.mediumFontWeight),
                unselectedLabelStyle: const TextStyle(
                    fontFamily: CustomLabels.primaryFont,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    letterSpacing: .5,
                    fontWeight: CustomLabels.mediumFontWeight),
                tabs: uniqueFloors.map((floor) => Tab(text: floor)).toList(),
              );
            },
          ),
        );
      },
    );
  }
}
