import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/common_messages.dart';
import 'package:pos_application/core/utils/device_dimension.dart';
import 'package:pos_application/features/home/data/floor_tables.dart';

class GuestSelector extends StatefulWidget {
  final FloorTable? floorTable;
  const GuestSelector({this.floorTable,super.key});

  @override
  GuestSelectorState createState() => GuestSelectorState();
}

class GuestSelectorState extends State<GuestSelector> {



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceUtils.getDeviceDimension(context).height * 0.033,
      width: DeviceUtils.getDeviceDimension(context).width * 0.053,
      child: FittedBox(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        fit: BoxFit.contain,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButton(Icons.remove, () {
              if (widget.floorTable!.tableUsersCount>widget.floorTable!.minCapacity) {
                setState(() {
                  widget.floorTable!.tableUsersCount--;
                });
              }
            }),
            const SizedBox(
              width: 7,
            ),
            Container(
              alignment: Alignment.center,
              child: AnimatedFlipCounter(
                value: widget.floorTable!.tableUsersCount,
                duration: const Duration(milliseconds: 200),
                textStyle:
                    const TextStyle(fontSize: 13, color: AppColors.whiteColor),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            _buildButton(Icons.add, () {
              if(widget.floorTable!.tableUsersCount<(widget.floorTable!.maxCapacity+widget.floorTable!.extraCapacity)) {
                setState(() {
                  widget.floorTable!.tableUsersCount++;
                });
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: AppColors.secondaryColor,
              blurRadius: 1,
              blurStyle: BlurStyle.outer,
              offset: Offset(.1, .1),
              spreadRadius: 0)
        ],
      ),
      child: IconButton(
        alignment: Alignment.center,
        highlightColor: AppColors.secondaryColor.withOpacity(.4),
        tooltip: CustomMessages.toolTipMessage,
        icon: Icon(
          icon,
          color: AppColors.secondaryColor,
          size: 17,
          applyTextScaling: false,
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
