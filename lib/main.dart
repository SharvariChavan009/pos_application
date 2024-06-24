import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pos_application/controller/change_language_state.dart';
import 'package:pos_application/features/setting/bloc/menu_setting_bloc.dart';
import 'package:provider/provider.dart';
import 'controller/change_language_bloc.dart';
import 'controller/language_change_controller.dart';
import 'core/common/colors.dart';
import 'core/routes/custom_router.dart';
import 'features/Profile/domain/repository/profile_repository.dart';
import 'features/auth/domain/repository/forgot_password_repository.dart';
import 'features/auth/domain/repository/login_repository.dart';
import 'features/auth/domain/repository/reset_password_repository.dart';
import 'features/auth/presentation/bloc/password_validation_bloc.dart';
import 'features/auth/presentation/bloc/textfield_validation_bloc.dart';
import 'features/auth/presentation/bloc/update_timer_bloc.dart';
import 'features/home/domain/repository/cancel_order_repository.dart';
import 'features/home/domain/repository/floor_table_repository.dart';
import 'features/home/domain/repository/logout_repository.dart';
import 'features/home/domain/repository/menus_repository.dart';
import 'features/home/domain/repository/place_order_repository.dart';
import 'features/home/domain/repository/set_table_repository.dart';
import 'features/home/presentation/bloc/common_search_bar/common_search_bar_bloc.dart';
import 'features/home/presentation/bloc/connectivity.dart';
import 'features/home/presentation/bloc/menu_categories/menu_categories_bloc.dart';
import 'features/home/presentation/bloc/menu_name_bloc.dart';
import 'features/home/presentation/bloc/search_bar/search_value_bloc.dart';
import 'features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
import 'features/home/presentation/bloc/table_bloc/set_selected_floor_table_bloc.dart';
import 'features/menu/domain/add_menu_to_cart_repository.dart';
import 'features/orders/domain/repository/order_list_repository.dart';
import 'features/payment/domain/repository/payment_list_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('LanguageData');
  _fetchLanguage(box);
  runApp(const MyApp());
}
Locale? selectedLanguage = Locale('en');
Locale _fetchLanguage(Box? box) {
  String? storedLanguage = box!.get('language', defaultValue: 'en');
  selectedLanguage = Locale(storedLanguage!);
  print("selectedLanguage=${selectedLanguage}");
  return Locale(storedLanguage!);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ChangeLanguageBloc()),
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => ForgotPasswordBloc()),
          BlocProvider(create: (context) => ResetPasswordBloc()),
          BlocProvider(create: (context) => LogoutBloc()),
          BlocProvider(create: (context) => ProfileBloc()),
          BlocProvider(create: (context) => MenuListBloc()),
          BlocProvider(create: (context) => FloorTableBloc()),
          BlocProvider(create: (context) => MenuNameBloc()),
          BlocProvider(create: (context) => SearchValueBloc()),
          BlocProvider(create: (context) => CommonSearchValueBloc()),
          BlocProvider(create: (context) => UpdateTimerBloc()),
          BlocProvider(create: (context) => AddMenuToCartBloc()),
          BlocProvider(create: (context) => SetTableBloc()),
          BlocProvider(create: (context) => SetSelectedFloorTableBloc()),
          BlocProvider(create: (context) => PlaceOrderBloc()),
          BlocProvider(create: (context) => CancelOrderBloc()),
          BlocProvider(create: (context) => OrderListBloc()),
          BlocProvider(create: (context) => FloorTableSortBloc()),
          BlocProvider(create: (context) => PaymentListBloc()),
          BlocProvider(create: (context) => MenuSettingBloc()),
          BlocProvider<ConnectivityBloc>(
            create: (BuildContext context) => ConnectivityBloc(),
          ),
          BlocProvider<TextFieldValidationBloc>(
            create: (context) =>
                TextFieldValidationBloc(borderColor: AppColors.secondaryColor),
          ),
          BlocProvider<PasswordValidationBloc>(
            create: (context) =>
                PasswordValidationBloc(borderColor: AppColors.secondaryColor),
          ),
          BlocProvider(create: (context) => FloorTableStatus(floorTables: [])),
          BlocProvider(create: (context) => MenuCategoriesBloc([])),
        ],
        child: BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
          builder: (context, state) {
            Locale? languageName;
            languageName = selectedLanguage;
            if(state is ChangeLanguageSuccess){
              languageName = state.name;
            }
            print("languagae name =${languageName}");
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'POS Applications',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              routerConfig: customRouter,
              locale: languageName,
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
            );
          },
        )


    );
  }
}

