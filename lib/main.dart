import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pos_application/features/auth/domain/repository/forgot_password_repository.dart';
import 'package:pos_application/features/auth/domain/repository/login_repository.dart';
import 'package:pos_application/features/auth/domain/repository/reset_password_repository.dart';
import 'package:pos_application/features/auth/presentation/bloc/password_validation_bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/textfield_validation_bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/update_timer_bloc.dart';
import 'package:pos_application/features/home/domain/repository/cancel_order_repository.dart';
import 'package:pos_application/features/home/domain/repository/floor_table_repository.dart';
import 'package:pos_application/features/home/domain/repository/logout_repository.dart';
import 'package:pos_application/features/home/domain/repository/menus_repository.dart';
import 'package:pos_application/features/Profile/domain/repository/profile_repository.dart';
import 'package:pos_application/features/home/domain/repository/place_order_repository.dart';
import 'package:pos_application/features/home/domain/repository/set_table_repository.dart';
import 'package:pos_application/features/home/presentation/bloc/common_search_bar/common_search_bar_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/connectivity.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_name_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/search_bar/search_value_bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/set_selected_floor_table_bloc.dart';
import 'package:pos_application/features/orders/domain/repository/order_list_repository.dart';
import 'package:pos_application/features/payment/domain/repository/payment_list_bloc.dart';
import 'core/common/colors.dart';
import 'core/routes/custom_router.dart';
import 'features/home/presentation/bloc/menu_categories/menu_categories_bloc.dart';
import 'features/home/presentation/bloc/table_bloc/floor_table_status_bloc.dart';
import 'features/menu/domain/add_menu_to_cart_repository.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'POS Applications',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: customRouter,
      ),
    );
  }
}
