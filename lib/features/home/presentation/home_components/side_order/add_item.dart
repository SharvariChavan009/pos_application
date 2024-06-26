import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/controller/change_language_bloc.dart';
import 'package:pos_application/controller/change_language_state.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/icon.dart';
import 'package:pos_application/core/images/image.dart';
import 'package:pos_application/features/home/presentation/bloc/search_bar/search_value_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/search_bar/search_value_event.dart';
import 'package:pos_application/features/home/presentation/bloc/search_bar/search_value_state.dart';
import '../../../data/menu_list.dart';
import '../../../domain/repository/menus_repository.dart';
import '../../bloc/common_search_bar/common_search_bar_bloc.dart';
import '../../bloc/common_search_bar/common_search_bar_event.dart';
import '../../bloc/common_search_bar/common_search_bar_state.dart';
import '../../bloc/menu_list_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

Future<Locale> fetchLanguageNameFromHive() async {
  var box = await Hive.openBox('LanguageData');
  String? languageCode = box.get('language');
  return Locale(languageCode!);
}

final List<String> imgList = [
  ' with ItemCode',
  ' with ItemName',
];
final List<Widget> imageSliders = imgList
    .map((item) => Text(
          item,
          style: const TextStyle(fontSize: 14, color: AppColors.iconColor),
        ))
    .toList();

final List<String> imgListArabic = [
  ' مع رمز العنصر',
  ' مع اسم العنصر',
];
final List<Widget> imageSlidersArabic = imgListArabic
    .map((item) => Text(
          item,
          style: const TextStyle(fontSize: 14, color: AppColors.iconColor),
        ))
    .toList();

List<MenuItem> menuItems = [];
List<MenuItem> menuCartSearchItems = [];
TextEditingController searchValue = TextEditingController();
TextEditingController CommonSearchValue = TextEditingController();

class AddItem extends StatelessWidget {
  final bool? isCart;
  const AddItem({super.key, required this.isCart});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.iconColor.withOpacity(.15),
          ),
          color: AppColors.darkColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: BlocBuilder<MenuListBloc, MenuListState>(
          builder: (context, state) {
            if (state is MenuListStateSuccess) {
              menuItems = state.menus;
              menuCartSearchItems = state.menus;
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  height: 17,
                  child: CustomIcon(
                    iconPath: AllIcons.search,
                    size: 10,
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 17,
                  child: isCart!
                      ? BlocBuilder<SearchValueBloc, SearchValueState>(
                          builder: (context, state) {
                            return TextField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(top: 5, bottom: 15),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Hide underline color
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Hide underline color
                                  ),
                                  hintText:
                                      AppLocalizations.of(context)!.search,
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: AppColors.iconColor),
                                ),
                                style: const TextStyle(
                                    fontSize: 13, color: AppColors.iconColor),
                                onChanged: (value) {
                                  BlocProvider.of<SearchValueBloc>(context).add(
                                      SearchValuePressed(
                                          menuCartSearchItems, value));
                                });
                          },
                        )
                      : BlocBuilder<CommonSearchValueBloc,
                          CommonSearchValueState>(
                          builder: (context, state) {
                            return TextField(
                                controller: CommonSearchValue,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(top: 5, bottom: 15),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Hide underline color
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Hide underline color
                                  ),
                                  hintText:
                                      AppLocalizations.of(context)!.search,
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: AppColors.iconColor),
                                ),
                                style: const TextStyle(
                                    fontSize: 14, color: AppColors.iconColor),
                                cursorColor:
                                    AppColors.iconColor, // Set cursor color
                                onChanged: (value) {
                                  BlocProvider.of<CommonSearchValueBloc>(
                                          context)
                                      .add(CommonSearchValuePressed(
                                          menuItems, value));
                                });
                          },
                        ),
                ),
                isCart!
                    ? BlocBuilder<SearchValueBloc, SearchValueState>(
                        builder: (context, state) {
                          return BlocBuilder<ChangeLanguageBloc,
                              ChangeLanguageState>(
                            builder: (context, state) {
                              Locale? languageName1;
                              // languageName1 = languageName;
                              // print("manaauagaug nama=${languageName}");

                              if (state is ChangeLanguageSuccess) {
                                languageName1 = state.name;
                                print("languageName1=${languageName1}");
                              }
                              return SizedBox(
                                width: 120,
                                child: Visibility(
                                  visible:
                                      (searchValue.text != "") ? false : true,
                                  child: CarouselSlider(
                                      disableGesture: true,
                                      options: CarouselOptions(
                                        aspectRatio: 1.0,
                                        animateToClosest: true,
                                        autoPlayCurve: Curves.linear,
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 120),
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.vertical,
                                        autoPlay: true,
                                      ),
                                      items: languageName1 == const Locale('ar')
                                          ? imageSlidersArabic
                                          : imageSliders),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : BlocBuilder<CommonSearchValueBloc,
                        CommonSearchValueState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: 120,
                            child: Visibility(
                              visible:
                                  (CommonSearchValue.text != "") ? false : true,
                              child: BlocBuilder<ChangeLanguageBloc,
                                  ChangeLanguageState>(
                                builder: (context, state) {
                                  Locale? languageName1;
                                  // languageName1 = languageName;
                                  // print("manaauagaug nama=${languageName}");

                                  if (state is ChangeLanguageSuccess) {
                                    languageName1 = state.name;
                                    print("languageName1=${languageName1}");
                                  }
                                  return CarouselSlider(
                                    disableGesture: true,
                                    options: CarouselOptions(
                                      aspectRatio: 1.0,
                                      animateToClosest: true,
                                      autoPlayCurve: Curves.linear,
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 120),
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.vertical,
                                      autoPlay: true,
                                    ),
                                    items: languageName1 == const Locale('ar')
                                        ? imageSlidersArabic
                                        : imageSliders,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
