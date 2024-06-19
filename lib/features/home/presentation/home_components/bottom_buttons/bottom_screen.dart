import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import 'package:pos_application/features/home/data/floor_tables.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_event.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
import 'package:pos_application/features/home/presentation/home_components/side_order/guest_numbers.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

enum TableStatus { available, reserved, servicing }

class FloorTables {
  TableStatus tableStatus = TableStatus.available;
  String floor = "";
  int numGuests = 2;
  int maxCapacity = 2;
  int id = 0;
}

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  Box? box;
  List<FloorTables> floorTables = [];

  void addTable() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return Expanded(
      flex: 1,
      child: BlocBuilder<FloorTableStatus, List<FloorTable>>(
          builder: (context, floorWiseTables) {
            if(floorWiseTables.where((element) => element.isSelected==true).isEmpty) {
              return const SizedBox();
            }
          FloorTable currentTable = floorWiseTables.firstWhere((
                element) => element.isSelected == true);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Text(
                    '${optionName!.table}:',
                    style: CustomLabels.body1TextStyle(
                      fontFamily: CustomLabels.primaryFont,
                      color: AppColors.iconColor,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      border: Border.all(
                          color: AppColors.secondaryColor.withOpacity(.8),
                          width: .4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      currentTable.name,
                      textAlign: TextAlign.center,
                      style: CustomLabels.body1TextStyle(
                        fontFamily: CustomLabels.primaryFont,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${optionName!.guest}:',
                    style: CustomLabels.body1TextStyle(
                      fontFamily: CustomLabels.primaryFont,
                      color: AppColors.iconColor,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   FittedBox(
                    fit: BoxFit.fill,
                    child: GuestSelector(floorTable: currentTable),
                  ),
                ],
              ),
              SizedBox(
                width: 150,
                child: CustomButton(
                  onPressed: () {},
                  activeButtonColor: AppColors.errorColor.withOpacity(.3),
                  backgroundColor: AppColors.darkColor,
                  text: optionName!.reserveTable,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 150,
                child: CustomButton(
                  onPressed: () {
                    BlocProvider.of<MenuNameBloc>(context).add(MenuNameSelected(context: context, menuName: "Menu"));
                    },
                  activeButtonColor: AppColors.secondaryColor,
                  backgroundColor: AppColors.darkColor,
                  text: optionName!.continueM,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          );
        }
      ),
    );
  }
}
