import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/api_methods.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/common_messages.dart';
import 'package:pos_application/core/utils/device_dimension.dart';
import '../../../../menu/bloc/add_menu/add_menu_cart_event.dart';
import '../../../../menu/domain/add_menu_to_cart_repository.dart';
import '../../../../menu/domain/cart_response.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CartItemSelector extends StatefulWidget {
  final CartItem menuItem;
  final int floorId;
  const CartItemSelector({required this.floorId,required this.menuItem, super.key});

  @override
  CartItemSelectorState createState() => CartItemSelectorState();
}

class CartItemSelectorState extends State<CartItemSelector> {



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
                setState(() {
                  widget.menuItem.requiredQuantity = 1;
                  BlocProvider.of<AddMenuToCartBloc>(context).add(AddMenuToCartPressed(widget.menuItem.menu.id, widget.menuItem.requiredQuantity,widget.floorId,ApiMethods.substractMethod));
                });
            }),
            const SizedBox(
              width: 7,
            ),
            Container(
              alignment: Alignment.center,
              child: AnimatedFlipCounter(
                value: widget.menuItem.quantity,
                duration: const Duration(milliseconds: 200),
                textStyle:
                const TextStyle(fontSize: 13, color: AppColors.whiteColor),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            _buildButton(Icons.add, () {
              setState(() {
                widget.menuItem.requiredQuantity++;
                BlocProvider.of<AddMenuToCartBloc>(context).add(AddMenuToCartPressed(widget.menuItem.menu.id, widget.menuItem.requiredQuantity,widget.floorId,ApiMethods.addMethod));
              });

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
        boxShadow:  const [
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
        tooltip: AppLocalizations.of(context)!.toolTipMessage,
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
