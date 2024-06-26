import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/common_messages.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import 'package:pos_application/features/home/data/floor_tables.dart';
import 'package:pos_application/features/home/domain/repository/floor_table_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/floor_table_state.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/set_selected_floor_table_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/set_selected_floor_table_state.dart';
import 'package:pos_application/features/home/presentation/home_components/tables_list/tables_list.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../auth/widget/custom_snackbar.dart';
import '../../bloc/floor_table_event.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class AllTableStatus extends StatefulWidget {
  static String floorSelected = "";
  static int tableCount = 0;
  const AllTableStatus({super.key});

  @override
  State<AllTableStatus> createState() => _AllTableStatusState();
}

class _AllTableStatusState extends State<AllTableStatus> {
  int _selectedButtonIndex = 0;
  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return BlocBuilder<FloorTableStatus, List<FloorTable>>(
        builder: (context, floorWiseTables) {
      int allTables = floorWiseTables.length;
      int servingTables = floorWiseTables
          .where((element) => element.status == "Serving" || element.status == "خدمة")
          .length;
      int rervedTables = floorWiseTables
          .where((element) => element.status == "Reserved" || element.status == "محجوز")
          .length;
      int availableTables = floorWiseTables
          .where((element) => element.status == "Available" || element.status == "متاح")
          .length;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildButton(0, optionName!.allTables, allTables,floorWiseTables),
              _buildButton(1, optionName!.serving, servingTables,floorWiseTables),
              _buildButton(2, optionName!.reserved, rervedTables,floorWiseTables),
              _buildButton(3, optionName!.available, availableTables,floorWiseTables),
            ],
          ),
          const Spacer(),
         Visibility(
           visible: false,
             child: Container(
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
                       title: optionName!.addTable,
                       message: optionName!.tableSelectionMessage,
                     );
                   } else {
                     // MainBodyTable.currentState?.addTable(context);
                   }
                 },
                 text: optionName!.addTable,
                 activeButtonColor: AppColors.secondaryColor,
                 backgroundColor: AppColors.darkColor,
                 textStyle: const TextStyle(
                     color: AppColors.whiteColor,
                     fontFamily: CustomLabels.primaryFont),
               );
             },
           ),
         ))
        ],
      );
    });
  }

  Widget _buildButton(int index, String title, int count,List<FloorTable> tableList) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedButtonIndex = index;
        });
        BlocProvider.of<FloorTableSortBloc>(context).add(FloorTableSortEvent(tableList,title));
      },
      child: Row(
        children: [
          Container(
            height: 35,
            width: 120, // Adjust width as needed
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: _selectedButtonIndex == index
                  ? AppColors.secondaryColor.withOpacity(.1)
                  : AppColors.lightGreyColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _selectedButtonIndex == index
                    ? AppColors.lightGreyColor // Color when selected
                    : AppColors.lightGreyColor, // Color when not selected
                width: 0.5, // Adjust border width as needed
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: CustomLabels.primaryFont,
                    color: _selectedButtonIndex == index
                        ? AppColors.secondaryColor
                        : AppColors.iconColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _selectedButtonIndex == index
                        ? AppColors.secondaryColor
                        : AppColors.lightGreyColor,
                    border: Border.all(
                        color: AppColors.secondaryColor.withOpacity(.5),
                        width: .2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "$count",
                    textAlign: TextAlign.center,
                    style: CustomLabels.body1TextStyle(
                      fontFamily: CustomLabels.primaryFont,
                      fontSize: 14,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
