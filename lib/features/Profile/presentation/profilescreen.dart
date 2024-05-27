import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/features/Profile/domain/repository/profile_repository.dart';
import 'package:pos_application/features/Profile/presentation/bloc/profile_event.dart';
import 'package:pos_application/features/Profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileStateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile success...='),
            ),
          );
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final profileBloc = BlocProvider.of<ProfileBloc>(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            body: GestureDetector(
              onTap:(){
                profileBloc.add(ProfileButtonPressed());
              },
              child: const Center(
                child: Text('Profile Page'),
              ),
            ),
          );
        },
      ),
    );
  }
}
