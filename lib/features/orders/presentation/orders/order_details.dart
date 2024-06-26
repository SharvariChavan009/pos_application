import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/api_methods.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/u_validations_all.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import 'package:pos_application/features/auth/widget/custom_snackbar.dart';
import 'package:pos_application/features/home/presentation/home_components/side_order/side_order.dart';
import 'package:pos_application/features/orders/domain/repository/order_list_repository.dart';
import 'package:pos_application/features/orders/presentation/orders/order_list.dart';

import '../../../Profile/domain/repository/profile_repository.dart';
import '../../../Profile/presentation/bloc/profile_event.dart';
import '../../../Profile/presentation/bloc/profile_state.dart';
import '../../../home/presentation/bloc/menu_name_bloc.dart';
import '../../../home/presentation/bloc/menu_name_event.dart';
import '../../data/order_details.dart';
import '../bloc/order_list/order_list_event.dart';
import '../bloc/order_list/order_list_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();

}
OrderDetailsData? viewOrder;
class _OrderDetailsState extends State<OrderDetails> {
  String? currency;
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
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      decoration: const BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: BlocBuilder<OrderListBloc, OrderListDisplayState>(
        builder: (context, state) {
          if (state is OrderListShowDetailsSuccessState) {
            viewOrder = state.orderDetails;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.iconColor,
                            width: .5),
                      ),
                    ),
                    child:   Row(
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<MenuNameBloc>(context)
                                .add(MenuNameSelected(context: context, menuName: "Orders"));
                            BlocProvider.of<OrderListBloc>(context).add(OrderListShowEvent());
                          },
                            child: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.iconColor,
                          size: 22,
                        )
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                         Text(
                          optionName!.orders,
                          style: TextStyle(
                            letterSpacing: .8,
                            color: AppColors.darkColor,
                            fontFamily: CustomLabels.primaryFont,
                            fontWeight: CustomLabels.mediumFontWeight,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: AppColors.iconColor,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                         Text(
                           optionName!.orderDetails,
                          style: const TextStyle(
                            letterSpacing: .8,
                            color: AppColors.buttonColor,
                            fontFamily: CustomLabels.primaryFont,
                            fontWeight: CustomLabels.mediumFontWeight,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: AppColors.lightGreyColor,
                            padding: const EdgeInsets.only(top: 50),
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'assets/image/Table3.png',
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: AppColors.iconColor, width: .5),
                                    ),
                                  ),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // 'Table No:',
                                        "${optionName!.tableNo}:",
                                        style: const TextStyle(
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                      Text(
                                        // 'Order#:',
                                        '${optionName!.order}#:',
                                        style: const TextStyle(
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                      Text(
                                        // 'Guests:',
                                        '${optionName!.guests}:',
                                        style: const TextStyle(
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                      Text(
                                        // 'Manager:',
                                        '${optionName!.manager}:',
                                        style: const TextStyle(
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                      Text(
                                        // 'Payment Status:',
                                        '${optionName!.paymentStatus}:',
                                        style: const TextStyle(
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: AppColors.iconColor, width: .5),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        height: 0,
                                      ),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.lightGreyColor,
                                          border: Border.all(
                                              color: AppColors.secondaryColor
                                                  .withOpacity(.8),
                                              width: .4),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          "${viewOrder!.floorTableId}",
                                          textAlign: TextAlign.center,
                                          style: CustomLabels.body1TextStyle(
                                            fontFamily: CustomLabels.primaryFont,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                       Text(
                                        '${viewOrder!.orderNo}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                                CustomLabels.mediumFontWeight,
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                       Text(
                                        '${viewOrder!.diners}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                                CustomLabels.mediumFontWeight,
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                     BlocBuilder<ProfileBloc, ProfileState>(
                                      builder: (context, state) {
                                        if (state is ProfileStateInitial){
                                          BlocProvider.of<ProfileBloc>(context).add(ProfileButtonPressed());
                                        }
                                        if(state is ProfileStateSuccess) {
                                           return Text(
                                                state.user.user.name,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        CustomLabels.mediumFontWeight,
                                                    color: AppColors.darkColor,
                                                    fontFamily: CustomLabels.primaryFont),
                                              );
                                        }else{
                                          return const Text(
                                                'Leya Deanna',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        CustomLabels.mediumFontWeight,
                                                    color: AppColors.darkColor,
                                                    fontFamily: CustomLabels.primaryFont),
                                              );
                                        }
                                      },
                                    ),
                                        Text(
                                         viewOrder!.status! == optionName.completed ? optionName.paid : optionName!.unpaid,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                                CustomLabels.mediumFontWeight,
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                      const SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.iconColor, width: .5),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: AppColors.iconColor, width: .5),
                                    ),
                                  ),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        height: 0,
                                      ),
                                      Text(
                                        // 'Amount:',
                                        '${optionName!.amount}:',
                                        style: const TextStyle(
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                      Text(
                                        // 'Name:',
                                        '${optionName!.name}:',
                                        style: TextStyle(
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                      Text(
                                        // 'Date & Time:',
                                        '${optionName!.dateTime}:',
                                        style: TextStyle(
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                      Text(
                                        // 'Status:',
                                        '${optionName.status}:',
                                        style: TextStyle(
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                      SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: AppColors.iconColor, width: .5),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                       const SizedBox(
                                        height: 0,
                                      ),
                                      Text(
                                        "${currency} ${viewOrder!.summary!.total}",
                                        textAlign: TextAlign.center,
                                        style: CustomLabels.body1TextStyle(
                                            fontFamily: CustomLabels.primaryFont,
                                            letterSpacing: 0,
                                            color: AppColors.secondaryColor),
                                      ),
                                       Text(
                                        viewOrder!.customer!.name!.isEmpty ? "customer":'${viewOrder!.customer!.name}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                                CustomLabels.mediumFontWeight,
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                       Text(
                                        ApiMethods.convertDateFormat("${viewOrder!.createdAt}"),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                                CustomLabels.mediumFontWeight,
                                            color: AppColors.darkColor,
                                            fontFamily: CustomLabels.primaryFont),
                                      ),
                                       Text(
                                         "${viewOrder!.status}",
                                          style:  TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                                  CustomLabels.mediumFontWeight,
                                              color: viewOrder!.status == optionName!.cancelled ? CupertinoColors.destructiveRed:CupertinoColors.systemGreen,
                                              fontFamily:
                                                  CustomLabels.primaryFont)),
                                      const SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 5,
                  child: GridView.builder(
                    itemCount: viewOrder!.orderItems!.length,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    cacheExtent: 10,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 130,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 65,
                        width: 100,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CachedNetworkImage(
                                imageUrl: viewOrder!.orderItems![index].orderable!.media![0].originalUrl,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        ),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                    LinearProgressIndicator(
                                      color: Colors.transparent,
                                      backgroundColor:
                                      AppColors.secondaryColor.withOpacity(.1),
                                    ),
                                errorWidget: (context, url, error) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10, bottom: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: AutoSizeText(
                                        "${viewOrder!.orderItems![index]
                                            .orderable!.name}",
                                        textAlign: TextAlign.start,
                                        minFontSize: 10,
                                        maxFontSize: 16,
                                        presetFontSizes: [15],
                                        style: const TextStyle(
                                            color: AppColors.whiteColor),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 5),
                                      alignment: Alignment.centerLeft,
                                      child:  AutoSizeText(
                                        ValidationsAll.stripHtmlTags(viewOrder!.orderItems![index].orderable!.description),
                                        textAlign: TextAlign.start,
                                        minFontSize: 10,
                                        maxFontSize: 16,
                                        presetFontSizes: [13],
                                        style: const TextStyle(
                                            color: AppColors.iconColor),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(
                                              "${currency} ${viewOrder!.orderItems![index].orderable!.price}",
                                              textAlign: TextAlign.center,
                                              minFontSize: 10,
                                              maxFontSize: 16,
                                              presetFontSizes: const [12.5],
                                              style: CustomLabels
                                                  .bodyTextStyle(
                                                color: AppColors.secondaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                CustomLabels.secondaryFont,
                                                letterSpacing: 0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            AutoSizeText(
                                              "${optionName!.quantity} : ${viewOrder!.orderItems![index].quantity}",
                                              textAlign: TextAlign.center,
                                              minFontSize: 10,
                                              maxFontSize: 16,
                                              presetFontSizes: const [12.5],
                                              style: CustomLabels
                                                  .bodyTextStyle(
                                                color: AppColors.secondaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                CustomLabels.secondaryFont,
                                                letterSpacing: 0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            AutoSizeText(
                                              "${optionName!.total} : ${currency}${(viewOrder!.orderItems![index].quantity)! * (viewOrder!.orderItems![index].orderable!.price!)}",
                                              textAlign: TextAlign.center,
                                              minFontSize: 10,
                                              maxFontSize: 16,
                                              presetFontSizes: const [12.5],
                                              style: CustomLabels
                                                  .bodyTextStyle(
                                                color: AppColors.secondaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                CustomLabels.secondaryFont,
                                                letterSpacing: 0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );

          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}
