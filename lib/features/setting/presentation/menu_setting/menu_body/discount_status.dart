import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import 'package:pos_application/features/home/data/floor_tables.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
import 'package:pos_application/features/home/presentation/home_components/tables_list/tables_list.dart';

class DiscountStatus extends StatefulWidget {
  static String floorSelected = "";
  static int tableCount = 0;
  const DiscountStatus({super.key});

  @override
  State<DiscountStatus> createState() => _DiscountStatusState();
}

class _DiscountStatusState extends State<DiscountStatus> {
  int _selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FloorTableStatus, List<FloorTable>>(
        builder: (context, floorWiseTables) {
      int allTables = floorWiseTables.length;
      int servingTables = floorWiseTables
          .where((element) => element.status == "Serving")
          .length;
      int rervedTables = floorWiseTables
          .where((element) => element.status == "reserved")
          .length;
      int availableTables = floorWiseTables
          .where((element) => element.status == "Available")
          .length;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildButton(0, "All Discount", allTables),
              _buildButton(1, "Active", servingTables),
              _buildButton(2, "Inactive", rervedTables),
              _buildButton(3, "Expired", availableTables),
            ],
          ),
          const Spacer(),
          Container(
            width: 140,
            margin: const EdgeInsets.only(right: 30),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(.1),
              border: Border.all(
                color: AppColors.secondaryColor.withOpacity(.8),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomButton(
              onPressed: () {
                MainBodyTable.currentState?.addTable();
                //              widget.tableKey.currentState?.addTable();
              },
              text: 'Create Discount',
              textStyle: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontFamily: CustomLabels.primaryFont),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildButton(int index, String title, int count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedButtonIndex = index;
        });
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
              // border: Border.all(
              //   color: AppColors.secondaryColor.withOpacity(.8),
              //   width: .4,
              // ),
              borderRadius: BorderRadius.circular(8),
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
