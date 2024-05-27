import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/core/common/label.dart';
import 'package:pos_application/core/images/image.dart';
import 'package:pos_application/features/Profile/domain/repository/profile_repository.dart';
import 'package:pos_application/features/Profile/presentation/bloc/profile_event.dart';
import 'package:pos_application/features/Profile/presentation/bloc/profile_state.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({super.key});

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: CircleAvatar(
            minRadius: 20,
            maxRadius: 20,
            child: Image.asset(AppImage.appLogo3),
          ),
        ),
        Expanded(
          flex: 3,
          child: FittedBox(
              fit: BoxFit.fitWidth,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileStateInitial){
                    BlocProvider.of<ProfileBloc>(context).add(ProfileButtonPressed());
                  }
                  if(state is ProfileStateSuccess) {
                    return AutoSizeText(
                      'Welcome to ${state.user.user.name}',
                      textAlign: TextAlign.center,
                      minFontSize: 12,
                      maxFontSize: 16,
                      style: CustomLabels.textTextStyle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      presetFontSizes: const [13],
                    );
                  }else{
                    return AutoSizeText(
                      'Welcome to ',
                      textAlign: TextAlign.center,
                      minFontSize: 12,
                      maxFontSize: 16,
                      style: CustomLabels.textTextStyle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      presetFontSizes: const [13],
                    );
                  }
                },
              )),
        ),
      ],
    );
  }
}
