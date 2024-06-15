import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/features/orders/domain/repository/order_list_repository.dart';
import 'package:pos_application/features/orders/presentation/bloc/order_list/order_list_event.dart';
import '../../data/order_data.dart';
import '../bloc/order_list/order_list_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class OrderStatus extends StatefulWidget {
  static String floorSelected = "";
  List<Order> orderList = [];
  OrderStatus(this.orderList, {super.key});

  @override
  State<OrderStatus> createState() => OrderStatusState();
}

class OrderStatusState extends State<OrderStatus> {
  int _selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildButton(0, optionName!.all, widget.orderList),
            _buildButton(1, optionName!.placed, widget.orderList),
            _buildButton(2, optionName!.preparing, widget.orderList),
            _buildButton(3, optionName!.ready, widget.orderList),
            _buildButton(4, optionName!.cancelled, widget.orderList),
            _buildButton(5, optionName!.completed, widget.orderList),
          ],
        ),
        const Spacer(),
        Visibility(
          visible: false,
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list_sharp,
              color: AppColors.whiteColor,
              size: 24.0,
            ),
            label: const Text(
              'Filter',
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontFamily: CustomLabels.primaryFont,
                  letterSpacing: .5,
                  fontSize: 18),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }

  Widget _buildButton(int index, String title, List<Order> orders) {
    return BlocBuilder<OrderListBloc, OrderListDisplayState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedButtonIndex = index;
              BlocProvider.of<OrderListBloc>(context).add(OrderListSortEvent(title,orders));
            });
          },
          child: Row(
            children: [
              Container(
                height: 35,
                width: 120,
                // Adjust width as needed
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: _selectedButtonIndex == index
                      ? AppColors.secondaryColor.withOpacity(.1)
                      : AppColors.lightGreyColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
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
              ),
            ],
          ),
        );
      },
    );
  }
}
