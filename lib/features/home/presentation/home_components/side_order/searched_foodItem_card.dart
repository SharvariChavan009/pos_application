import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos_application/features/home/presentation/home_components/side_order/side_order.dart';
import '../../../../../core/common/api_methods.dart';
import '../../../../../core/common/colors.dart';
import '../../../../../core/common/label.dart';
import '../../../data/menu_list.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';



class SearchedFoodItemCart extends StatefulWidget {
  List<MenuItem> tempFoodItems = [];
   SearchedFoodItemCart(this.tempFoodItems, {super.key});

  @override
  State<SearchedFoodItemCart> createState() => _SearchedFoodItemCartState();
}

class _SearchedFoodItemCartState extends State<SearchedFoodItemCart> {
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
    return Container(
      color: AppColors.whiteColor,
        child:ListView.builder(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: const EdgeInsets.only(top: 10),
      addAutomaticKeepAlives: true,
      physics: const BouncingScrollPhysics(),
      itemCount: tempFoodItems.length,
      itemBuilder: (context, index) {
        return Container(
          height: 85,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.darkColor,
              width: .5,
            ),
          ),
          child: Card(
            color: AppColors.darkColor,
            elevation: 0.4,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
                    imageUrl: tempFoodItems[index].images[0],
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
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              tempFoodItems[index].name,
                              textAlign: TextAlign.start,
                              minFontSize: 10,
                              maxFontSize: 16,
                              presetFontSizes: const [15],
                              style:
                                  const TextStyle(color: AppColors.whiteColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ), //name
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: AutoSizeText(
                                    "${currency}${(double.parse(tempFoodItems[index].price.toString()) * foodItems[index].minQty).toStringAsFixed(2)}",
                                    textAlign: TextAlign.center,
                                    minFontSize: 10,
                                    maxFontSize: 16,
                                    presetFontSizes: const [15],
                                    style: CustomLabels.bodyTextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: CustomLabels.secondaryFont,
                                      letterSpacing: 0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: AutoSizeText(
                                      "${currency}${(double.parse(tempFoodItems[index].price.toString()) * foodItems[index].minQty).toStringAsFixed(2)}",
                                      textAlign: TextAlign.center,
                                      minFontSize: 10,
                                      maxFontSize: 16,
                                      presetFontSizes: const [15],
                                      style: CustomLabels.bodyTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: CustomLabels.secondaryFont,
                                        letterSpacing: 0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
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
                ), //price
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.darkColor,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.secondaryColor, width: 1),
                    ),
                    child:  Text(
                      AppLocalizations.of(context)!.add,
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 13,
                          fontFamily: CustomLabels.primaryFont,
                          fontWeight: CustomLabels.mediumFontWeight,
                          letterSpacing: .5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
