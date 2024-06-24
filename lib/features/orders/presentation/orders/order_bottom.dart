import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import 'package:pos_application/features/orders/presentation/bloc/order_list/order_list_event.dart';
import 'package:pos_application/features/orders/presentation/bloc/order_list/order_list_state.dart';
import 'package:pos_application/features/orders/presentation/widget/custom_radio_button.dart';
import '../../../../core/common/api_methods.dart';
import '../../domain/repository/order_list_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

enum TableStatus { available, reserved, servicing }

class FloorTables {
  TableStatus tableStatus = TableStatus.available;
  String floor = "";
  int numGuests = 2;
  int maxCapacity = 2;
  int id = 0;
}

class OrderBottom extends StatefulWidget {
  const OrderBottom({super.key});

  @override
  State<OrderBottom> createState() => OrderBottomState();
}

class OrderBottomState extends State<OrderBottom> {
  Box? box;
  List<FloorTables> floorTables = [];
  String? currency;

  void addTable() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCurrency();
  }

  void fetchCurrency() async {
    currency = await ApiMethods.getCurrency();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return BlocBuilder<OrderListBloc, OrderListDisplayState>(
      builder: (context, state) {
        int? quantity  = 0;
        int totalQuantity = 0;
        if(state is OrderListShowDetailsSuccessState) {
          quantity = state.orderDetails!.orderItems![0].quantity;
          for(int i = 0; i < state.orderDetails!.orderItems!.length;i++){
            if(state.orderDetails!.orderItems![i].quantity! > 0){
              quantity = state.orderDetails!.orderItems![i].quantity;
              totalQuantity = totalQuantity + quantity!;
            }
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 7,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 30),
                        buildRichText('${optionName!.item}:', ' ${state.orderDetails!.orderItems!.length}'),
                        const SizedBox(width: 20),
                        buildRichText('${optionName!.quantity}:', " $totalQuantity"),
                        const SizedBox(width: 20),
                        buildRichText('${optionName!.subTotal}:', ' $currency${state.orderDetails!.summary!.subTotal}'),
                        const SizedBox(width: 20),
                        buildRichText('${optionName.taxed}:', ' $currency${state.orderDetails!.summary!.tax?.value}'),
                        const SizedBox(width: 20),
                        buildRichText('${optionName!.discount}:', ' $currency${state.orderDetails!.summary!.discount!.value}'),                        const SizedBox(width: 20),
                        buildRichText('${optionName!.billAmount}:', ' $currency${state.orderDetails!.summary!.total}'),
                        const SizedBox(width: 0),
                      ],
                    ),
                  )),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 150,
                  child: Visibility (
                    visible: state.orderDetails!.status == "Ready" || state.orderDetails!.status == "مستعد" ? true : false,
                      child:CustomButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SelectionDialog();
                        },
                      );
                      },
                    activeButtonColor: AppColors.buttonColor,
                    text: optionName!.completeOrder ,
                    height: 40,
                  )),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 150,
                  child: Visibility(
                    visible: state.orderDetails!.status == "Completed" || state.orderDetails!.status == "مكتمل" ? true : false,
                    child:CustomButton(
                    onPressed: () {},
                    activeButtonColor: AppColors.buttonColor,
                    text: optionName!.refund,
                    height: 40,
                  ),
                )),
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          );
        }else{
          return Container();
        }
      },
    );
  }
}

Widget buildRichText(String title, String value) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: '$title ',
          style: CustomLabels.body1TextStyle(
            fontFamily: CustomLabels.primaryFont,
            color: AppColors.iconColor,
            letterSpacing: 0,
          ),
        ),
        TextSpan(
          text: value,
          style: CustomLabels.body1TextStyle(
            color: AppColors.buttonColor,
            fontFamily: CustomLabels.primaryFont,
            letterSpacing: 0,
          ),
        ),
      ],
    ),
  );
}


class SelectionDialog extends StatefulWidget {
  @override
  _SelectionDialogState createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  PaymentType? _selectedOption = PaymentType.cash;
  String? selectedPaymentType = "";
  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return BlocBuilder<OrderListBloc, OrderListDisplayState>(
      builder: (context, state) {
        int? orderID = 0 ;
        double? total = 0.0;
      if(state is OrderListShowDetailsSuccessState) {
        orderID = state.orderDetails!.id;
        total = state.orderDetails!.summary!.total;
      }
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: CustomRadioButton(
        onChanged: (PaymentType? value) {
          setState(() {
            _selectedOption = value;
          });
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child:  Text(optionName!.cancel),
        ),
        TextButton(
          onPressed: () {
            print('Selected option: $_selectedOption');
            Navigator.pop(context, 'OK');
            switch(_selectedOption){
              case PaymentType.cash:
                selectedPaymentType = optionName!.cash;
                break;
              case PaymentType.online:
                selectedPaymentType = optionName!.online;
             default:
               selectedPaymentType = optionName!.cash;
               break;

            }
            BlocProvider.of<OrderListBloc>(context).add(OrderPaymentEvent(orderID,total,selectedPaymentType));
            BlocProvider.of<OrderListBloc>(context).add(OrderListShowDetailsEvent(orderID));
            },
          child:  Text(optionName!.oK),
        ),
      ],
    );
  },
);
  }
}