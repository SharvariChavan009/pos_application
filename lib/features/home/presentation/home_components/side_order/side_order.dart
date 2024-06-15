import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/api_methods.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/w_custom_button.dart';
import 'package:pos_application/features/home/data/floor_tables.dart';
import 'package:pos_application/features/home/data/menu_list.dart';
import 'package:pos_application/features/home/domain/repository/cancel_order_repository.dart';
import 'package:pos_application/features/home/domain/repository/menus_repository.dart';
import 'package:pos_application/features/home/domain/repository/place_order_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_list_state.dart';
import 'package:pos_application/features/home/presentation/bloc/order_bloc/cancel_order_state.dart';
import 'package:pos_application/features/home/presentation/bloc/order_bloc/place_order_state.dart';
import 'package:pos_application/features/home/presentation/bloc/search_bar/search_value_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/search_bar/search_value_state.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
import 'package:pos_application/features/home/presentation/home_components/parts/food_item.dart';
import 'package:pos_application/features/home/presentation/home_components/side_order/add_item.dart';
import 'package:pos_application/features/home/presentation/home_components/side_order/guest_numbers.dart';
import 'package:pos_application/features/home/presentation/home_components/side_order/searched_foodItem_card.dart';
import 'package:pos_application/features/home/presentation/home_components/side_order/table_number.dart';
import 'package:pos_application/features/menu/bloc/add_menu/add_menu_cart_state.dart';
import 'package:pos_application/features/menu/domain/add_menu_to_cart_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/images/image.dart';
import '../../../../menu/bloc/add_menu/add_menu_cart_event.dart';
import '../../bloc/order_bloc/cancel_order_event.dart';
import '../../bloc/order_bloc/place_order_event.dart';
import 'cart_item_selector.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class RotationTransitionWidget extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const RotationTransitionWidget({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  _RotationTransitionWidgetState createState() =>
      _RotationTransitionWidgetState();
}

class _RotationTransitionWidgetState extends State<RotationTransitionWidget> {
  late final Animation<double> _animation = CurvedAnimation(
    parent: widget.controller,
    curve: Curves.elasticOut,
  );

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: widget.child,
    );
  }
}

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

List<MenuItem> foodItems = [];
List<MenuItem> tempFoodItems = [];

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double calculateSubtotal(List<FoodItem> foodItemsStatic) {
    double subtotal = 0;
    for (var item in foodItemsStatic) {
      subtotal += double.parse(item.offerPrice!) * item.quantity;
    }
    return subtotal;
  }

  double calculateTaxed(double subtotal) {
    return subtotal * 0.18;
  }

  double calculateDiscount(double subtotal) {
    return subtotal * 0.10;
  }

  double calculateTotal(double subtotal, double taxed, double discount) {
    return subtotal + taxed - discount;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FloorTableStatus, List<FloorTable>>(
        builder: (context, floorWiseTables) {
      if (floorWiseTables
          .where((element) => element.isSelected == true)
          .isEmpty) {
        return _getSideOrder();
      }
      FloorTable currentTable =
          floorWiseTables.firstWhere((element) => element.isSelected == true);
      return _getSideOrder(currentTable: currentTable);
    });
  }

  Widget _getSideOrder({FloorTable? currentTable}) {
    var optionName = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.darkColor.withOpacity(.9),
        border: Border(
            left: BorderSide(
                color: const Color(0xFF98d6f1).withOpacity(.3), width: .5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: BlocBuilder<FloorTableStatus, List<FloorTable>>(
                builder: (context, floorWiseTables) {
              return Skeletonizer(
                  enabled: (floorWiseTables.isEmpty ||
                          floorWiseTables
                              .where((element) => element.isSelected == true)
                              .isEmpty)
                      ? true
                      : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              child: AutoSizeText(
                                'Table#',
                                textAlign: TextAlign.center,
                                minFontSize: 10,
                                maxFontSize: 16,
                                maxLines: 1,
                                presetFontSizes: const [15],
                                style: CustomLabels.bodyTextStyle(
                                  fontFamily: CustomLabels.secondaryFont,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: NumberSelector(
                                maxTables: floorWiseTables.length,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 30,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                child: AutoSizeText(
                                  'Guest',
                                  textAlign: TextAlign.center,
                                  minFontSize: 10,
                                  maxFontSize: 16,
                                  maxLines: 1,
                                  presetFontSizes: const [15],
                                  style: CustomLabels.bodyTextStyle(
                                    fontFamily: CustomLabels.secondaryFont,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                              if (currentTable != null)
                                FittedBox(
                                  fit: BoxFit.fill,
                                  child: GuestSelector(
                                    floorTable: floorWiseTables.firstWhere(
                                        (element) =>
                                            element.isSelected == true),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Expanded(
                        flex: 2,
                        child: BlocBuilder<AddMenuToCartBloc, AddMenuCartState>(
                            builder: (context, cartState) {
                          int itemCount = 0;
                          int quantity = 0;
                          if (cartState is AddMenuCartSuccessState) {
                            itemCount = cartState
                                .cartResponse.data!.cart.cartItems.length;
                            quantity = 0;
                            for (int i = 0; i < itemCount; i++) {
                              quantity += cartState.cartResponse.data!.cart
                                  .cartItems[i].quantity;
                            }
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: AutoSizeText(
                                  'Item',
                                  textAlign: TextAlign.center,
                                  minFontSize: 10,
                                  maxFontSize: 16,
                                  maxLines: 1,
                                  presetFontSizes: const [15],
                                  style: CustomLabels.bodyTextStyle(
                                    fontFamily: CustomLabels.secondaryFont,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              FittedBox(
                                child: AutoSizeText(
                                  '$itemCount',
                                  textAlign: TextAlign.center,
                                  minFontSize: 10,
                                  maxFontSize: 16,
                                  maxLines: 1,
                                  presetFontSizes: const [15],
                                  style: CustomLabels.bodyTextStyle(
                                    color: AppColors.secondaryColor,
                                    fontFamily: CustomLabels.secondaryFont,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              FittedBox(
                                child: AutoSizeText(
                                  'Quantity',
                                  textAlign: TextAlign.center,
                                  minFontSize: 10,
                                  maxFontSize: 16,
                                  maxLines: 1,
                                  presetFontSizes: const [15],
                                  style: CustomLabels.bodyTextStyle(
                                    fontFamily: CustomLabels.secondaryFont,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              FittedBox(
                                child: Text(
                                  '$quantity',
                                  style: CustomLabels.bodyTextStyle(
                                    fontSize: 15,
                                    fontFamily: CustomLabels.secondaryFont,
                                    color: AppColors.secondaryColor,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ));
            }),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            height: 1.1,
            color: AppColors.iconColor.withOpacity(.2),
          ),
          const FittedBox(child: AddItem(isCart: true)),
          Expanded(
            flex: 8,
            child: BlocBuilder<MenuListBloc, MenuListState>(
              builder: (context, menuState) {
                if (currentTable == null) {
                  return const SizedBox();
                }
                if (menuState is MenuListStateSuccess) {
                  foodItems = menuState.menus;
                  tempFoodItems = foodItems;
                } else {
                  tempFoodItems = foodItems;
                }

                return BlocBuilder<SearchValueBloc, SearchValueState>(
                  builder: (context, searchState) {
                    if (searchState is SearchValueSuccess) {
                      tempFoodItems = searchState.searchedFoodItem;
                    }
                    print("Search fooditems=${tempFoodItems.length}");

                    return Stack(
                      children: [
                        BlocBuilder<AddMenuToCartBloc, AddMenuCartState>(
                            builder: (context, cartState) {
                          if (cartState is AddMenuCartSuccessState) {
                            if (cartState
                                .cartResponse.data!.cart.cartItems.isNotEmpty) {
                              return ListView.builder(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                padding: const EdgeInsets.only(top: 15),
                                addAutomaticKeepAlives: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: cartState
                                    .cartResponse.data?.cart.cartItems.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 65,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppColors.iconColor,
                                        width: .5,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: CachedNetworkImage(
                                            imageUrl: cartState
                                                .cartResponse
                                                .data!
                                                .cart
                                                .cartItems[index]
                                                .menu
                                                .mediaImages!
                                                .first
                                                .originalUrl!,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
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
                                              backgroundColor: AppColors
                                                  .secondaryColor
                                                  .withOpacity(.1),
                                            ),
                                            errorWidget: (context, url, error) {
                                              return const Icon(Icons.error);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: AutoSizeText(
                                                      cartState
                                                          .cartResponse
                                                          .data!
                                                          .cart
                                                          .cartItems[index]
                                                          .menu
                                                          .name,
                                                      textAlign:
                                                          TextAlign.start,
                                                      minFontSize: 10,
                                                      maxFontSize: 16,
                                                      presetFontSizes: const [
                                                        15
                                                      ],
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .whiteColor),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Spacer(),
                                                        FittedBox(
                                                          fit: BoxFit.fitWidth,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            child:
                                                                CartItemSelector(
                                                              menuItem: cartState
                                                                  .cartResponse
                                                                  .data!
                                                                  .cart
                                                                  .cartItems[index],
                                                              floorId: cartState
                                                                  .cartResponse
                                                                  .data!
                                                                  .cart
                                                                  .floorTable!
                                                                  .id,
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          child: FittedBox(
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            child: AutoSizeText(
                                                              "\$${(double.parse(cartState.cartResponse.data!.cart.cartItems[index].menu.price) * 1).toStringAsFixed(2)}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              minFontSize: 10,
                                                              maxFontSize: 16,
                                                              presetFontSizes: const [
                                                                15
                                                              ],
                                                              style: CustomLabels
                                                                  .bodyTextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    CustomLabels
                                                                        .secondaryFont,
                                                                letterSpacing:
                                                                    0,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: AppColors.errorColor
                                                  .withOpacity(.75),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                BlocProvider.of<
                                                            AddMenuToCartBloc>(
                                                        context)
                                                    .add(AddMenuToCartPressed(
                                                        cartState
                                                            .cartResponse
                                                            .data!
                                                            .cart
                                                            .cartItems[index]
                                                            .menuId,
                                                        cartState
                                                            .cartResponse
                                                            .data!
                                                            .cart
                                                            .cartItems[index]
                                                            .quantity,
                                                        cartState
                                                            .cartResponse
                                                            .data!
                                                            .cart
                                                            .floorTableId,
                                                        ApiMethods
                                                            .substractMethod));
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return BlocBuilder<PlaceOrderBloc,
                                  PlaceOrderState>(
                                builder: (context, state) {
                                  String? imgName;
                                  if (state is PlaceOrderSuccess) {
                                    imgName = AppImage.resetPasswordImage;
                                  }
                                  return BlocBuilder<CancelOrderBloc,
                                      CancelOrderState>(
                                    builder: (context, state) {
                                      if (state is CancelOrderSuccess) {
                                        imgName = AppImage.cancelOrder;
                                      }
                                      return Center(
                                        child: RotationTransition(
                                            turns: _animation,
                                            child: Image.asset(
                                              imgName != null
                                                  ? imgName!
                                                  : AppImage.emptyCart,
                                              width: 200,
                                              height: 200,
                                            )),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          } else {}
                          return Center(
                              child: Image.asset(AppImage.emptyCart,
                                  width: 200, // Adjust width as needed
                                  height: 200));
                        }),
                        if (searchState is SearchValueSuccess &&
                            searchState.searchedFoodItem.length !=
                                foodItems.length)
                          Positioned(
                            top: 0,
                            left: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              height: 300, // Adjust the height as needed
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white,
                                  width: .5,
                                ),
                              ),
                              child:  SearchedFoodItemCart(tempFoodItems),
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Container(
            height: .5,
            color: AppColors.iconColor,
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<AddMenuToCartBloc, AddMenuCartState>(
                builder: (context, cartState) {
              if (cartState is AddMenuCartSuccessState) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              optionName!.subTotal,
                              style: CustomLabels.bodyTextStyle(
                                fontSize: 12,
                                fontFamily: CustomLabels.secondaryFont,
                                letterSpacing: 0,
                              ),
                            ),
                            Text(
                              "${cartState.cartResponse.data!.currency.sign} ${cartState.cartResponse.data!.summary.subTotal}",
                              style: CustomLabels.bodyTextStyle(
                                fontSize: 12,
                                fontFamily: CustomLabels.secondaryFont,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${cartState.cartResponse.data!.summary.tax.text}:",
                              style: CustomLabels.bodyTextStyle(
                                fontSize: 12,
                                fontFamily: CustomLabels.secondaryFont,
                                letterSpacing: 0,
                              ),
                            ),
                            Text(
                              "${cartState.cartResponse.data!.summary.tax.value}",
                              style: CustomLabels.bodyTextStyle(
                                fontSize: 12,
                                fontFamily: CustomLabels.secondaryFont,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${cartState.cartResponse.data!.summary.discount.text}:",
                              style: CustomLabels.bodyTextStyle(
                                fontSize: 12,
                                fontFamily: CustomLabels.secondaryFont,
                                letterSpacing: 0,
                              ),
                            ),
                            Text(
                              "${cartState.cartResponse.data!.currency.sign} ${cartState.cartResponse.data!.summary.discount.value}",
                              style: CustomLabels.bodyTextStyle(
                                fontSize: 12,
                                fontFamily: CustomLabels.secondaryFont,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              optionName!.total,
                              style: CustomLabels.bodyTextStyle(
                                fontSize: 21,
                                fontFamily: CustomLabels.secondaryFont,
                                letterSpacing: 0,
                              ),
                            ),
                            Text(
                              "${cartState.cartResponse.data!.currency.sign} ${cartState.cartResponse.data!.summary.total}",
                              style: CustomLabels.bodyTextStyle(
                                fontSize: 21,
                                fontFamily: CustomLabels.secondaryFont,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: BlocListener<CancelOrderBloc,
                                  CancelOrderState>(
                                listener: (context, state) {
                                },
                                child: BlocBuilder<PlaceOrderBloc,
                                    PlaceOrderState>(
                                  builder: (context, state) {
                                    int? orderNumber;
                                    if (state is PlaceOrderSuccess) {
                                      String? numberString = state.orderNo;
                                      String numberPart =
                                          numberString!.substring(1);
                                      int number = int.parse(numberPart);
                                      orderNumber = number;
                                    }
                                    return CustomButton(
                                      onPressed: () {
                                        // print("orderNumber=$orderNumber");
                                        BlocProvider.of<CancelOrderBloc>(
                                                context)
                                            .add(CancelOrderButtonPressed(
                                                "", orderNumber!));
                                      },
                                      text: optionName.cancelOrder,
                                      activeButtonColor:
                                          AppColors.errorColor.withOpacity(.2),
                                      backgroundColor: Colors.red,
                                      height: 40,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 150,
                              child:
                                  BlocListener<PlaceOrderBloc, PlaceOrderState>(
                                listener: (context, state) {
                                  if (state is PlaceOrderSuccess) {
                                    BlocProvider.of<AddMenuToCartBloc>(context)
                                        .add(GetCartSummary(cartState
                                            .cartResponse
                                            .data!
                                            .cart
                                            .floorTableId));
                                  }
                                },
                                        child: BlocBuilder<PlaceOrderBloc,
                                              PlaceOrderState>(
                                             builder: (context, state) {
                                              return CustomButton(
                                      onPressed: () {
                                        int? floorTable = cartState.cartResponse
                                            .data!.cart.floorTableId;
                                        BlocProvider.of<PlaceOrderBloc>(context)
                                            .add(CompleteOrderButtonPressed(
                                                floorTable));
                                      },
                                      activeButtonColor:
                                          AppColors.secondaryColor,
                                      backgroundColor: AppColors.darkColor,
                                      text: optionName.placeOrder,
                                      height: 40,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            optionName!.subTotal,
                            style: CustomLabels.bodyTextStyle(
                              fontSize: 12,
                              fontFamily: CustomLabels.secondaryFont,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            "0",
                            style: CustomLabels.bodyTextStyle(
                              fontSize: 12,
                              fontFamily: CustomLabels.secondaryFont,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            optionName!.taxed,
                            style: CustomLabels.bodyTextStyle(
                              fontSize: 12,
                              fontFamily: CustomLabels.secondaryFont,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            "0",
                            style: CustomLabels.bodyTextStyle(
                              fontSize: 12,
                              fontFamily: CustomLabels.secondaryFont,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            optionName!.discount,
                            style: CustomLabels.bodyTextStyle(
                              fontSize: 12,
                              fontFamily: CustomLabels.secondaryFont,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            "0",
                            style: CustomLabels.bodyTextStyle(
                              fontSize: 12,
                              fontFamily: CustomLabels.secondaryFont,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            optionName!.total,
                            style: CustomLabels.bodyTextStyle(
                              fontSize: 21,
                              fontFamily: CustomLabels.secondaryFont,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            "0",
                            style: CustomLabels.bodyTextStyle(
                              fontSize: 21,
                              fontFamily: CustomLabels.secondaryFont,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150,
                            child: CustomButton(
                              onPressed: () {},
                              text: optionName!.cancelOrder,
                              activeButtonColor:
                                  AppColors.errorColor.withOpacity(.2),
                              backgroundColor: Colors.red,
                              height: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: 150,
                            child: CustomButton(
                              onPressed: () {},
                              activeButtonColor: AppColors.secondaryColor,
                              backgroundColor: AppColors.darkColor,
                              text: optionName!.placeOrder,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
