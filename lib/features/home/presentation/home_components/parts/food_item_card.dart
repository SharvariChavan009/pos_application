import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/core/common/api_methods.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/common_messages.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/common/u_validations_all.dart';
import 'package:pos_application/core/images/image.dart';
import 'package:pos_application/features/home/data/floor_tables.dart';
import 'package:pos_application/features/home/data/menu_list.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
import 'package:pos_application/features/home/presentation/home_components/side_order/item_numbers.dart';
import 'package:pos_application/features/menu/domain/add_menu_to_cart_repository.dart';

import '../../../../auth/widget/custom_snackbar.dart';
import '../../../../menu/bloc/add_menu/add_menu_cart_event.dart';
import '../../../../../core/common/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class FoodItemCard extends StatefulWidget {
  final MenuItem foodItem;

  const FoodItemCard({super.key, required this.foodItem});

  @override
  FoodItemCardState createState() => FoodItemCardState();
}

class FoodItemCardState extends State<FoodItemCard> {
  bool hColor = false;
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
    return Card(
      elevation: 4.0,
      borderOnForeground: false,
      semanticContainer: true,
      color: Colors.black.withOpacity(.8),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 140,
                  child: CachedNetworkImage(
                    imageUrl: widget.foodItem.images[0],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => LinearProgressIndicator(
                      color: Colors.transparent,
                      backgroundColor: AppColors.secondaryColor.withOpacity(.1),
                    ),
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
              Container(
                height: 25,
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                width: double.infinity,
                child: Text(
                  widget.foodItem.name,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontFamily: CustomLabels.primaryFont,
                    fontWeight: CustomLabels.mediumFontWeight,
                    letterSpacing: .5,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                height: 35,
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                width: double.infinity,
                //color: Colors.red,
                child: Text(
                  ValidationsAll.stripHtmlTags(widget.foodItem.description),
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: const TextStyle(
                    color: AppColors.iconColor,
                    fontFamily: CustomLabels.primaryFont,
                    fontWeight: CustomLabels.mediumFontWeight,
                    letterSpacing: .5,
                    fontSize: 11.0,
                  ),
                ),
              ),
              Container(
                height: 30,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "$currency${widget.foodItem.price}",
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontFamily: CustomLabels.primaryFont,
                              fontWeight: CustomLabels.mediumFontWeight,
                              letterSpacing: .5,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "$currency${widget.foodItem.appliedPrice}",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.iconColor,
                              fontFamily: CustomLabels.primaryFont,
                              fontWeight: CustomLabels.mediumFontWeight,
                              letterSpacing: .5,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 80,
                            height: 30,
                          ),
                          BlocBuilder<FloorTableStatus, List<FloorTable>>(
                            builder: (context, floorWiseTables) {
                              int floorId = 0;
                              if (floorWiseTables.where((element) => element.isSelected == true).isNotEmpty){
                               floorId=floorWiseTables.firstWhere((element) => element.isSelected==true).id;}

                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.primaryColor,
                                ),
                                width: 80,
                                height: 30,
                                child: widget.foodItem.requiredQuantity > 0
                                    ? FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Container(
                                            color: Colors.black.withOpacity(.9),
                                            child: ItemSelector(
                                              menuItem: widget.foodItem, floorId: floorId,
                                            )),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.darkColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.secondaryColor,
                                              width: 1),
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              if(floorId == 0){
                                                OverlayManager.showSnackbar(
                                                  context,
                                                  type: ContentType.failure,
                                                  title: "Add item to cart",
                                                  message: CustomMessages.addTableErrorMessage,
                                                );

                                              }else {
                                                setState(() {
                                                  widget.foodItem
                                                      .requiredQuantity++;
                                                });
                                                int floorId = floorWiseTables
                                                    .firstWhere((element) =>
                                                element.isSelected ==
                                                    true)
                                                    .id;

                                                BlocProvider.of<
                                                    AddMenuToCartBloc>(
                                                    context)
                                                    .add(AddMenuToCartPressed(
                                                    widget.foodItem.id,
                                                    widget.foodItem.minQty,
                                                    floorId, "add"));
                                              }
                                            },
                                            child: const Text(
                                              "Add",
                                              style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                  fontSize: 13,
                                                  fontFamily:
                                                      CustomLabels.primaryFont,
                                                  fontWeight: CustomLabels
                                                      .mediumFontWeight,
                                                  letterSpacing: .5),
                                            ),
                                          ),

                                      ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Image.asset(
              AllIcons.veg,
              height: 20,
              width: 20,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                setState(() {
                  hColor = !hColor;
                });
              },
              child: hColor
                  ? SvgPicture.asset(
                      AllIcons.hrt,
                      height: 20,
                      width: 20,
                    )
                  : const Icon(
                      Icons.favorite_outline_sharp,
                      color: AppColors.whiteColor,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
