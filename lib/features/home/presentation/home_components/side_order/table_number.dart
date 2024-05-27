import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/features/home/domain/repository/set_table_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/set_table/set_table_state.dart';

class NumberSelector extends StatefulWidget {
  final int maxTables;

  const NumberSelector({required this.maxTables, super.key});

  @override
  _NumberSelectorState createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  int _selectedNumber = 1;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = _selectedNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetTableBloc, SetTableState>(
      builder: (context, state) {
        String selectedTableName;
        if(state is SetTableSuccessState){
          selectedTableName = state.tableName!;
        }
        else{
          selectedTableName = "Table Name";
        }
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: SizedBox(
            width: 80,
            height: 30,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(2),
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                      selectedTableName,
                        maxLines: 1,
                        style: const TextStyle(
                                fontSize: 14, color: AppColors.secondaryColor),
                      // child: TextField(
                      //   "Hello",
                      //   textAlignVertical: TextAlignVertical.center,
                      //   autofocus: false,
                      //   maxLines: 1,
                      //   showCursor: true,
                      //   controller: _controller,
                      //   style: const TextStyle(
                      //       fontSize: 14, color: AppColors.secondaryColor),
                      //   keyboardType: TextInputType.number,
                      //   textAlign: TextAlign.center,
                      //   // onChanged: (value) {
                      //   //   setState(() {
                      //   //     _selectedNumber = int.tryParse(value) ?? 1;
                      //   //   });
                      //   // },
                      //   decoration: const InputDecoration(
                      //     isDense: true,
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 5), // Adjust this value
                      //     border: InputBorder.none,
                      //   ),
                      // ),
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 4,
                //   child: Container(
                //     decoration: const BoxDecoration(
                //       color: AppColors.primaryColor,
                //       borderRadius: BorderRadius.only(
                //         topRight: Radius.circular(10),
                //         bottomRight: Radius.circular(10),
                //       ),
                //     ),
                //     child: Center(
                //       child: PopupMenuButton<int>(
                //         position: PopupMenuPosition.under,
                //         color: AppColors.darkColor,
                //         surfaceTintColor: AppColors.secondaryColor,
                //         padding: const EdgeInsets.only(bottom: .5),
                //         icon: const Icon(Icons.keyboard_arrow_down_sharp,
                //             color: AppColors.iconColor),
                //         itemBuilder: (BuildContext context) {
                //           return List.generate(widget.maxTables, (index) => index + 1)
                //               .map((number) => PopupMenuItem<int>(
                //                     value: number,
                //                     child: Text(
                //                       number.toString(),
                //                       style: const TextStyle(
                //                           color: AppColors.whiteColor),
                //                     ),
                //                   ))
                //               .toList();
                //         },
                //         onSelected: (int newValue) {
                //           setState(() {
                //             _selectedNumber = newValue;
                //             _controller.text = newValue.toString();
                //           });
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                ),],
            ),
          ),
        );
      },
    );
  }
}
