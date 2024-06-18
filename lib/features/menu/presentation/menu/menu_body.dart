import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/features/auth/presentation/bloc/update_timer_bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/update_timer_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/update_timer_state.dart';
import 'package:pos_application/features/home/data/menu_list.dart';
import 'package:pos_application/features/home/domain/repository/menus_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_categories/menu_categories_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_list_event.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_list_state.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_state.dart';
import 'package:pos_application/features/home/presentation/home_components/parts/food_item_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../home/presentation/bloc/common_search_bar/common_search_bar_bloc.dart';
import '../../../home/presentation/bloc/common_search_bar/common_search_bar_state.dart';
import '../../../home/presentation/home_components/side_order/add_item.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

bool enabled = true;

class ListOfMenus extends StatelessWidget {
  const ListOfMenus({super.key});

  @override
  Widget build(BuildContext context) {
    List<MenuItem> menuItems = [];
    List<MenuItem> tempMenuItems = [];
    var optionName = AppLocalizations.of(context);

    return BlocBuilder<MenuNameBloc, MenuNameState>(builder: (context, state) {
      if (state is MenuNameFetchedSuccess && state.name == 'Menu') {
        final menuBloc = BlocProvider.of<MenuListBloc>(context);
        menuBloc.add(MenuListButtonPressed());
        return BlocBuilder<MenuListBloc, MenuListState>(
          builder: (context, state) {
            return BlocListener<MenuListBloc, MenuListState>(
              listener: (context, state) {
                if (state is MenuListStateSuccess) {
                  menuItems = state.menus;
                  tempMenuItems = menuItems.where((item) => item.active).toList();
                  BlocProvider.of<UpdateTimerBloc>(context)
                      .add(UpdateTimerPressed());
                } else {
                  tempMenuItems = menuItems;
                }
                List<MenuCategories> menuCategories = [];
                for (int i = 0; i < tempMenuItems.length; i++) {
                  for (int j = 0;
                      j < tempMenuItems[i].menuCategories.length;
                      j++) {
                    if (menuCategories
                        .where((element) =>
                            element.id == tempMenuItems[i].menuCategories[j].id)
                        .isEmpty) {
                      menuCategories.add(tempMenuItems[i].menuCategories[j]);
                    }
                  }
                }

                BlocProvider.of<MenuCategoriesBloc>(context)
                    .setCategories(menuCategories);
              },
              child: Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 0),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppColors.iconColor, width: .5),
                          ),
                        ),
                        child:  Row(
                          children: [
                            Text(
                              optionName!.menuList,
                              style: const TextStyle(
                                  letterSpacing: .8,
                                  color: AppColors.whiteColor,
                                  fontFamily: CustomLabels.primaryFont,
                                  fontWeight: CustomLabels.mediumFontWeight,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const FittedBox(
                                child: AddItem(
                              isCart: false,
                            ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<MenuCategoriesBloc, List<MenuCategories>>(
                        builder: (context, menuCategories) {
                      return Wrap(
                        spacing: 10.0,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runSpacing: 2,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        children: List<Widget>.generate(
                          menuCategories.length,
                          (int index) {
                            return ChoiceChip(
                              side: BorderSide.none,
                              backgroundColor: AppColors.primaryColor,
                              elevation: 4,
                              selectedColor:
                                  AppColors.secondaryColor.withOpacity(.8),
                              showCheckmark: false,
                              pressElevation: 3,
                              label: Text(
                                menuCategories[index].name,
                                style: const TextStyle(color: AppColors.whiteColor),
                              ),
                              selected: menuCategories[index].isSelected,
                              onSelected: (bool selected) {
                                menuCategories[index].isSelected = selected;
                                BlocProvider.of<MenuCategoriesBloc>(context)
                                    .setCategories(menuCategories);
                              },
                            );
                          },
                        ).toList(),
                      );
                    }),
                    Expanded(
                      flex: 11,
                      child: BlocBuilder<CommonSearchValueBloc,
                          CommonSearchValueState>(
                        builder: (context, state) {
                          List<MenuItem> allMenuItems = [];
                          if (state is CommonSearchValueSuccess) {
                            tempMenuItems = state.searchedFoodItem;
                            allMenuItems = tempMenuItems;
                          }
                          return BlocBuilder<MenuCategoriesBloc,
                                  List<MenuCategories>>(
                              builder: (context, menuCategories) {
                            allMenuItems = tempMenuItems;
                            List<MenuCategories> selectedCategories =
                                menuCategories
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList();
                            if (selectedCategories.isNotEmpty) {
                              allMenuItems = [];
                              for (var i = 0; i < tempMenuItems.length; i++) {
                                for (int j = 0;
                                    j < selectedCategories.length;
                                    j++) {
                                  if (tempMenuItems[i]
                                      .menuCategories
                                      .where((element) =>
                                          element.id ==
                                          selectedCategories[j].id)
                                      .isNotEmpty) {
                                    allMenuItems.add(tempMenuItems[i]);
                                    break;
                                  }
                                }
                              }
                            }
                            return Container(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: BlocBuilder<UpdateTimerBloc,
                                  UpdateTimerState>(
                                builder: (context, state) {
                                  if (state is UpdateTimerSuccess) {}
                                  return Skeletonizer(
                                    enabled: (state is UpdateTimerSuccess)
                                        ? false
                                        : true,
                                    child: GridView.builder(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      cacheExtent: 10,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisExtent: 250,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                      ),
                                      itemCount: allMenuItems.length,
                                      itemBuilder: (context, index) {
                                        return FoodItemCard(
                                            foodItem: allMenuItems[index]);
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Container();
      }
    });
  }
}
